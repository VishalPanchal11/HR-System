<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Admin.Master" AutoEventWireup="true" CodeBehind="Resignation.aspx.cs" Inherits="HR_System.Admin.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/Content/resignation.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
    <h2>Employee Resignation</h2>

    <asp:HiddenField ID="hfResignationID" runat="server" />

    <label>User ID</label>
    <asp:TextBox ID="txtUserID" runat="server" CssClass="input" />

    <label>Department ID</label>
    <asp:TextBox ID="txtDeptID" runat="server" CssClass="input" />

    <label>Notice Date</label>
    <asp:TextBox ID="txtNoticeDate" runat="server" TextMode="Date" CssClass="input" />

    <label>Resign Date</label>
    <asp:TextBox ID="txtResignDate" runat="server" TextMode="Date" CssClass="input" />

    <label>Reason</label>
    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" CssClass="textarea" />

    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn"
        OnClick="btnSave_Click" />
</div>

<hr />

<asp:GridView ID="gvResignation" runat="server" AutoGenerateColumns="false"
    CssClass="grid" OnRowCommand="gvResignation_RowCommand">
    <Columns>
        <asp:BoundField DataField="ResignationID" HeaderText="ID" />
        <asp:BoundField DataField="UserID" HeaderText="User" />
        <asp:BoundField DataField="DepartmentId" HeaderText="Department" />
        <asp:BoundField DataField="NoticeDate" HeaderText="Notice Date" />
        <asp:BoundField DataField="ResignDate" HeaderText="Resign Date" />
        <asp:BoundField DataField="Reason" HeaderText="Reason" />

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:Button ID="btnDelete"
                    runat="server"
                    Text="Delete"
                    CssClass="btn"
                    CommandName="del"
                    CommandArgument='<%# Eval("ResignationID") %>'
                    OnClientClick="return confirm('Are you sure you want to delete?');" />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>
</asp:Content>
