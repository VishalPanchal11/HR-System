using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin
{
    public partial class Resignation : Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrid();
            }
        }

        void LoadGrid()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_GetResignations1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResignation.DataSource = dt;
                gvResignation.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfResignationID.Value))
                InsertResignation();
            else
                UpdateResignation();

            ClearFields();
            LoadGrid();
        }

        void InsertResignation()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_InsertResignation1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserID", txtUserId.Text);
                cmd.Parameters.AddWithValue("@DepartmentId", txtDepartmentId.Text);
                cmd.Parameters.AddWithValue("@NoticeDate", txtNoticeDate.Text);
                cmd.Parameters.AddWithValue("@ResignDate", txtResignDate.Text);
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        void UpdateResignation()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_UpdateResignation1", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ResignationID", hfResignationID.Value);
                cmd.Parameters.AddWithValue("@UserID", txtUserId.Text);
                cmd.Parameters.AddWithValue("@DepartmentId", txtDepartmentId.Text);
                cmd.Parameters.AddWithValue("@NoticeDate", txtNoticeDate.Text);
                cmd.Parameters.AddWithValue("@ResignDate", txtResignDate.Text);
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvResignation_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvResignation.SelectedRow;

            hfResignationID.Value = gvResignation.DataKeys[row.RowIndex].Value.ToString();
            txtUserId.Text = row.Cells[2].Text;
            txtDepartmentId.Text = row.Cells[3].Text;
            txtNoticeDate.Text = Convert.ToDateTime(row.Cells[4].Text).ToString("yyyy-MM-dd");
            txtResignDate.Text = Convert.ToDateTime(row.Cells[5].Text).ToString("yyyy-MM-dd");
            txtReason.Text = row.Cells[6].Text;
        }

        protected void gvResignation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvResignation.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_DeleteResignation1", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ResignationID", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadGrid();
        }

        void ClearFields()
        {
            hfResignationID.Value = "";
            txtUserId.Text = "";
            txtDepartmentId.Text = "";
            txtNoticeDate.Text = "";
            txtResignDate.Text = "";
            txtReason.Text = "";
        }
    }
}
