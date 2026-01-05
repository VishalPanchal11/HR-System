<%@ Page Title=""
    Language="C#"
    MasterPageFile="~/Masters/AdminMaster.Master"
    AutoEventWireup="true"
    CodeBehind="ProjectList.aspx.cs"
    Inherits="HR_System.ProjectList" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <style>
        .rounded-circle {
            border-radius: 50%;
        }
    </style>

    <div class="container-fluid mt-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>Projects</h2>

            <div class="d-flex gap-2">

                <!-- Export Button -->
                <div class="dropdown">
                    <button class="btn btn-outline-secondary dropdown-toggle"
                        type="button"
                        data-bs-toggle="dropdown">
                        Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item exportPdf" href="#">Export as PDF</a>
                        </li>
                        <li>
                            <a class="dropdown-item exportExcel" href="#">Export as Excel</a>
                        </li>
                    </ul>
                </div>

                <!-- Add Project -->
                <asp:Button ID="btnAddProject" runat="server"
                    Text="Add Project"
                    CssClass="btn btn-primary"
                    OnClick="btnAddProject_Click" />
            </div>
        </div>

        <!-- Filters -->
        <div class="card mb-3">
            <div class="card-body d-flex justify-content-end gap-3 align-items-center">

                <!-- Status Filter -->
                <div>
                    <label class="form-label mb-1">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="FilterChanged">
                        <asp:ListItem Text="All" Value="All" />
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

                <!-- Sort By -->
                <div>
                    <label class="form-label mb-1">Sort By</label>
                    <asp:DropDownList ID="ddlSort" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="FilterChanged">
                        <asp:ListItem Text="Ascending" Value="Asc" />
                        <asp:ListItem Text="Descending" Value="Desc" />
                        <asp:ListItem Text="Last 7 Days" Value="Last7" />
                        <asp:ListItem Text="Recently Added" Value="Recent" />
                        <asp:ListItem Text="Last Month" Value="LastMonth" />
                    </asp:DropDownList>
                </div>

            </div>
        </div>

        <!-- Project List -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">Project List</h5>
            </div>

            <div class="card-body">
                <table class="table table-bordered" id="projectTable">
                    <thead>
                        <tr>
                            <th>Project Id</th>
                            <th>Project Name</th>
                            <th>Team Members</th>
                            <th>Deadline</th>
                            <th>Priority</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProjects" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("ProjectId") %></td>

                                    <td>
                                        <strong><%# Eval("ProjectName") %></strong>
                                    </td>

                                    <td>
                                        <%# Eval("MembersHtml") %>
                                    </td>

                                    <td>
                                        <%# Eval("EndDate", "{0:yyyy-MM-dd}") %>
                                    </td>

                                    <td>
                                        <span class="<%# Eval("PriorityText") %>">
                                            <%# Eval("Priority") %>
                                        </span>
                                    </td>

                                    <td>
                                        <span class="badge <%# Eval("StatusClass") %>">
                                            <%# Eval("Status") %>
                                        </span>
                                    </td>

                                    <td>
                                        <a href='EditProject.aspx?id=<%# Eval("ProjectId") %>'>✏️</a>
                                        &nbsp;
                                        <a href='ProjectList.aspx?deleteId=<%# Eval("ProjectId") %>'
                                            onclick="return confirm('Are you sure you want to delete this project?')">
                                            🗑
                                        </a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <!-- DataTables + Export Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>

    <script>
        $(document).ready(function () {

            var table = $('#projectTable').DataTable({
                pageLength: 10,
                dom: 'lfrtip',
                buttons: [
                    {
                        extend: 'pdfHtml5',
                        title: 'Project List',
                        exportOptions: {
                            columns: [0, 1, 3, 4, 5]
                        }
                    },
                    {
                        extend: 'excelHtml5',
                        title: 'Project List',
                        exportOptions: {
                            columns: [0, 1, 3, 4, 5]
                        }
                    }
                ]
            });

            $('.exportPdf').on('click', function (e) {
                e.preventDefault();
                table.button(0).trigger();
            });

            $('.exportExcel').on('click', function (e) {
                e.preventDefault();
                table.button(1).trigger();
            });

        });
    </script>

</asp:Content>
