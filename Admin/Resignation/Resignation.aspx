<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master"
    AutoEventWireup="true" CodeBehind="Resignation.aspx.cs"
    Inherits="HR_System.Admin.Resignation.Resignation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="mb-3">Resignation</h2>

    <!-- FILTERS -->
    <div class="row mb-3">
        <div class="col-md-3">
            <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                <asp:ListItem Value="">Sort By</asp:ListItem>
                <asp:ListItem Value="ASC">Ascending</asp:ListItem>
                <asp:ListItem Value="DESC">Descending</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtFromDate" runat="server"
                CssClass="form-control"
                TextMode="Date" />
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtToDate" runat="server"
                CssClass="form-control"
                TextMode="Date" />
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnFilter" runat="server"
                Text="Filter"
                CssClass="btn btn-primary w-100"
                OnClick="btnFilter_Click" />
        </div>
    </div>

    <!-- SEARCH -->
    <div class="row mb-2">
        <div class="col-md-4 offset-md-8">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control"
                Placeholder="Search by reason..."
                AutoPostBack="true"
                OnTextChanged="txtSearch_TextChanged" />
        </div>
    </div>

    <!-- GRID -->
    <asp:GridView ID="gvResignation" runat="server"
        CssClass="table table-bordered table-striped"
        AutoGenerateColumns="false"
        AllowPaging="true"
        PageSize="10"
        OnPageIndexChanging="gvResignation_PageIndexChanging"
        OnRowCommand="gvResignation_RowCommand">

        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="User ID" />
            <asp:BoundField DataField="DepartmentId" HeaderText="Department ID" />
            <asp:BoundField DataField="Reason" HeaderText="Reason" />
            <asp:BoundField DataField="NoticeDate"
                HeaderText="Notice Date"
                DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="ResignDate"
                HeaderText="Resignation Date"
                DataFormatString="{0:yyyy-MM-dd}" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server"
                        CommandName="EditRow"
                        CommandArgument='<%# Eval("ResignationID") %>'>
                        ✏️
                    </asp:LinkButton>

                    &nbsp;

                    <asp:LinkButton ID="btnDelete" runat="server"
                        CommandName="DeleteRow"
                        CommandArgument='<%# Eval("ResignationID") %>'
                        OnClientClick="return confirm('Are you sure?');">
                        🗑️
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>

    <!-- TOTAL ENTRIES -->
    <div class="mt-2">
        <asp:Label ID="lblTotal" runat="server"
            CssClass="text-muted"></asp:Label>
    </div>

</asp:Content>
