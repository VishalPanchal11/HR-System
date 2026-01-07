using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Masters
{
    public partial class EmployeeMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RoleName"] == null || Session["RoleName"].ToString() != "Employee")
            {
                Response.Redirect("~/Auth/Login.aspx");
            }
        }
    }
}