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


        <asp:GridView ID="gvTimesheet"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered align-middle"
    HeaderStyle-CssClass="table-light"
    AllowPaging="True"
    PageSize="10"
    OnPageIndexChanging="gvTimesheet_PageIndexChanging">

    <Columns>

        <!-- Select Row Checkbox -->
        <asp:TemplateField HeaderStyle-Width="30px">
            <HeaderTemplate>
                <asp:CheckBox ID="chkAll" runat="server" />
            </HeaderTemplate>
            <ItemTemplate>
                <asp:CheckBox ID="chkRow" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <!-- Employee (Image + Name) -->
        <asp:TemplateField HeaderText="Employee">
            <ItemTemplate>
                <img src='<%# Eval("EmployeeImage") %>' class="emp-img" />
                <%# Eval("EmployeeName") %>
            </ItemTemplate>
        </asp:TemplateField>

        <!-- Created At -->
        <asp:BoundField DataField="CreatedAt" HeaderText="Created At" />

        <!-- Project -->
        <asp:BoundField DataField="Project" HeaderText="Project" />

        <!-- Worked Hours -->
        <asp:BoundField DataField="WorkedHours" HeaderText="Worked Hours" />

        <!-- Status -->
        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <span class='status-badge text-white
                    <%# Eval("Status").ToString() == "Approved" 
                        ? " bg-success" 
                        : " bg-danger" %>'>
                    <%# Eval("Status") %>
                </span>
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>



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
