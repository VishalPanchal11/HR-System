<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="Departments.aspx.cs"
    Inherits="HR_System.Admin.Employee.Departments"
    MasterPageFile="~/Masters/AdminMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<asp:UpdatePanel ID="updDepartments" runat="server">
    <ContentTemplate>

<div class="container-fluid">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="fw-bold">Departments</h2>
            <small class="text-muted">Employee / Departments</small>
        </div>

        <div class="d-flex gap-2">

            <!-- EXPORT -->
<div class="dropdown">
    <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown">
        Export
    </button>
    <ul class="dropdown-menu">
        <li>
            <asp:LinkButton runat="server"
                ID="btnExportExcel"
                CssClass="dropdown-item"
                OnClick="btnExportExcel_Click"
                CausesValidation="false">
                Export as Excel
            </asp:LinkButton>
        </li>
        <li>
            <asp:LinkButton runat="server"
                ID="btnExportPdf"
                CssClass="dropdown-item"
                OnClick="btnExportPdf_Click"
                CausesValidation="false">
                Export as PDF
            </asp:LinkButton>
        </li>
    </ul>
</div>
            <!-- ADD -->
            <button type="button"
                    class="btn btn-warning"
                    data-bs-toggle="modal"
                    data-bs-target="#deptModal"
                    onclick="clearDeptModal();">
                + Add Department
            </button>

        </div>
    </div>

    <!-- CARD -->
    <div class="card">
        <div class="card-body">

            <!-- FILTER ROW -->
            <div class="row mb-3">

                <div class="col-md-2">
                    <asp:DropDownList ID="ddlPageSize" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                        <asp:ListItem Text="5" />
                        <asp:ListItem Text="10" />
                        <asp:ListItem Text="25" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-2">
                    <asp:DropDownList ID="ddlStatus" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                        <asp:ListItem Text="Status" Value="" />
                        <asp:ListItem Text="Active" />
                        <asp:ListItem Text="Inactive" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-2">
                    <asp:DropDownList ID="ddlSort" runat="server"
                        CssClass="form-select"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                        <asp:ListItem Text="Sort By" Value="" />
                        <asp:ListItem Text="Name ASC" Value="Name ASC" />
                        <asp:ListItem Text="Name DESC" Value="Name DESC" />
                        <asp:ListItem Text="Id ASC" Value="DepartmentId ASC" />
                        <asp:ListItem Text="Id DESC" Value="DepartmentId DESC" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-3 ms-auto">
                    <asp:TextBox ID="txtSearch" runat="server"
                        CssClass="form-control"
                        AutoPostBack="true"
                        OnTextChanged="txtSearch_TextChanged"
                        placeholder="Search" />
                </div>
            </div>

            <!-- GRID -->
            <asp:GridView ID="gvDepartments" runat="server"
                CssClass="table table-bordered table-hover"
                AutoGenerateColumns="false"
                AllowPaging="true"
                AllowSorting="true"
                PageSize="5"
                OnPageIndexChanging="gvDepartments_PageIndexChanging"
                OnSorting="gvDepartments_Sorting">

                <Columns>

                    <asp:BoundField DataField="DepartmentId" HeaderText="Id ▲▼" SortExpression="DepartmentId" />
                    <asp:BoundField DataField="Name" HeaderText="Name ▲▼" SortExpression="Name" />
                    <asp:BoundField DataField="NoOfEmployee" HeaderText="NoOfEmp ▲▼" SortExpression="NoOfEmployee" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="badge <%# Eval("Status").ToString()=="Active"?"bg-success":"bg-danger" %>">
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy ▲▼" SortExpression="CreatedBy" />
                    <asp:BoundField DataField="ModifiedBy" HeaderText="ModifiedBy ▲▼" SortExpression="ModifiedBy" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton runat="server"
                                CommandArgument='<%# Eval("DepartmentId") %>'
                                OnClick="btnEdit_Click"
                                CausesValidation="false"
                                CssClass="me-2">✏️</asp:LinkButton>

                            <asp:LinkButton runat="server"
                                CommandArgument='<%# Eval("DepartmentId") %>'
                                OnClick="btnDelete_Click"
                                CausesValidation="false">🗑️</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

        </div>
    </div>
</div>

<!-- MODAL -->
<div class="modal fade" id="deptModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Add Department</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <asp:HiddenField ID="hfDeptId" runat="server" />

                <div class="mb-3">
                    <label>Department Name</label>
                    <asp:TextBox ID="txtDeptName" runat="server" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <label>Status</label>
                    <asp:DropDownList ID="ddlDeptStatus" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Select" Value="" />
                        <asp:ListItem Text="Active" />
                        <asp:ListItem Text="Inactive" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <asp:Button ID="btnSave" runat="server"
                    CssClass="btn btn-warning"
                    Text="Save Department"
                    UseSubmitBehavior="false"
                    OnClick="btnSave_Click" />
            </div>

        </div>
    </div>
</div>

<script>
    // OPEN modal
    function openDeptModal(title) {
        $('#modalTitle').text(title);
        $('#deptModal').modal('show');
    }

    // CLOSE modal
    function closeDeptModal() {
        $('#deptModal').modal('hide');

        // cleanup (important for UpdatePanel)
        $('.modal-backdrop').remove();
        $('body').removeClass('modal-open').css('padding-right', '');
    }

    // CLEAR modal for ADD
    function clearDeptModal() {
        $('#<%= hfDeptId.ClientID %>').val('');
        $('#<%= txtDeptName.ClientID %>').val('');
        $('#<%= ddlDeptStatus.ClientID %>').val('');
        $('#modalTitle').text('Add Department');
    }
</script>


    </ContentTemplate>
</asp:UpdatePanel>

</asp:Content>
