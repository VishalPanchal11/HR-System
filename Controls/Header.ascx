<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="Header.ascx.cs"
    Inherits="HR_System.Controls.Header" %>
<nav class="navbar navbar-light bg-white border-bottom px-3">
    <div class="d-flex align-items-center gap-3">
        <button type="button"
        class="btn btn-link"
        onclick="toggleSidebar()">
    <i class="bi bi-list"></i>
</button>


        <span class="fw-bold fs-4">
            Nexus<span class="text-warning">Track</span>
        </span>
    </div>

    <div class="dropdown">
        <a class="text-dark fw-semibold dropdown-toggle text-decoration-none"
           href="#" role="button" data-bs-toggle="dropdown">
            Profile
        </a>

        <ul class="dropdown-menu dropdown-menu-end">
            <li>
                <asp:HyperLink ID="lnkProfile" CssClass="dropdown-item" runat="server">
                    My Profile
                </asp:HyperLink>
            </li>
            <li><hr class="dropdown-divider" /></li>
            <li>
                <asp:HyperLink NavigateUrl="~/Auth/Logout.aspx"
                               CssClass="dropdown-item text-danger"
                               runat="server">
                    Logout
                </asp:HyperLink>
            </li>
        </ul>
    </div>
</nav>
