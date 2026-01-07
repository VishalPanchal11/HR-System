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
        int editingResignationID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeeDropdown();
                BindGrid();
            }
        }

        // Load employees into dropdown
        void LoadEmployeeDropdown()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT UserID, UserName FROM Users WHERE IsActive = 1 ORDER BY UserName", con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlEmployee.DataSource = dt;
                    ddlEmployee.DataTextField = "UserName";
                    ddlEmployee.DataValueField = "UserID";
                    ddlEmployee.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading employees: " + ex.Message);
            }
        }

        // Bind data to GridView
        void BindGrid(string sort = "", string search = "", DateTime? from = null, DateTime? to = null)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string query = @"SELECT 
                                        r.ResignationID,
                                        r.UserID,
                                        u.UserName AS EmployeeName,
                                        r.DepartmentId,
                                        d.DepartmentName,
                                        r.Reason,
                                        r.NoticeDate,
                                        r.ResignDate
                                     FROM Resignation r
                                     INNER JOIN Users u ON r.UserID = u.UserID
                                     INNER JOIN Department d ON r.DepartmentId = d.DepartmentID";

                    // SEARCH (Reason based)
                    if (!string.IsNullOrEmpty(search))
                        query += " WHERE r.Reason LIKE @Search";

                    // DATE FILTER
                    if (from.HasValue && to.HasValue)
                        query += string.IsNullOrEmpty(search)
                            ? " WHERE r.ResignDate BETWEEN @From AND @To"
                            : " AND r.ResignDate BETWEEN @From AND @To";

                    // SORT
                    if (!string.IsNullOrEmpty(sort))
                        query += " ORDER BY r.ResignDate " + sort;
                    else
                        query += " ORDER BY r.ResignDate DESC";

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
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading data: " + ex.Message);
            }
        }

        // Sort dropdown change
        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sort = ddlSort.SelectedValue;
            if (sort == "ASC" || sort == "DESC")
                BindGrid(sort);
            else
                BindGrid();
        }

        // Add Resignation Button Click
        protected void btnAddResignation_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear form
                ddlEmployee.SelectedIndex = 0;
                txtNoticeDate.Text = "";
                txtResignationDate.Text = "";
                txtReasonAdd.Text = "";
                editingResignationID = 0;

                // Show modal using JavaScript
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openAddModal",
                    "var modal = new bootstrap.Modal(document.getElementById('new_resignation')); modal.show();", true);
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // Submit Add Resignation
        protected void btnSubmitAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlEmployee.SelectedValue == "")
                {
                    ShowAlert("Please select an employee");
                    return;
                }

                if (string.IsNullOrEmpty(txtNoticeDate.Text) || string.IsNullOrEmpty(txtResignationDate.Text))
                {
                    ShowAlert("Please fill in all required dates");
                    return;
                }

                // Get department from selected user
                int departmentId = GetUserDepartment(int.Parse(ddlEmployee.SelectedValue));

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"INSERT INTO Resignation (UserID, DepartmentId, Reason, NoticeDate, ResignDate)
                          VALUES (@UserID, @DepartmentId, @Reason, @NoticeDate, @ResignDate)", con);

                    cmd.Parameters.AddWithValue("@UserID", int.Parse(ddlEmployee.SelectedValue));
                    cmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                    cmd.Parameters.AddWithValue("@Reason", txtReasonAdd.Text);
                    cmd.Parameters.AddWithValue("@NoticeDate", DateTime.Parse(txtNoticeDate.Text));
                    cmd.Parameters.AddWithValue("@ResignDate", DateTime.Parse(txtResignationDate.Text));

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal",
                    "var modal = bootstrap.Modal.getInstance(document.getElementById('new_resignation')); modal.hide();", true);

                BindGrid();

                ShowAlert("Resignation added successfully");
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // Submit Edit Resignation
        protected void btnSubmitEdit_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtEditNoticeDate.Text) || string.IsNullOrEmpty(txtEditResignationDate.Text))
                {
                    ShowAlert("Please fill in all required dates");
                    return;
                }

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"UPDATE Resignation 
                          SET Reason = @Reason, NoticeDate = @NoticeDate, ResignDate = @ResignDate
                          WHERE ResignationID = @ResignationID", con);

                    cmd.Parameters.AddWithValue("@Reason", txtReasonEdit.Text);
                    cmd.Parameters.AddWithValue("@NoticeDate", DateTime.Parse(txtEditNoticeDate.Text));
                    cmd.Parameters.AddWithValue("@ResignDate", DateTime.Parse(txtEditResignationDate.Text));
                    cmd.Parameters.AddWithValue("@ResignationID", editingResignationID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal",
                    "var modal = bootstrap.Modal.getInstance(document.getElementById('edit_resignation')); modal.hide();", true);

                BindGrid();

                ShowAlert("Resignation updated successfully");
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // GridView Page Changing
        protected void gvResignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvResignation.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        // GridView Row Command (Edit/Delete)
        protected void gvResignation_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "EditRow")
                {
                    editingResignationID = id;
                    LoadResignationForEdit(id);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openEditModal",
                        "var modal = new bootstrap.Modal(document.getElementById('edit_resignation')); modal.show();", true);
                }

                if (e.CommandName == "DeleteRow")
                {
                    editingResignationID = id;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openDeleteModal",
                        "var modal = new bootstrap.Modal(document.getElementById('delete_modal')); modal.show();", true);
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // Load resignation data for editing
        void LoadResignationForEdit(int resignationID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand(
                        @"SELECT r.*, u.UserName 
                          FROM Resignation r
                          INNER JOIN Users u ON r.UserID = u.UserID
                          WHERE r.ResignationID = @ID", con);
                    cmd.Parameters.AddWithValue("@ID", resignationID);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        DataRow row = dt.Rows[0];
                        txtEmployeeName.Text = row["UserName"].ToString();
                        txtEditNoticeDate.Text = Convert.ToDateTime(row["NoticeDate"]).ToString("yyyy-MM-dd");
                        txtEditResignationDate.Text = Convert.ToDateTime(row["ResignDate"]).ToString("yyyy-MM-dd");
                        txtReasonEdit.Text = row["Reason"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading data: " + ex.Message);
            }
        }

        // Confirm Delete
        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (editingResignationID > 0)
                {
                    using (SqlConnection con = new SqlConnection(conStr))
                    {
                        SqlCommand cmd = new SqlCommand(
                            "DELETE FROM Resignation WHERE ResignationID = @ID", con);
                        cmd.Parameters.AddWithValue("@ID", editingResignationID);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal",
                        "var modal = bootstrap.Modal.getInstance(document.getElementById('delete_modal')); modal.hide();", true);

                    BindGrid();

                    ShowAlert("Resignation deleted successfully");
                    editingResignationID = 0;
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error: " + ex.Message);
            }
        }

        // Helper method to get user's department
        int GetUserDepartment(int userID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT DepartmentID FROM Users WHERE UserID = @UserID", con);
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : 1;
                }
            }
            catch
            {
                return 1; // Default department
            }
        }

        // Helper method to show alerts
        void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                $"alert('{message.Replace("'", "\\'")}');", true);
        }
    }
}