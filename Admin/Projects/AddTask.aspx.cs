using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

namespace HR_System
{
    public partial class AddTask : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadProjects();
        }

        void LoadProjects()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand("sp_Task_GetProjects", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();

                ddlProject.DataSource = cmd.ExecuteReader();
                ddlProject.DataTextField = "ProjectName";
                ddlProject.DataValueField = "ProjectId";
                ddlProject.DataBind();
            }

            ddlProject.Items.Insert(0,
                new System.Web.UI.WebControls.ListItem("Select Project", ""));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtTitle.Text == "" ||
                ddlProject.SelectedValue == "" ||
                ddlStatus.SelectedValue == "" ||
                ddlPriority.SelectedValue == "")
            {
                lblMsg.Text = "Please fill all required fields";
                return;
            }

            string filePath = "";
            if (fuFile.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/Tasks/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName = Guid.NewGuid() + Path.GetExtension(fuFile.FileName);
                fuFile.SaveAs(folder + fileName);
                filePath = "Uploads/Tasks/" + fileName;
            }

            int taskId;
            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd = new SqlCommand("sp_Task_Insert", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProjectId", ddlProject.SelectedValue);
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Priority", ddlPriority.SelectedValue);
                cmd.Parameters.AddWithValue("@FilePath", filePath);
                cmd.Parameters.AddWithValue("@Deadline", txtDeadline.Text);

                con.Open();
                taskId = Convert.ToInt32(cmd.ExecuteScalar());
            }

            string[] members = Request.Form.GetValues("MemberIds");
            if (members != null)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    foreach (string uid in members)
                    {
                        SqlCommand mcmd = new SqlCommand("sp_TaskMember_Insert", con);
                        mcmd.CommandType = CommandType.StoredProcedure;
                        mcmd.Parameters.AddWithValue("@TaskId", taskId);
                        mcmd.Parameters.AddWithValue("@UserId", uid);
                        mcmd.ExecuteNonQuery();
                    }
                }
            }

            Response.Redirect("TaskList.aspx");
        }

        [WebMethod]
        public static List<MemberVM> GetProjectMembers(int projectId)
        {
            List<MemberVM> list = new List<MemberVM>();
            string conStr =
                ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            using (SqlCommand cmd =
                new SqlCommand("sp_Task_GetProjectMembers", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProjectId", projectId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    list.Add(new MemberVM
                    {
                        UserId = Convert.ToInt32(dr["UserId"]),
                        FullName = dr["FullName"].ToString()
                    });
                }
            }
            return list;
        }
    }

    public class MemberVM
    {
        public int UserId { get; set; }
        public string FullName { get; set; }
    }
}