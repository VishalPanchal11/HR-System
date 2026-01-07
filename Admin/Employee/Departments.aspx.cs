using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml; // EPPlus
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace HR_System.Admin.Employee
{
    public partial class Departments : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        string SortDir
        {
            get => ViewState["SortDir"]?.ToString() ?? "ASC";
            set => ViewState["SortDir"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        void BindGrid(string sortExpr = "", string status = "", string search = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("sp_GetDepartments", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Sort", sortExpr);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Search", search);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDepartments.DataSource = dt;
                gvDepartments.DataBind();
            }
        }

        private DataTable GetDepartmentsData()
        {
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("sp_GetDepartments", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Sort", ddlSort.SelectedValue);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@Search", txtSearch.Text);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvDepartments.PageSize = int.Parse(ddlPageSize.SelectedValue);
            BindGrid();
        }

        protected void gvDepartments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDepartments.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid(ddlSort.SelectedValue, ddlStatus.SelectedValue, txtSearch.Text);
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindGrid(ddlSort.SelectedValue, ddlStatus.SelectedValue, txtSearch.Text);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindGrid(ddlSort.SelectedValue, ddlStatus.SelectedValue, txtSearch.Text);
        }

        protected void gvDepartments_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (ViewState["SortDir"] == null || ViewState["SortDir"].ToString() == "DESC")
                ViewState["SortDir"] = "ASC";
            else
                ViewState["SortDir"] = "DESC";

            string sortColumn = e.SortExpression;
            string sortDir = ViewState["SortDir"].ToString();
            string sort = sortColumn + " " + sortDir;

            BindGrid(sort, ddlStatus.SelectedValue, txtSearch.Text.Trim());
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("sp_SaveDepartment", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DepartmentId",
                    string.IsNullOrEmpty(hfDeptId.Value) ? (object)DBNull.Value : hfDeptId.Value);
                cmd.Parameters.AddWithValue("@Name", txtDeptName.Text);
                cmd.Parameters.AddWithValue("@Status", ddlDeptStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@User", Session["UserName"] ?? "admin");

                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseDeptModal", "closeDeptModalJQ();", true);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int deptId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("sp_GetDepartmentById", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DepartmentId", deptId);
                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hfDeptId.Value = deptId.ToString();
                    txtDeptName.Text = dr["Name"].ToString();
                    ddlDeptStatus.SelectedValue = dr["Status"].ToString();
                }
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "EditModal",
                "new bootstrap.Modal(document.getElementById('deptModal')).show();", true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand("sp_DeleteDepartment", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@DepartmentId", btn.CommandArgument);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            Console.WriteLine("Excel");
        }

        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            Console.WriteLine("pdf");

        }
        public override void VerifyRenderingInServerForm(Control control) { }
    }
}