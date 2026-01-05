using System;

namespace HR_System.Controls
{
    public partial class SideBar : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RoleName"] == null)
            {
                Response.Redirect("~/Auth/Login.aspx");
                return;
            }

            string role = Session["RoleName"].ToString();

            // Admin
            pnlAdmin.Visible = role == "Admin";

            // Employee
            pnlEmployee.Visible = role == "Employee";

            // Manager → NO sidebar at all
            pnlSidebar.Visible = role != "Manager";
        }
    }
}
