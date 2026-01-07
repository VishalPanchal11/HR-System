using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Attendance
{
    public partial class Timesheet : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
        }

        protected void btnApproveSelected_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvTimesheet.Rows)
            {
                CheckBox chkSelect = row.FindControl("chkSelect") as CheckBox;
                if (chkSelect != null && chkSelect.Checked)
                {
                    int timesheetId = Convert.ToInt32(gvTimesheet.DataKeys[row.RowIndex].Value);
                    SqlCommand cmd = new SqlCommand("Pro_StatusAppr_Timesheets", conn);
                    cmd.Parameters.AddWithValue("@TimesheetId", timesheetId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnRejectSelected_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvTimesheet.Rows)
            {
                CheckBox chkSelect = row.FindControl("chkSelect") as CheckBox;
                if (chkSelect != null && chkSelect.Checked)
                {
                    int timesheetId = Convert.ToInt32(gvTimesheet.DataKeys[row.RowIndex].Value);
                    SqlCommand cmd = new SqlCommand("Pro_StatusRejec_Timesheets", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TimesheetId", timesheetId);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}