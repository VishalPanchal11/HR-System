<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="DepartmentLeaveShow.aspx.cs" Inherits="HR_System.Admin.Attendance.DepartmentLeaveShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!DOCTYPE html>
    <html>
    <head>
        <title>Department Leave Allocation</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

        <!-- DataTables -->
        <link href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css" rel="stylesheet" />

        <!-- Icons -->
        <link href="https://tabler-icons.io/static/tabler-icons.min.css" rel="stylesheet" />

        <style>
            .badge-active {
                background-color: #22c55e;
            }

            .badge-inactive {
                background-color: #ef4444;
            }

            table.dataTable thead th {
                background: #f1f5f9;
            }

            .action-icon {
                color: #111;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
      

            <div class="container-fluid mt-4">

                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div>
                        <h3>Leaves</h3>
                        <nav>
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item">Admin</li>
                                <li class="breadcrumb-item active">Department Leave Allocation</li>
                            </ol>
                        </nav>
                    </div>
                    <div>
                        <button class="btn btn-outline-secondary dropdown-toggle"
                            type="button" data-bs-toggle="dropdown">
                            Export
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#" id="exportPdf">Export as PDF</a></li>
                            <li><a class="dropdown-item" href="#" id="exportExcel">Export as Excel</a></li>
                        </ul>
                    </div>
                </div>

                <!-- Card -->
                <div class="card shadow-sm">
                    <div class="card-header">
                        <h6 class="mb-0">Department Leave Details</h6>
                    </div>

                    <div class="card-body">
                        <asp:GridView ID="gvDepartmentLeaves" runat="server"
                            CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False" DataSourceID="LeavesdepartmentDB" DataKeyNames="DepartmentLeavesId" OnRowDeleting="DeptLeaveDel" >

                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="LeaveType" HeaderText="LeaveType" SortExpression="LeaveType" />
                                <asp:BoundField DataField="LeavesCount" HeaderText="LeavesCount" SortExpression="LeavesCount" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                
                                <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="🗑" />
                                
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="LeavesdepartmentDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_Dept_DeptLeaveCount" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </div>
                </div>

            </div>




        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>

        <script>
            $(function () {
                var table = $('#<%= gvDepartmentLeaves.ClientID %>').DataTable({
            pageLength: 10,
            dom: 'lfrtip',
            buttons: ['pdf', 'excel']
        });

        $('#exportPdf').click(function () {
            table.button('.buttons-pdf').trigger();
        });

        $('#exportExcel').click(function () {
            table.button('.buttons-excel').trigger();
        });
    });
        </script>

    </body>
    </html>

</asp:Content>
