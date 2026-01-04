using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HR_System.Admin.Promotion
{
    public partial class Promotion : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        private string SortColumn
        {
            get { return ViewState["SortColumn"]?.ToString() ?? "PromotionDate"; }
            set { ViewState["SortColumn"] = value; }
        }

        private string SortDirection
        {
            get { return ViewState["SortDirection"]?.ToString() ?? "DESC"; }
            set { ViewState["SortDirection"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("sp_Promotion_GetAll", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SearchEmployee", txtSearchEmployee.Text.Trim());
                    cmd.Parameters.AddWithValue("@FromDate", string.IsNullOrEmpty(txtFromDate.Text) ? (object)DBNull.Value : DateTime.Parse(txtFromDate.Text));
                    cmd.Parameters.AddWithValue("@ToDate", string.IsNullOrEmpty(txtToDate.Text) ? (object)DBNull.Value : DateTime.Parse(txtToDate.Text));
                    cmd.Parameters.AddWithValue("@SortColumn", SortColumn);
                    cmd.Parameters.AddWithValue("@SortOrder", SortDirection);

                    conn.Open();
                    gvPromotion.DataSource = cmd.ExecuteReader();
                    gvPromotion.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(
                    hfPromotionID.Value == "" ? "sp_Promotion_Insert" : "sp_Promotion_Update", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!string.IsNullOrEmpty(hfPromotionID.Value))
                        cmd.Parameters.AddWithValue("@PromotionID", int.Parse(hfPromotionID.Value));

                    cmd.Parameters.AddWithValue("@EmployeeName", txtEmployeeName.Text.Trim());
                    cmd.Parameters.AddWithValue("@DesignationFrom", txtFrom.Text.Trim());
                    cmd.Parameters.AddWithValue("@DesignationTo", txtTo.Text.Trim());
                    cmd.Parameters.AddWithValue("@PromotionDate", DateTime.Parse(txtPromotionDate.Text));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ClearForm();
            BindGrid();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfPromotionID.Value = "";
            txtEmployeeName.Text = "";
            txtFrom.Text = "";
            txtTo.Text = "";
            txtPromotionDate.Text = "";
        }

        protected void gvPromotion_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "EditRow")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Promotion_GetById", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PromotionID", id);
                        conn.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                hfPromotionID.Value = dr["PromotionID"].ToString();
                                txtEmployeeName.Text = dr["EmployeeName"].ToString();
                                txtFrom.Text = dr["DesignationFrom"].ToString();
                                txtTo.Text = dr["DesignationTo"].ToString();
                                txtPromotionDate.Text = Convert.ToDateTime(dr["PromotionDate"]).ToString("yyyy-MM-dd");
                            }
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Promotion_Delete", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PromotionID", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                BindGrid();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void gvPromotion_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
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
    }
}
