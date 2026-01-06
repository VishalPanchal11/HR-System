using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_System.Admin.Resignation
{
    public partial class Resignation : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        void BindGrid(string sort = "", string search = "", DateTime? from = null, DateTime? to = null)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT 
                                    ResignationID,
                                    UserID,
                                    DepartmentId,
                                    Reason,
                                    NoticeDate,
                                    ResignDate
                                 FROM Resignation";

                // SEARCH (Reason based)
                if (!string.IsNullOrEmpty(search))
                    query += " WHERE Reason LIKE @Search";

                // DATE FILTER
                if (from.HasValue && to.HasValue)
                    query += string.IsNullOrEmpty(search)
                        ? " WHERE ResignDate BETWEEN @From AND @To"
                        : " AND ResignDate BETWEEN @From AND @To";

                // SORT
                if (!string.IsNullOrEmpty(sort))
                    query += " ORDER BY ResignDate " + sort;

                SqlCommand cmd = new SqlCommand(query, con);

                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");

                if (from.HasValue && to.HasValue)
                {
                    cmd.Parameters.AddWithValue("@From", from);
                    cmd.Parameters.AddWithValue("@To", to);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResignation.DataSource = dt;
                gvResignation.DataBind();

                lblTotal.Text = $"Showing {dt.Rows.Count} entries";
            }
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid(ddlSort.SelectedValue);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            DateTime? from = string.IsNullOrEmpty(txtFromDate.Text)
                ? (DateTime?)null
                : DateTime.Parse(txtFromDate.Text);

            DateTime? to = string.IsNullOrEmpty(txtToDate.Text)
                ? (DateTime?)null
                : DateTime.Parse(txtToDate.Text);

            BindGrid(ddlSort.SelectedValue, txtSearch.Text, from, to);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindGrid(ddlSort.SelectedValue, txtSearch.Text);
        }

        protected void gvResignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvResignation.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void gvResignation_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "DeleteRow")
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Resignation WHERE ResignationID = @ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                BindGrid();
            }

            if (e.CommandName == "EditRow")
            {
                Response.Redirect("EditResignation.aspx?id=" + id);
            }
        }
    }
}