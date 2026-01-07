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
    public partial class DepartmentLeave : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
        }

        protected void DeptLeaveDel(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDepartmentLeaves.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("Pro_DelLeave_Dept", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DepartmentLeavesId", id);
            cmd.ExecuteNonQuery();
        }
    }
}