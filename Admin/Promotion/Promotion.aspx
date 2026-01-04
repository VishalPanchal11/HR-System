<%@ Page Title="Promotion Management" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Promotion.aspx.cs" Inherits="HR_System.Admin.Promotion.Promotion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="page-title">Promotion Management</h2>

    <!-- Filter Panel -->
    <asp:Panel ID="pnlFilter" runat="server" CssClass="card mb-3">
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <label>Search Employee</label>
                    <asp:TextBox ID="txtSearchEmployee" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-3">
                    <label>From Date</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-3">
                    <label>To Date</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-2 mt-4">
                    <asp:Button ID="btnFilter" runat="server" CssClass="btn btn-primary" Text="Filter" OnClick="btnFilter_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Form Panel -->
    <asp:Panel ID="pnlForm" runat="server" CssClass="card mb-3">
        <div class="card-body">

            <asp:HiddenField ID="hfPromotionID" runat="server" />

            <div class="row">
                <div class="col-md-6">
                    <label>Employee Name</label>
                    <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6">
                    <label>Promotion Date</label>
                    <asp:TextBox ID="txtPromotionDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <div class="row mt-2">
                <div class="col-md-6">
                    <label>Designation From</label>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6">
                    <label>Designation To</label>
                    <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="mt-3">
                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-secondary" Text="Clear" OnClick="btnClear_Click" />
            </div>

        </div>
    </asp:Panel>

    <!-- Grid -->
    <asp:GridView ID="gvPromotion" runat="server" CssClass="table table-bordered table-hover"
        AutoGenerateColumns="false" OnRowCommand="gvPromotion_RowCommand"
        AllowSorting="true" OnSorting="gvPromotion_Sorting">

        <Columns>
            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" />
            <asp:BoundField DataField="DesignationFrom" HeaderText="From" SortExpression="DesignationFrom" />
            <asp:BoundField DataField="DesignationTo" HeaderText="To" SortExpression="DesignationTo" />
            <asp:BoundField DataField="PromotionDate" HeaderText="Date" SortExpression="PromotionDate" DataFormatString="{0:yyyy-MM-dd}" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditRow"
                        CommandArgument='<%# Eval("PromotionID") %>'>✏️</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteRow"
                        CommandArgument='<%# Eval("PromotionID") %>' OnClientClick="return confirm('Are you sure?');">🗑️</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
