<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="Header.ascx.cs"
    Inherits="HR_System.Controls.Header" %>

<div>
    <strong style="font-size:24px;">NexusTrack</strong>

    <div style="float:right;">
        <asp:HyperLink ID="lnkProfile" runat="server">Profile</asp:HyperLink>
        |
        <asp:HyperLink NavigateUrl="~/Auth/Logout.aspx" runat="server">Log Out</asp:HyperLink>
    </div>
</div>
<hr />
