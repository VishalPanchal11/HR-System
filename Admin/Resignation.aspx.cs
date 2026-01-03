using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            // ADMIN ONLY ACCESS
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadGrid();
            }
        }

        void LoadGrid()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_GetResignations", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);
                gvResignation.DataSource = dt;
                gvResignation.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("sp_InsertResignation", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserID", txtUserID.Text);
                cmd.Parameters.AddWithValue("@DepartmentId", txtDeptID.Text);
                cmd.Parameters.AddWithValue("@NoticeDate", txtNoticeDate.Text);
                cmd.Parameters.AddWithValue("@ResignDate", txtResignDate.Text);
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadGrid();
            Clear();
        }

        protected void gvResignation_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "del")
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("sp_DeleteResignation", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ResignationID", e.CommandArgument);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadGrid();
            }
        }

        void Clear()
        {
            txtUserID.Text = "";
            txtDeptID.Text = "";
            txtNoticeDate.Text = "";
            txtResignDate.Text = "";
            txtReason.Text = "";
        }
    }
}