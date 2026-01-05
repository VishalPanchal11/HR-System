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

            // Reset all
            pnlAdmin.Visible = false;
            pnlEmployee.Visible = false;
            pnlManager.Visible = false;

            if (role == "Admin")
            {
                pnlAdmin.Visible = true;
            }
            else if (role == "Employee")
            {
                pnlEmployee.Visible = true;
            }
            else if (role == "Manager")
            {
                pnlManager.Visible = true;
            }
        }
    }
}
