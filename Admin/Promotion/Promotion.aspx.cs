using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Promotion
{
    public partial class Promotion : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("sp_Promotion_GetAll", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SearchEmployee", txtSearchEmployee.Text.Trim());

                    if (ddlDateFilter.SelectedValue == "Today")
                    {
                        cmd.Parameters.AddWithValue("@FromDate", DateTime.Today);
                        cmd.Parameters.AddWithValue("@ToDate", DateTime.Today.AddHours(23).AddMinutes(59));
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@FromDate", DBNull.Value);
                        cmd.Parameters.AddWithValue("@ToDate", DBNull.Value);
                    }

                    cmd.Parameters.AddWithValue("@SortColumn", "PromotionDate");
                    cmd.Parameters.AddWithValue("@SortOrder", ddlSort.SelectedValue);

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
                string proc = string.IsNullOrEmpty(hfPromotionID.Value) ? "sp_Promotion_Insert" : "sp_Promotion_Update";
                using (SqlCommand cmd = new SqlCommand(proc, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (!string.IsNullOrEmpty(hfPromotionID.Value))
                        cmd.Parameters.AddWithValue("@PromotionID", hfPromotionID.Value);

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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlForm.Visible = true;
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

        protected void gvPromotion_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "EditRow")
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_Promotion_GetById", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PromotionID", id);
                        conn.Open();
                        SqlDataReader dr = cmd.ExecuteReader();
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
    }
}