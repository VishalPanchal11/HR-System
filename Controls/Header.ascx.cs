using System;

namespace HR_System.Controls
{
    public partial class Header : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null || Session["RoleName"] == null)
            {
                Response.Redirect("~/Auth/Login.aspx");
                return;
            }

            string role = Session["RoleName"].ToString();

            if (role == "Admin")
            {
                lnkProfile.NavigateUrl = "~/Admin/Employee/AdminProfile.aspx";
            }
            else if (role == "Manager")
            {
                lnkProfile.NavigateUrl = "#";
            }
            else if (role == "Employee")
            {
                lnkProfile.NavigateUrl = "~/Employee/EmployeeProfile.aspx";
            }
        }
    }
}
