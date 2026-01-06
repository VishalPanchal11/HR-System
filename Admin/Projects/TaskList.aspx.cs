using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace HR_System
{
    public partial class TaskList : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["HRdbCon"].ConnectionString;

        
        private string SelectedPriority
        {
            get { return ViewState["SelectedPriority"]?.ToString() ?? "All"; }
            set { ViewState["SelectedPriority"] = value; }
        }

        private DateTime? SelectedDate
        {
            get { return ViewState["SelectedDate"] as DateTime?; }
            set { ViewState["SelectedDate"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects();
                lblEmpty.Visible = true;
            }
        }

        void LoadProjects()
        {
            
            var data = GetFilteredProjects(SelectedPriority, SelectedDate);

            rptProjects.DataSource = data;
            rptProjects.DataBind();

            
            lblNoProjects.Visible = data.Count == 0;

            
            rptTaskDetails.DataSource = null;
            rptTaskDetails.DataBind();

            
            UpdatePriorityTabs();
        }

        protected void FilterPriority_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            SelectedPriority = btn.CommandArgument;
            LoadProjects();
        }

        protected void FilterDate_Changed(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtFilterDate.Text))
            {
                SelectedDate = DateTime.Parse(txtFilterDate.Text);
            }
            else
            {
                SelectedDate = null;
            }
            LoadProjects();
        }

        protected void rptProjects_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectProject")
            {
                int projectId = Convert.ToInt32(e.CommandArgument);

                var filteredData = GetFilteredProjects(SelectedPriority, SelectedDate);
                var selected = filteredData.Where(x => x.ProjectId == projectId).ToList();

                rptTaskDetails.DataSource = selected;
                rptTaskDetails.DataBind();

                lblEmpty.Visible = selected.Count == 0;
            }
        }

        void UpdatePriorityTabs()
        {
            
            btnAll.CssClass = "priority-tab";
            btnHigh.CssClass = "priority-tab";
            btnMedium.CssClass = "priority-tab";
            btnLow.CssClass = "priority-tab";

           
            switch (SelectedPriority)
            {
                case "All":
                    btnAll.CssClass = "priority-tab active";
                    break;
                case "High":
                    btnHigh.CssClass = "priority-tab active";
                    break;
                case "Medium":
                    btnMedium.CssClass = "priority-tab active";
                    break;
                case "Low":
                    btnLow.CssClass = "priority-tab active";
                    break;
            }
        }

        List<ProjectTaskVM> GetFilteredProjects(string priority, DateTime? filterDate)
        {
            List<ProjectTaskVM> list = new List<ProjectTaskVM>();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                
                string query = @"
                    SELECT 
                        p.ProjectId,
                        p.ProjectName,
                        p.StartDate,
                        p.EndDate,
                        COUNT(t.TaskId) as TotalTasks,
                        SUM(CASE WHEN t.Status = 'Completed' THEN 1 ELSE 0 END) as CompletedTasks,
                        CASE 
                            WHEN COUNT(t.TaskId) > 0 THEN 
                                CAST(SUM(CASE WHEN t.Status = 'Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.TaskId) as DECIMAL(5,2))
                            ELSE 0 
                        END as CompletionPercentage,
                        MAX(t.Deadline) as DueDate
                    FROM AllProjects p
                    INNER JOIN Task t ON p.ProjectId = t.ProjectId
                    WHERE 1=1";

                
                if (priority != "All")
                {
                    query += " AND t.Priority = @Priority";
                }

                
                if (filterDate.HasValue)
                {
                    query += @" AND (
                        (p.StartDate <= @FilterDate AND p.EndDate >= @FilterDate)
                        OR t.Deadline >= @FilterDate
                    )";
                }

                query += @" 
                    GROUP BY p.ProjectId, p.ProjectName, p.StartDate, p.EndDate
                    ORDER BY p.ProjectName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (priority != "All")
                    {
                        cmd.Parameters.AddWithValue("@Priority", priority);
                    }

                    if (filterDate.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@FilterDate", filterDate.Value);
                    }

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        list.Add(new ProjectTaskVM
                        {
                            ProjectId = Convert.ToInt32(dr["ProjectId"]),
                            ProjectName = dr["ProjectName"].ToString(),
                            TotalTasks = Convert.ToInt32(dr["TotalTasks"]),
                            CompletedTasks = Convert.ToInt32(dr["CompletedTasks"]),
                            CompletionPercentage = Convert.ToDecimal(dr["CompletionPercentage"]),
                            StartDate = dr["StartDate"] != DBNull.Value
                                ? Convert.ToDateTime(dr["StartDate"])
                                : (DateTime?)null,
                            EndDate = dr["EndDate"] != DBNull.Value
                                ? Convert.ToDateTime(dr["EndDate"])
                                : (DateTime?)null,
                            DueDate = dr["DueDate"] != DBNull.Value
                                ? Convert.ToDateTime(dr["DueDate"])
                                : (DateTime?)null
                        });
                    }
                }
            }

            return list;
        }
    }

    public class ProjectTaskVM
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public int TotalTasks { get; set; }
        public int CompletedTasks { get; set; }
        public decimal CompletionPercentage { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public DateTime? DueDate { get; set; }
    }
}