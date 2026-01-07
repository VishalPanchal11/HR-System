<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="ManageLeavesetting.aspx.cs" Inherits="HR_System.Admin.Attendance.ManageLeavesetting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
    .leave-card {
        border: 1px solid #e5e5e5;
        border-radius: 10px;
        padding: 18px;
        background: #fff;
        min-width: 280px;
    }

    .leave-title {
        font-weight: 600;
        font-size: 15px;
    }

    .toggle-switch {
        width: 40px;
        height: 20px;
        cursor: pointer;
    }

    .custom-policy {
        font-size: 13px;
        color: #0d6efd;
        text-decoration: none;
        cursor: pointer;
    }

    .leave-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
    }
</style>


<div class="container mt-3">

    <h4 class="mb-3">Manage Leave Settings</h4>

    <div class="leave-grid">

        <!-- Paid Leave -->
        <div class="leave-card d-flex justify-content-between align-items-center">

            <div>
                <asp:CheckBox ID="chkPaidLeave" runat="server"
                    CssClass="form-check-input toggle-switch"
                    AutoPostBack="true"
                    Checked="true"
                    ToolTip="1" />
                <span class="leave-title ms-2">Paid Leave</span>
            </div>

            <a class="custom-policy">Custom Policy <i class="bi bi-gear"></i></a>
        </div>


        <div class="leave-card d-flex justify-content-between align-items-center">

            <div>
                <asp:CheckBox ID="chkSickLeave" runat="server"
                    CssClass="form-check-input toggle-switch"
                    AutoPostBack="true"
                    OnCheckedChanged="LeaveStatusChanged"
                    ToolTip="2" />
                <span class="leave-title ms-2">Sick Leave</span>
            </div>

            <a class="custom-policy">Custom Policy <i class="bi bi-gear"></i></a>
        </div>


        <div class="leave-card d-flex justify-content-between align-items-center">

            <div>
                <asp:CheckBox ID="chkCasualLeave" runat="server"
                    CssClass="form-check-input toggle-switch"
                    AutoPostBack="true"
                    OnCheckedChanged="LeaveStatusChanged"
                    Checked="true"
                    ToolTip="3" />
                <span class="leave-title ms-2">Casual Leave</span>
            </div>

            <a class="custom-policy">Custom Policy <i class="bi bi-gear"></i></a>
        </div>

        <div class="leave-card d-flex justify-content-between align-items-center">

            <div>
                <asp:CheckBox ID="chkMaternityLeave" runat="server"
                    CssClass="form-check-input toggle-switch"
                    AutoPostBack="true"
                    OnCheckedChanged="LeaveStatusChanged"
                    ToolTip="4" />
                <span class="leave-title ms-2">Maternity Leave</span>
            </div>

            <a class="custom-policy">Custom Policy <i class="bi bi-gear"></i></a>
        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.js"></script>



</asp:Content>
