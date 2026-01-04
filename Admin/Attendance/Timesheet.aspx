<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Timesheet.aspx.cs" Inherits="HR_System.Admin.Attendance.Timesheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        .page-title {
            font-size: 22px;
            font-weight: 700;
        }

        .action-btn {
            min-width: 150px;
            font-weight: 600;
        }

        .timesheet-card {
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 18px;
            background: #fff;
        }

        .emp-img {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            margin-right: 8px;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>


    <div class="container mt-3">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="page-title">Admin Timesheet Management</span>

            <div>
                <asp:Button ID="btnApproveSelected" runat="server"
                    Text="Approve Selected"
                    CssClass="btn btn-success action-btn" OnClick="btnApproveSelected_Click" />

                <asp:Button ID="btnRejectSelected" runat="server"
                    Text="Reject Selected"
                    CssClass="btn btn-danger action-btn ms-2" OnClick="btnRejectSelected_Click" />
            </div>
        </div>

        <div class="timesheet-card">

            <div class="d-flex justify-content-between mb-3">
                <h6 class="fw-bold">Timesheet</h6>

                <div class="d-flex gap-2">
                    <input type="text" class="form-control" placeholder="Search by Project Name" />

                    <select class="form-select">
                        <option>All Status</option>
                        <option>Approved</option>
                        <option>Rejected</option>
                    </select>

                    <select class="form-select">
                        <option>Projects</option>
                    </select>
                </div>
            </div>

            <asp:GridView ID="gvTimesheet" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered align-middle" HeaderStyle-CssClass="table-light" AllowPaging="True" DataSourceID="showtimssheetDB">
                <Columns>
                    <asp:TemplateField HeaderStyle-Width="30px">
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkAll" runat="server" onclick="toggleAll(this)" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkRow" runat="server" />
                            <asp:HiddenField ID="hfTimesheetId"
                                Value='<%# Eval("TimesheetId") %>'
                                runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                    <asp:BoundField DataField="CreatedAt" HeaderText="CreatedAt" SortExpression="CreatedAt" />
                    <asp:BoundField DataField="ProjectName" HeaderText="ProjectName" SortExpression="ProjectName" />
                    <asp:BoundField DataField="WorkHours" HeaderText="WorkHours" SortExpression="WorkHours" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                </Columns>
                <HeaderStyle CssClass="table-light"></HeaderStyle>

            </asp:GridView>
            <asp:SqlDataSource ID="showtimssheetDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_showTimesheets" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <asp:SqlDataSource ID="ShowTimesheetDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_showTimesheets" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <div class="d-flex justify-content-end">
                <nav>
                    <ul class="pagination">
                        <li class="page-item disabled">
                            <span class="page-link">&laquo;</span>
                        </li>

                        <li class="page-item active">
                            <span class="page-link">1</span>
                        </li>

                        <li class="page-item">
                            <span class="page-link">2</span>
                        </li>

                        <li class="page-item">
                            <span class="page-link">&raquo;</span>
                        </li>
                    </ul>
                </nav>
            </div>

        </div>

    </div>

</asp:Content>
