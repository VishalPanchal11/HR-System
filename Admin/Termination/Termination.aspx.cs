using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HR_System.Admin.Termination
{
    public partial class Termination : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        string SortColumn
        {
            get
            {
                if (ViewState["SortColumn"] == null) return "ResignDate";
                return ViewState["SortColumn"].ToString();
            }
            set { ViewState["SortColumn"] = value; }
        }

        string SortDirection
        {
            get
            {
                if (ViewState["SortDirection"] == null) return "DESC";
                return ViewState["SortDirection"].ToString();
            }
            set { ViewState["SortDirection"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("sp_Termination_GetAll", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchType", txtSearchType.Text.Trim());
                cmd.Parameters.AddWithValue("@FromDate", string.IsNullOrEmpty(txtFromDate.Text) ? (object)DBNull.Value : DateTime.Parse(txtFromDate.Text));
                cmd.Parameters.AddWithValue("@ToDate", string.IsNullOrEmpty(txtToDate.Text) ? (object)DBNull.Value : DateTime.Parse(txtToDate.Text));
                cmd.Parameters.AddWithValue("@SortColumn", SortColumn);
                cmd.Parameters.AddWithValue("@SortOrder", SortDirection);

                con.Open();
                gvTermination.DataSource = cmd.ExecuteReader();
                gvTermination.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                hfTerminationId.Value == "" ? "sp_Termination_Insert" : "sp_Termination_Update", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (hfTerminationId.Value != "")
                    cmd.Parameters.AddWithValue("@TerminationId", hfTerminationId.Value);

                cmd.Parameters.AddWithValue("@UserID", txtUserID.Text);
                cmd.Parameters.AddWithValue("@TerminationType", txtTerminationType.Text);
                cmd.Parameters.AddWithValue("@NoticeDate", DateTime.Parse(txtNoticeDate.Text));
                cmd.Parameters.AddWithValue("@ResignDate", DateTime.Parse(txtResignDate.Text));
                cmd.Parameters.AddWithValue("@Reason", txtReason.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Clear();
            BindGrid();
        }

        void Clear()
        {
            hfTerminationId.Value = "";
            txtUserID.Text = "";
            txtTerminationType.Text = "";
            txtNoticeDate.Text = "";
            txtResignDate.Text = "";
            txtReason.Text = "";
        }

        protected void gvTermination_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "EditRow")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("sp_Termination_GetById", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TerminationId", id);
                    con.Open();
                    var dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        hfTerminationId.Value = dr["TerminationId"].ToString();
                        txtUserID.Text = dr["UserID"].ToString();
                        txtTerminationType.Text = dr["TerminationType"].ToString();
                        txtNoticeDate.Text = Convert.ToDateTime(dr["NoticeDate"]).ToString("yyyy-MM-dd");
                        txtResignDate.Text = Convert.ToDateTime(dr["ResignDate"]).ToString("yyyy-MM-dd");
                        txtReason.Text = dr["Reason"].ToString();
                    }
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("sp_Termination_Delete", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TerminationId", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvTermination_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
        {
            if (SortColumn == e.SortExpression)
                SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
            else
            {
                SortColumn = e.SortExpression;
                SortDirection = "ASC";
            }
            BindGrid();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}
