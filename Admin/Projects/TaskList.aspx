<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Masters/AdminMaster.master"
    CodeFile="TaskList.aspx.cs"
    Inherits="HR_System.TaskList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

<style>
    body { background: #f8f9fa; }
    
    .project-card {
        background: white;
        border: 1px solid #e9ecef;
        border-radius: 8px;
        margin-bottom: 16px;
        transition: all 0.2s;
        cursor: pointer;
    }
    
    .project-card:hover {
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transform: translateY(-2px);
    }
    
    .project-card.active {
        border-left: 4px solid #0d6efd;
    }
    
    .project-icon {
        width: 50px;
        height: 50px;
        background: #f0f4ff;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    
    .task-stats {
        font-size: 13px;
        color: #6c757d;
    }
    
    .progress-thin {
        height: 6px;
        border-radius: 3px;
        background: #e9ecef;
    }
    
    .progress-thin .progress-bar {
        border-radius: 3px;
    }
    
    .detail-card {
        background: white;
        border-radius: 12px;
        padding: 24px;
        margin-bottom: 20px;
        border: 1px solid #e9ecef;
    }
    
    .task-info-row {
        display: flex;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .task-info-row:last-child {
        border-bottom: none;
    }
    
    .priority-tabs {
        display: flex;
        gap: 8px;
        margin-bottom: 20px;
    }
    
    .priority-tab {
        padding: 6px 16px;
        border-radius: 6px;
        background: white;
        border: 1px solid #e9ecef;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.2s;
    }
    
    .priority-tab:hover {
        background: #f8f9fa;
    }
    
    .priority-tab.active {
        background: #0d6efd;
        color: white;
        border-color: #0d6efd;
    }
    
    .task-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .badge-tasks {
        background: #d1ecf1;
        color: #0c5460;
    }
    
    .badge-comments {
        background: #f8d7da;
        color: #721c24;
    }
    
    .completion-circle {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: #f0f4ff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        font-weight: bold;
        color: #0d6efd;
    }
</style>

<div class="container-fluid py-4">
    
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="mb-1">Tasks</h4>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0" style="font-size: 13px;">
                    <li class="breadcrumb-item"><a href="#" class="text-decoration-none">Employee</a></li>
                    <li class="breadcrumb-item active">Tasks</li>
                </ol>
            </nav>
        </div>
        <a href="AddTask.aspx" class="btn btn-primary">
            <i class="ti ti-circle-plus"></i> Add Task
        </a>
    </div>

    <div class="row">
        
        <!-- LEFT: Project List -->
        <div class="col-xl-5">
            
            <!-- Priority Filter Tabs -->
            <div class="priority-tabs">
                <asp:LinkButton ID="btnAll" runat="server" 
                    CssClass="priority-tab active" 
                    OnClick="FilterPriority_Click"
                    CommandArgument="All">
                    All
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnHigh" runat="server" 
                    CssClass="priority-tab" 
                    OnClick="FilterPriority_Click"
                    CommandArgument="High">
                    High
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnMedium" runat="server" 
                    CssClass="priority-tab" 
                    OnClick="FilterPriority_Click"
                    CommandArgument="Medium">
                    Medium
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnLow" runat="server" 
                    CssClass="priority-tab" 
                    OnClick="FilterPriority_Click"
                    CommandArgument="Low">
                    Low
                </asp:LinkButton>
            </div>

            <!-- Date Filter -->
            <div class="mb-3">
                <asp:TextBox ID="txtFilterDate" runat="server" 
                    TextMode="Date" 
                    CssClass="form-control" 
                    style="width: 180px; font-size: 13px;"
                    AutoPostBack="true"
                    OnTextChanged="FilterDate_Changed" />
            </div>

            <!-- Projects List -->
            <div style="height: 70vh; overflow-y: auto;">
                <asp:Repeater ID="rptProjects" runat="server" OnItemCommand="rptProjects_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton runat="server"
                            CssClass="text-decoration-none"
                            CommandName="SelectProject"
                            CommandArgument='<%# Eval("ProjectId") %>'>
                            
                            <div class="project-card">
                                <div class="d-flex p-3">
                                    
                                    <!-- Icon -->
                                    <div class="project-icon me-3">
                                        📁
                                    </div>
                                    
                                    <!-- Content -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1"><%# Eval("ProjectName") %></h6>
                                        <div class="task-stats mb-2">
                                            <%# Eval("TotalTasks") %> tasks • 
                                            <%# Eval("CompletedTasks") %> Completed
                                        </div>
                                        
                                        <!-- Info Row -->
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="task-stats">
                                                <small>Deadline</small><br />
                                                <strong style="font-size: 13px;">Due on: <%# Eval("DueDate", "{0:dd MMM yyyy}") %></strong><br />
                                                <small class="text-muted">Fixes &</small>
                                            </div>
                                            <div class="task-stats text-end">
                                                <small>Value</small><br />
                                                <strong style="font-size: 13px;">$100</strong>
                                            </div>
                                        </div>
                                        
                                        <!-- Progress Section -->
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <i class="ti ti-clock" style="font-size: 14px;"></i>
                                                Total -144 Hrs
                                            </small>
                                            <small class="text-muted">
                                                <%# Eval("CompletionPercentage") %>% Completed
                                            </small>
                                        </div>
                                        
                                        <div class="progress progress-thin mt-2">
                                            <div class="progress-bar" 
                                                 style="width: <%# Eval("CompletionPercentage") %>%; background: #ffc107;">
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
                
                <asp:Label ID="lblNoProjects" runat="server" 
                    CssClass="text-muted text-center d-block mt-4"
                    Visible="false"
                    Text="No projects found for selected filters" />
            </div>
            
        </div>

        <!-- RIGHT: Project Details -->
        <div class="col-xl-7">
            
            <asp:Repeater ID="rptTaskDetails" runat="server">
                <ItemTemplate>
                    
                    <!-- Project Detail Card -->
                    <div class="detail-card">
                        <h5 class="mb-4"><%# Eval("ProjectName") %></h5>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            
                            <!-- Left: Progress Info -->
                            <div class="flex-grow-1">
                                <h6 class="text-muted mb-3">Tasks Done</h6>
                                
                                <h2 class="mb-3">
                                    <%# Eval("CompletedTasks") %> / <%# Eval("TotalTasks") %>
                                </h2>
                                
                                <div class="progress progress-thin mb-2" style="max-width: 400px;">
                                    <div class="progress-bar bg-info" 
                                         style="width: <%# Eval("CompletionPercentage") %>%;">
                                    </div>
                                </div>
                                
                                <small class="text-muted">
                                    <%# Eval("CompletionPercentage") %>%
                                </small>
                            </div>
                            
                            <!-- Right: Circular Progress -->
                            <div class="completion-circle">
                                <%# Eval("CompletionPercentage") %>%
                            </div>
                            
                        </div>
                    </div>

                    <!-- Task Row with Badge -->
                    <div class="detail-card">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <i class="ti ti-menu-2 me-3" style="font-size: 20px; color: #6c757d;"></i>
                                <span style="color: #ffc107; font-size: 18px; margin-right: 8px;">⭐</span>
                                <strong><%# Eval("ProjectName") %></strong>
                                <small class="text-muted ms-2">
                                    <i class="ti ti-calendar"></i> <%# Eval("DueDate", "{0:dd MMM yyyy}") %>
                                </small>
                            </div>
                            <div>
                                <span class="task-badge badge-tasks me-2">
                                    <%# Eval("TotalTasks") %> tasks
                                </span>
                                <span class="task-badge badge-comments">
                                    <i class="ti ti-message"></i> 0
                                </span>
                            </div>
                        </div>
                    </div>
                    
                </ItemTemplate>
            </asp:Repeater>

            <!-- Empty State -->
            <asp:Label ID="lblEmpty" runat="server"
                CssClass="text-muted text-center d-block mt-5"
                Visible="false"
                Text="Select a project to view details" />
            
        </div>
        
    </div>
    
</div>

</asp:Content>