<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="Header.ascx.cs"
    Inherits="HR_System.Controls.Header" %>

<div class="header">
    <div class="logo">Nexus<span>Track</span></div>

    <div class="header-actions">
        <asp:HyperLink ID="lnkProfile" CssClass="header-link" runat="server">Profile</asp:HyperLink>
        <asp:HyperLink CssClass="header-link logout" NavigateUrl="~/Auth/Logout.aspx" runat="server">Log Out</asp:HyperLink>
    </div>
</div>
