<%@ Control Language="C#" AutoEventWireup="true"
    CodeBehind="SideBar.ascx.cs"
    Inherits="HR_System.Controls.SideBar" %>

<asp:Panel ID="pnlSidebar" runat="server">

    <!-- ================= ADMIN SIDEBAR ================= -->
    <asp:Panel ID="pnlAdmin" runat="server" Visible="false">

        <strong>Employee</strong><br />
        <asp:HyperLink NavigateUrl="~/Admin/Employee/Departments.aspx" runat="server">Departments</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Employee/Designations.aspx" runat="server">Designations</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Employee/Roles.aspx" runat="server">Roles</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Employee/Employees.aspx" runat="server">Employees</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Employee/Profile.aspx" runat="server">Profile</asp:HyperLink>
        <br /><br />

        <strong>Training</strong><br />
        <asp:HyperLink NavigateUrl="~/Admin/Training/TrainingList.aspx" runat="server">Training List</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Training/Trainers.aspx" runat="server">Trainers</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Training/TrainingType.aspx" runat="server">Training Type</asp:HyperLink>
        <br /><br />

        <strong>Documents</strong><br />
        <asp:HyperLink NavigateUrl="~/Admin/Documents/MasterDocuments.aspx" runat="server">Master Documents</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Documents/Documents.aspx" runat="server">Documents</asp:HyperLink>
        <br /><br />

        <%--
        <asp:HyperLink NavigateUrl="~/Admin/Attendance.aspx" runat="server">Attendance</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Payroll.aspx" runat="server">Payroll</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Timesheet.aspx" runat="server">Timesheet</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Projects.aspx" runat="server">Projects</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Performance.aspx" runat="server">Performance</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Promotion.aspx" runat="server">Promotion</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Resignation.aspx" runat="server">Resignation</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Termination.aspx" runat="server">Termination</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Events.aspx" runat="server">Events</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Tickets.aspx" runat="server">Tickets</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Admin/Reports.aspx" runat="server">Reports</asp:HyperLink>
        --%>

    </asp:Panel>

    <!-- ================= MANAGER SIDEBAR ================= -->
    <asp:Panel ID="pnlManager" runat="server" Visible="false">
        <asp:HyperLink NavigateUrl="~/Manager/Profile.aspx" runat="server">Profile</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Manager/Timesheets.aspx" runat="server">Timesheets</asp:HyperLink>
    </asp:Panel>

    <!-- ================= EMPLOYEE SIDEBAR ================= -->
    <asp:Panel ID="pnlEmployee" runat="server" Visible="false">

        <asp:HyperLink NavigateUrl="~/Employee/Profile.aspx" runat="server">Profile</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Employee/Documents.aspx" runat="server">Documents</asp:HyperLink><br />

        <%--
        <asp:HyperLink NavigateUrl="~/Employee/Attendance.aspx" runat="server">Attendance</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Employee/Payroll.aspx" runat="server">Payroll</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Employee/Timesheet.aspx" runat="server">Timesheet</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Employee/Events.aspx" runat="server">Events</asp:HyperLink><br />
        <asp:HyperLink NavigateUrl="~/Employee/Tickets.aspx" runat="server">Tickets</asp:HyperLink>
        --%>

    </asp:Panel>

</asp:Panel>
