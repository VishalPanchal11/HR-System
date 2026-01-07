<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EmployeeMaster.Master" AutoEventWireup="true" CodeFile="ApplyLeaves.aspx.cs" Inherits="HR_System.Employee.Attendance.ApplyLeaves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <!DOCTYPE html>
    <html>
    <head>
        <title>Leave Requests</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            }

            .bg-blue-le {
                background: #fff;
                border-left: 5px solid #0d6efd;
            }

            .avatar-md {
                width: 48px;
                height: 48px;
                background: #0d6efd;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }

            .fs-32 {
                font-size: 24px;
            }

            .breadcrumb-item + .breadcrumb-item::before {
                content: "/";
            }

            .btn-apply {
                background-color: #fd7e14;
                border-color: #fd7e14;
                color: white;
            }

                .btn-apply:hover {
                    background-color: #e86b0b;
                    color: white;
                }

            .status-badge {
                border-radius: 4px;
                padding: 4px 12px;
                font-size: 12px;
                color: white;
                display: inline-block;
                width: 80px;
                text-align: center;
            }

            .status-rejected {
                background-color: #dc3545;
            }

            .status-approved {
                background-color: #198754;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid py-4">

            <div class="d-flex align-items-center justify-content-between mb-4">
                <div>
                    <h4 class="mb-1">Leave Requests</h4>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><i class="ti ti-smart-home"></i></a></li>
                            <li class="breadcrumb-item">Employee</li>
                            <li class="breadcrumb-item active">Leave Requests</li>
                        </ol>
                    </nav>
                </div>
                <button type="button" class="btn btn-apply d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#applyLeaveModal">
                    <i class="ti ti-circle-plus me-1"></i>Apply Leave
                </button>
            </div>

            <div class="row mb-4">
                <asp:Repeater ID="rptSummary" runat="server">
                    <ItemTemplate>
                        <div class="col-xl-3 col-md-6 mb-3">
                            <div class="card bg-blue-le h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <p class="text-muted mb-1"><%# Eval("LeaveType") %></p>
                                            <h3 class="fw-bold"><%# Eval("TotalLeaves") %></h3>
                                        </div>
                                        <div class="avatar-md">
                                            <i class="ti ti-calendar-event fs-32"></i>
                                        </div>
                                    </div>
                                    <span class="badge bg-primary-soft text-primary mt-2" style="background: #e7f1ff;">Remaining Leaves : <%# Eval("RemainingLeaves") %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="card">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">My Leave Requests</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvLeaveRequests" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover align-middle" GridLines="None" BorderStyle="None" DataKeyNames="Leave_ID" DataSourceID="LeavetypeDB">
                            <Columns>
                                <asp:BoundField DataField="Leave_ID" HeaderText="Leave_ID" InsertVisible="False" ReadOnly="True" SortExpression="Leave_ID" />
                                <asp:BoundField DataField="LeaveType" HeaderText="LeaveType" SortExpression="LeaveType" />
                                <asp:BoundField DataField="StartDate" HeaderText="StartDate" SortExpression="StartDate" />
                                <asp:BoundField DataField="EndDate" HeaderText="EndDate" SortExpression="EndDate" />
                                <asp:BoundField DataField="Reason" HeaderText="Reason" SortExpression="Reason" />
                                <asp:BoundField DataField="NumberOfDays" HeaderText="NumberOfDays" SortExpression="NumberOfDays" />

                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            </Columns>
                            <HeaderStyle CssClass="table-light" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="LeavetypeDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_EmpShow_leaves" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="applyLeaveModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Apply Leave</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Leave Type</label>
                                <asp:DropDownList ID="ddlLeaveType" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Select Leave Type" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">End Date</label>
                                <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Start Date</label>
                                <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Reason</label>
                                <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">No of Days</label>
                                <asp:TextBox ID="NOOFDAYS" runat="server" Rows="3" CssClass="form-control" />
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer justify-content-start">
                        <asp:Button ID="btnApply" runat="server" Text="Apply" CssClass="btn btn-apply px-4" OnClick="btnApply_Click"/>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
</asp:Content>

