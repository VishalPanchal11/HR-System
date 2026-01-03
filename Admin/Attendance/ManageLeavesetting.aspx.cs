using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Attendance
{
    public partial class ManageLeavesetting : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
            if (!IsPostBack)
            {
                loadstatus();
            }
        }
        private void loadstatus()
        {
            SqlCommand cmd = new SqlCommand("SELECT LeaveTypeId, Status FROM DepartmentLeaves", conn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                bool active = dr["Status"].ToString() == "Active";

                switch (Convert.ToInt32(dr["LeaveTypeId"]))
                {
                    case 1: chkPaidLeave.Checked = active; break;
                    case 2: chkSickLeave.Checked = active; break;
                    case 3: chkCasualLeave.Checked = active; break;
                    case 4: chkMaternityLeave.Checked = active; break;
                }
            }

            dr.Close();
        }
        protected void LeaveStatusChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;

            int leaveId = Convert.ToInt32(chk.ToolTip);
             string status;
            if (chk.Checked) { status = "Active"; }
            else { status = "Inactive"; }
            SqlCommand cmd = new SqlCommand("Pro_leaveSetting", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@LeaveTypeId", leaveId);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.ExecuteNonQuery();
            }
    }

}
