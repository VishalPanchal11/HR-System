using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Attendance
{
    public partial class MasterPayroll : System.Web.UI.Page
    {
        SqlConnection conn;   
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
        }
        protected void Earning_Type_Button_On_Click(object sender, EventArgs e)
        {
            string earningType = TextBox.Text;
            SqlCommand cmd = new SqlCommand("Pro_InsertEarningType", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@LeaveType", leavetype);
            cmd.ExecuteNonQuery();
        }

        protected void EarningButton_On_Click(object sender, EventArgs e)
        {
            string earningType = TextBox.Text;
            SqlCommand cmd = new SqlCommand("Pro_InsertEarningType", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@LeaveType", leavetype);
            cmd.ExecuteNonQuery();
        }


    }
}