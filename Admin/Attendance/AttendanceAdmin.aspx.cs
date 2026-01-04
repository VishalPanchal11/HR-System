using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Attendance
{
    public partial class AttendanceAdmin : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string str = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
            conn = new SqlConnection(str);
            conn.Open();
        }

        protected void AttendanceadminEdit(object sender, GridViewEditEventArgs e)
        {


        }

        protected void AttendanceAdmin_edit(object sender, EventArgs e)
        {
            string date = txtDate.Text;
            string checkIn = txtCheckIn.Text;
            string checkout = txtCheckOut.Text;
            string Break = txtBreak.Text;
            string late = txtLate.Text;
            string Producthr = txtProduction.Text;
            string status = ddlEditStatus.SelectedItem.ToString();

            SqlCommand cmd = new SqlCommand("Pro_Attendanceadmin_edit", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@AttendanceId", hfAttendanceId.Value);
            cmd.Parameters.AddWithValue("@Date", txtDate.Text);
            cmd.Parameters.AddWithValue("@CheckIn", txtCheckIn.Text);
            cmd.Parameters.AddWithValue("@CheckOut", txtCheckOut.Text);
            cmd.Parameters.AddWithValue("@BreakHours", txtBreak.Text);
            cmd.Parameters.AddWithValue("@Late", txtLate.Text);
            cmd.Parameters.AddWithValue("@ProductionHours", txtProduction.Text);
            cmd.Parameters.AddWithValue("@Status", ddlEditStatus.SelectedValue);
            cmd.ExecuteNonQuery();

        }
    }
}