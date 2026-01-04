<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="HR_System.Admin.Attendance.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap & DataTables CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css" rel="stylesheet" />

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="mb-1">Leaves</h2>
            <small>Admin / Add LeaveType</small>
        </div>

        <!-- Button (UI only) -->
        <button type="button" class="btn btn-primary" onclick="toggleForm()">
            Add Leave Type
        </button>

    </div>

    <!-- Add Leave Type Form (Hidden) -->
    <div id="addLeaveForm" class="card p-3 mb-4" style="display: none;">
        <div class="mb-3">
            <label class="form-label">Leave Type</label>
            <asp:TextBox ID="LeaveType" runat="server" CssClass="form-control" Placeholder="Enter leave type" />
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-success" Text="Submit" OnClick="SubmitAddType" />

        </div>

    </div>

    <!-- Leave Type List -->

    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">LeaveType List</h5>
        </div>

        <div class="card-body">

            <asp:GridView ID="gvLeaveTypes" runat="server"
                CssClass="table table-bordered"
                AutoGenerateColumns="False"
                DataKeyNames="LeaveTypeId" DataSourceID="LeaveTypeDB" OnRowDeleting="gvLeaveTypes_RowDeleting">
                <columns>
                    <asp:BoundField DataField="LeaveTypeId" HeaderText="LeaveTypeId" InsertVisible="False" ReadOnly="True" SortExpression="LeaveTypeId" />
                    <asp:BoundField DataField="LeaveType" HeaderText="LeaveType" SortExpression="LeaveType" />
                    <asp:ButtonField ButtonType="Button" CommandName="Delete" HeaderText="Action" ShowHeader="True" Text="🗑" />
                </columns>
            </asp:GridView>
            <asp:SqlDataSource ID="LeaveTypeDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_ShowMasterLeaveTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

        </div>

    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

    <script>
        function toggleForm() {
            $("#addLeaveForm").toggle();
        }

        $(document).ready(function () {
            $("#leaveTypeTable").DataTable();
        });
    </script>

</asp:Content>

