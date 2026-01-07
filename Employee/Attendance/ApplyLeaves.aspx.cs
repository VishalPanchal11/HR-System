using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Employee.Attendance
{
    public partial class ApplyLeaves : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
            if (!IsPostBack)
            {
                dropdownLeave();
            }
        }
        public void dropdownLeave()
        {
            using (SqlCommand cmd = new SqlCommand("select LeaveTypeId,LeaveType from MasterLeaveTypes;", conn))
            {
                cmd.CommandType = CommandType.Text;
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    ddlLeaveType.DataSource = rdr;
                    ddlLeaveType.DataTextField = "LeaveType";
                    ddlLeaveType.DataValueField = "LeaveTypeId";
                    ddlLeaveType.DataBind();
                }
            }
        }
        protected void btnApply_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string leaveType = ddlLeaveType.SelectedValue;
            DateTime startDate = Convert.ToDateTime(txtStartDate.Text);
            DateTime endDate = Convert.ToDateTime(txtEndDate.Text);
            string reason = txtReason.Text;
            int numberOfDays =int.Parse(NOOFDAYS.Text);
            SqlCommand cmd = new SqlCommand("Pro_EmpApply_leaves", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@LeaveTypeId", leaveType);
            cmd.Parameters.AddWithValue("@StartDate", startDate);
            cmd.Parameters.AddWithValue("@EndDate", endDate);
            cmd.Parameters.AddWithValue("@Reason", reason);
            cmd.Parameters.AddWithValue("@NumberOfDays", numberOfDays);
            cmd.ExecuteNonQuery();
        }
    }
}