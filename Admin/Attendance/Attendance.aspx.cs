using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Attendance
{
    public partial class Attendance : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
       
                string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
                conn = new SqlConnection(str);
                conn.Open();
        }

        protected void SubmitAddType(object sender, EventArgs e)
        {
            string leavetype = LeaveType.Text;
            SqlCommand cmd = new SqlCommand("Pro_InsertMasterLeaveTypes", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@LeaveType", leavetype);
            cmd.ExecuteNonQuery();
        }

        protected void gvLeaveTypes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            
            int id = Convert.ToInt32(gvLeaveTypes.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("Pro_DeleteMasterLeaveTypes", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@LeaveTypeId", id); 
            cmd.ExecuteNonQuery();
           
        }
    }
}   