<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EmployeeMaster.Master" AutoEventWireup="true" CodeFile="Leaves.aspx.cs" Inherits="HR_System.Attendance.Leaves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <!DOCTYPE html>
    <html>
    <head>
        <title>Leave Requests</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet" />
    </head>
    <body>

        <div class="container-fluid mt-4">

            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Leave Requests</h3>
                <button type="button" class="btn btn-warning text-white"
                    data-bs-toggle="modal" data-bs-target="#applyLeaveModal">
                    + Apply Leave
                </button>
            </div>

            <!-- LEAVE CARDS -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h6>Sick Leave</h6>
                            <h4>4</h4>
                            <span class="badge bg-primary">Remaining Leaves : 4</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h6>Maternity Leave</h6>
                            <h4>2</h4>
                            <span class="badge bg-primary">Remaining Leaves : 2</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- GRIDVIEW -->
            <div class="card">
                <div class="card-header fw-bold">
                    My Leave Requests
                </div>
                <div class="card-body">

                    <asp:GridView ID="gvLeaves" runat="server"
                        CssClass="table table-bordered table-striped"
                        AutoGenerateColumns="False" DataKeyNames="Leave_ID" DataSourceID="EmpLeavesShowDB">

                        <Columns>
                            <asp:BoundField HeaderText="Leave_ID" DataField="Leave_ID" InsertVisible="False" ReadOnly="True" SortExpression="Leave_ID" />
                            <asp:BoundField HeaderText="LeaveType" DataField="LeaveType" SortExpression="LeaveType" />
                            <asp:BoundField HeaderText="StartDate" DataField="StartDate" SortExpression="StartDate" />
                            <asp:BoundField HeaderText="EndDate" DataField="EndDate" SortExpression="EndDate" />
                            <asp:BoundField HeaderText="Reason" DataField="Reason" SortExpression="Reason" />
                            <asp:BoundField HeaderText="NumberOfDays" DataField="NumberOfDays" SortExpression="NumberOfDays" />
                           
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                           
                        </Columns>

                    </asp:GridView>

                    <asp:SqlDataSource ID="EmpLeavesShowDB" runat="server" ConnectionString="<%$ ConnectionStrings:Pulse360_FinalDbConnectionString %>" SelectCommand="Pro_EmpShow_leaves" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

                </div>
            </div>

        </div>

        <!-- APPLY LEAVE MODAL -->
        <div class="modal fade" id="applyLeaveModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Apply Leave</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Leave Type</label>
                                <asp:DropDownList ID="ddlLeaveType" runat="server"
                                    CssClass="form-select">
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">End Date</label>
                                <asp:TextBox ID="txtEndDate" runat="server"
                                    CssClass="form-control" TextMode="Date" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Start Date</label>
                                <asp:TextBox ID="txtStartDate" runat="server"
                                    CssClass="form-control" TextMode="Date" />
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Reason</label>
                                <asp:TextBox ID="txtReason" runat="server"
                                    CssClass="form-control" TextMode="MultiLine" Rows="3" />
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <asp:Button ID="btnApply" runat="server"
                            CssClass="btn btn-warning text-white"
                            Text="Apply" OnClick="btnApply_Click"/>
                    </div>

                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
    </html>

</asp:Content>
