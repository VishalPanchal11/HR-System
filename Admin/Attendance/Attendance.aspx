<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="Attendance.aspx.cs" Inherits="HR_System.Admin.Attendance.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Leave Types</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
        <style>
            .badge-xs {
                padding: 0.35em 0.5em;
                font-size: 0.75em;
            }

            #divAddLeaveForm {
                display: none;
            }
            /* Initially hidden */
        </style>
    </head>
    <body>
   
            <div class="container mt-4">

                <div class="d-md-flex d-block align-items-center justify-content-between mb-3">
                    <div>
                        <h2 class="mb-1">Leaves</h2>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="#"><i class="ti ti-smart-home"></i></a></li>
                                <li class="breadcrumb-item">Admin</li>
                                <li class="breadcrumb-item active">Add LeaveType</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="d-flex align-items-center flex-wrap">
                        <button type="button" id="btnToggleForm" class="btn btn-primary d-flex align-items-center">
                            <i class="ti ti-circle-plus me-2"></i>Add Leave Type
                        </button>
                    </div>
                </div>

                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <div class="alert alert-success alert-dismissible fade show">
                        <asp:Literal ID="litMsg" runat="server"></asp:Literal>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </asp:Panel>

                <div id="divAddLeaveForm" class="card mb-4">
                    <div class="card-body">
                        <div class="form-group mb-2">
                            <label>Leave Type</label>
                            <asp:TextBox ID="txtLeaveType" runat="server" CssClass="form-control" placeholder="Enter leave type"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click"/>
                    </div>
                </div>

                <hr />

                <div class="card">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">LeaveType List</h5>
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvLeaveTypes" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover" GridLines="None" DataKeyNames="LeaveTypeId" DataSourceID="AddLeaveDB" OnRowDeleting="gvLeaveTypes_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="LeaveTypeId" HeaderText="LeaveTypeId" InsertVisible="False" ReadOnly="True" SortExpression="LeaveTypeId" />

                                <asp:BoundField DataField="LeaveType" HeaderText="LeaveType" SortExpression="LeaveType" />
                                <asp:CommandField ButtonType="Button" HeaderText="Action" ShowDeleteButton="True" ShowHeader="True" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="AddLeaveDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_ShowMasterLeaveTypes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
     

        <script>
            document.getElementById('btnToggleForm').addEventListener('click', function () {
                var formDiv = document.getElementById('divAddLeaveForm');
                formDiv.style.display = (formDiv.style.display === 'none' || formDiv.style.display === '') ? 'block' : 'none';
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>

</asp:Content>

