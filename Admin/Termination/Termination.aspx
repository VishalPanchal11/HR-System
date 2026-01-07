<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="Termination.aspx.cs" Inherits="HR_System.Admin.Termination.Termination" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="page-title">Termination Management</h2>

<!-- Filter -->
<asp:Panel runat="server" CssClass="card mb-3">
    <div class="card-body row">
        <div class="col-md-4">
            <label>Termination Type</label>
            <asp:TextBox ID="txtSearchType" runat="server" CssClass="form-control" />
        </div>
        <div class="col-md-3">
            <label>From Date</label>
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"/>
        </div>
        <div class="col-md-3">
            <label>To Date</label>
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"/>
        </div>
        <div class="col-md-2 mt-4">
            <asp:Button ID="btnFilter" runat="server" Text="Filter"
                CssClass="btn btn-primary" OnClick="btnFilter_Click"/>
        </div>
    </div>
</asp:Panel>

<!-- Form -->
<asp:Panel runat="server" CssClass="card mb-3">
    <div class="card-body">

        <asp:HiddenField ID="hfTerminationId" runat="server"/>

        <div class="row">
            <div class="col-md-6">
                <label>User ID</label>
                <asp:TextBox ID="txtUserID" runat="server" CssClass="form-control"/>
            </div>
            <div class="col-md-6">
                <label>Termination Type</label>
                <asp:TextBox ID="txtTerminationType" runat="server" CssClass="form-control"/>
            </div>
        </div>

        <div class="row mt-2">
            <div class="col-md-6">
                <label>Notice Date</label>
                <asp:TextBox ID="txtNoticeDate" runat="server" TextMode="Date" CssClass="form-control"/>
            </div>
            <div class="col-md-6">
                <label>Resign Date</label>
                <asp:TextBox ID="txtResignDate" runat="server" TextMode="Date" CssClass="form-control"/>
            </div>
        </div>

        <div class="mt-2">
            <label>Reason</label>
            <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine"
                CssClass="form-control"/>
        </div>

        <div class="mt-3">
            <asp:Button ID="btnSave" runat="server" Text="Save"
                CssClass="btn btn-primary" OnClick="btnSave_Click"/>
            <asp:Button ID="btnClear" runat="server" Text="Clear"
                CssClass="btn btn-secondary" OnClick="btnClear_Click"/>
        </div>

    </div>
</asp:Panel>

<!-- Grid -->
<asp:GridView ID="gvTermination" runat="server"
    CssClass="table table-bordered"
    AutoGenerateColumns="false"
    OnRowCommand="gvTermination_RowCommand"
    AllowSorting="true"
    OnSorting="gvTermination_Sorting">

    <Columns>
        <asp:BoundField DataField="UserID" HeaderText="User ID" SortExpression="UserID"/>
        <asp:BoundField DataField="TerminationType" HeaderText="Termination Type" SortExpression="TerminationType"/>
        <asp:BoundField DataField="NoticeDate" HeaderText="Notice Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="NoticeDate"/>
        <asp:BoundField DataField="ResignDate" HeaderText="Resign Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="ResignDate"/>
        <asp:BoundField DataField="Reason" HeaderText="Reason"/>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:LinkButton CommandName="EditRow" CommandArgument='<%# Eval("TerminationId") %>'>✏️</asp:LinkButton>
                &nbsp;
                <asp:LinkButton CommandName="DeleteRow" CommandArgument='<%# Eval("TerminationId") %>'
                    OnClientClick="return confirm('Are you sure?');">🗑️</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</asp:Content>
