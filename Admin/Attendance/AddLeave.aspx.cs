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
    public partial class AddLeave : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
            if (!IsPostBack)
            {
                DropDownn();
            }
        }
        public void DropDownn()
        {
            using (SqlCommand cmd = new SqlCommand("SELECT DepartmentId,Name FROM Departments WHERE Status ='Active'", conn))
            { 
                cmd.CommandType = CommandType.Text;
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    ddlDepartment.DataSource = rdr;
                    ddlDepartment.DataTextField = "Name";
                    ddlDepartment.DataValueField = "DepartmentId";
                    ddlDepartment.DataBind();
                }
            }
            using (SqlCommand cmd1= new SqlCommand("SELECT LeaveTypeId,LeaveType from MasterLeaveTypes", conn))
            {
                cmd1.CommandType = CommandType.Text;
                using (SqlDataReader rd= cmd1.ExecuteReader())
                {
                    ddlLeaveType.DataSource = rd;
                    ddlLeaveType.DataTextField = "LeaveType";
                    ddlLeaveType.DataValueField = "LeaveTypeId";
                    ddlLeaveType.DataBind();
                }
            }

        }
        protected void btnAllocate_Click(object sender, EventArgs e)
        {
            string departmentname = ddlDepartment.SelectedValue;
            string leaveType = ddlLeaveType.SelectedValue;
            string Leaves = txtLeaves.Text;
            string status = ddlStatus.SelectedValue;
            SqlCommand cmd = new SqlCommand("Pro_AddLeave_Dept", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DepartmentId", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@LeaveTypeId", ddlLeaveType.SelectedValue);
            cmd.Parameters.AddWithValue("@LeavesCount",txtLeaves.Text);
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.ExecuteNonQuery();
   
        }
    }
}