using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace HR_System.Auth
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString))
            {
                string query = @"
                    SELECT u.UserId, r.RoleName
                    FROM [User] u
                    INNER JOIN [Role] r ON u.RoleId = r.RoleId
                    WHERE u.Email = @Email
                      AND u.PasswordHash = @Password
                      AND u.Status = 'Active'";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["UserId"] = dr["UserId"];
                    Session["RoleName"] = dr["RoleName"].ToString();

                    // Role-based redirect
                    if (Session["RoleName"].ToString() == "Admin")
                        Response.Redirect("~/Admin/Employee/Departments.aspx");
                    else if (Session["RoleName"].ToString() == "Manager")
                        Response.Redirect("~/Manager/Timesheets.aspx");
                    else if (Session["RoleName"].ToString() == "Employee")
                        Response.Redirect("~/Employee/EmployeeProfile.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid email or password";
                }
            }
        }
    }
}
