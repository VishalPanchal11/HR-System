using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System   
{
    public partial class AddProject : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPriceTypes();
                LoadUsers();
                LoadManagers();
            }
        }

        void LoadPriceTypes()
        {
            ddlPriceType.Items.Clear();
            ddlPriceType.Items.Add("Select Currency Type");
            ddlPriceType.Items.Add("$");
            ddlPriceType.Items.Add("₹");
            ddlPriceType.Items.Add("€");
        }

        void LoadUsers()
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT UserId, FirstName FROM [User] WHERE Status='Active'", con);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            chkUsers.DataSource = dr;
            chkUsers.DataTextField = "FirstName";
            chkUsers.DataValueField = "UserId";
            chkUsers.DataBind();

            dr.Close();
            con.Close();
        }

        void LoadManagers()
        {
            SqlCommand cmd = new SqlCommand("sp_User_GetManagers", con);
            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            ddlManager.DataSource = dr;
            ddlManager.DataTextField = "FirstName";
            ddlManager.DataValueField = "FirstName"; 
            ddlManager.DataBind();

            dr.Close();
            con.Close();

            ddlManager.Items.Insert(0, "Select Project Manager");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!ValidateForm()) return;

            string logoPath = SaveFile(fuLogo);
            string filePath = SaveFile(fuFile);

            SqlCommand cmd = new SqlCommand("sp_AllProjects_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ProjectName", txtProjectName.Text.Trim());
            cmd.Parameters.AddWithValue("@ClientName", txtClientName.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
            cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
            cmd.Parameters.AddWithValue("@Priority", ddlPriority.SelectedValue);
            cmd.Parameters.AddWithValue("@ProjectValue", txtProjectValue.Text);
            cmd.Parameters.AddWithValue("@PriceType", ddlPriceType.SelectedValue);
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@ManagerName", ddlManager.SelectedValue);
            cmd.Parameters.AddWithValue("@LogoPath", logoPath);
            cmd.Parameters.AddWithValue("@FilePath", filePath);

            con.Open();
            int projectId = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            SaveTeamMembers(projectId);

            Response.Redirect("ProjectList.aspx");
        }

        bool ValidateForm()
        {
            if (txtProjectName.Text == "") { ShowAlert("Project Name is required"); return false; }
            if (txtClientName.Text == "") { ShowAlert("Client Name is required"); return false; }
            if (txtDescription.Text == "") { ShowAlert("Description is required"); return false; }
            if (txtStartDate.Text == "") { ShowAlert("Start Date is required"); return false; }
            if (txtEndDate.Text == "") { ShowAlert("End Date is required"); return false; }
            if (ddlPriority.SelectedValue == "") { ShowAlert("Select Priority"); return false; }
            if (ddlPriceType.SelectedIndex == 0) { ShowAlert("Select Price Type"); return false; }
            if (ddlStatus.SelectedValue == "") { ShowAlert("Select Status"); return false; }
            if (ddlManager.SelectedIndex == 0) { ShowAlert("Select Project Manager"); return false; }

            DateTime s = Convert.ToDateTime(txtStartDate.Text);
            DateTime e = Convert.ToDateTime(txtEndDate.Text);
            if (s > e) { ShowAlert("Start Date cannot be greater than End Date"); return false; }

            if (!double.TryParse(txtProjectValue.Text, out double v) || v <= 0)
            {
                ShowAlert("Project Value must be valid number");
                return false;
            }

            return true;
        }

        void ShowAlert(string msg)
        {
            ScriptManager.RegisterStartupScript(
                this, GetType(), "alert", $"alert('{msg}');", true);
        }

        void SaveTeamMembers(int projectId)
        {
            con.Open();

            foreach (ListItem item in chkUsers.Items)
            {
                if (item.Selected)
                {
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO ProjectsUser (ProjectsProjectId, UsersUserId) VALUES (@PId, @UId)", con);

                    cmd.Parameters.AddWithValue("@PId", projectId);
                    cmd.Parameters.AddWithValue("@UId", item.Value);
                    cmd.ExecuteNonQuery();
                }
            }

            con.Close();
        }

        string SaveFile(FileUpload fu)
        {
            if (!fu.HasFile) return "";

            string folder = Server.MapPath("~/Uploads/");
            if (!Directory.Exists(folder)) Directory.CreateDirectory(folder);

            string fileName = Guid.NewGuid() + "_" + fu.FileName;
            fu.SaveAs(folder + fileName);

            return "Uploads/" + fileName;
        }
    }
}
