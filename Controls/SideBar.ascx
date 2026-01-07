<%@ Control Language="C#" AutoEventWireup="true"
    CodeFile="SideBar.ascx.cs"
    Inherits="HR_System.Controls.SideBar" %>

<asp:Panel ID="pnlSidebar"
           runat="server"
           ClientIDMode="Static"
           CssClass="bg-white border-end vh-100 px-3 pt-3"
           Style="width:280px;">

    <!-- ================= ADMIN ================= -->
    <asp:Panel ID="pnlAdmin" runat="server" Visible="false">

        <div class="text-muted fw-semibold small mb-3 px-2">MAIN MENU</div>

        <!-- DASHBOARD -->
<button type="button"
        class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded"
        data-bs-toggle="collapse"
        data-bs-target="#dashboardMenu"
        onclick="onMenuToggle(this)">
    <span>Dashboard</span>
    <i class="bi bi-chevron-down"></i>
</button>

<div id="dashboardMenu" class="collapse ps-4">
    <a href="#" class="d-block py-1 text-dark text-decoration-none">Admin Dashboard</a>
    <a href="#" class="d-block py-1 text-dark text-decoration-none">Organisations</a>
</div>


        <!-- EMPLOYEES -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded"
                data-bs-toggle="collapse" data-bs-target="#empMenu" onclick="onMenuToggle(this)">
            <span>Employees</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="empMenu" class="collapse ps-4">
            <a href="/Admin/Employee/Departments.aspx" class="d-block py-1 text-dark text-decoration-none">Departments</a>
            <a href="/Admin/Employee/Designations.aspx" class="d-block py-1 text-dark text-decoration-none">Designations</a>
            <a href="/Admin/Employee/Roles.aspx" class="d-block py-1 text-dark text-decoration-none">Roles</a>
            <a href="/Admin/Employee/Employees.aspx" class="d-block py-1 text-dark text-decoration-none">Employees</a>
            <a href="/Admin/Employee/EmployeesGrid.aspx" class="d-block py-1 text-dark text-decoration-none">Employees Grid</a>
            <a href="/Admin/Employee/AdminProfile.aspx" class="d-block py-1 text-dark text-decoration-none">Profile</a>
        </div>

        <!-- DOCUMENTS -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#docMenu" onclick="onMenuToggle(this)">
            <span>Documents</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="docMenu" class="collapse ps-4">
            <a href="/Admin/Documents/MasterDocuments.aspx" class="d-block py-1 text-dark text-decoration-none">Master Documents</a>
            <a href="/Admin/Documents/Documents.aspx" class="d-block py-1 text-dark text-decoration-none">Documents</a>
        </div>

        <!-- TRAINING -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#trainingMenu" onclick="onMenuToggle(this)">
            <span>Training</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="trainingMenu" class="collapse ps-4">
            <a href="/Admin/Training/Trainers.aspx" class="d-block py-1 text-dark text-decoration-none">Trainers</a>
            <a href="/Admin/Training/TrainingList.aspx" class="d-block py-1 text-dark text-decoration-none">Training List</a>
            <a href="/Admin/Training/TrainingType.aspx" class="d-block py-1 text-dark text-decoration-none">Training Type</a>
        </div>

        <!-- ATTENDANCE -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#attendanceMenu" onclick="onMenuToggle(this)">
            <span>Attendance</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="attendanceMenu" class="collapse ps-4">
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Add Leave Type</a>
            <a href="/Admin/Attendance/AddLeave.aspx" class="d-block py-1 text-dark text-decoration-none">Add Leave</a>
            <a href="/Admin/Attendance/Attendance.aspx" class="d-block py-1 text-dark text-decoration-none">Attendance</a>
            <a href="/Admin/Attendance/AttendanceAdmin.aspx" class="d-block py-1 text-dark text-decoration-none">Attendance Admin</a>
            <a href="/Admin/Attendance/DepartmentLeaveShow.aspx" class="d-block py-1 text-dark text-decoration-none">Department Leave</a>
            <a href="/Admin/Attendance/ManageLeavesetting.aspx" class="d-block py-1 text-dark text-decoration-none">Leave Settings</a>
            <a href="/Admin/Attendance/Timesheet.aspx" class="d-block py-1 text-dark text-decoration-none">Timesheet</a>
        </div>

        <!-- PROJECTS -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#projectMenu" onclick="onMenuToggle(this)">
            <span>Projects</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="projectMenu" class="collapse ps-4">
            <a href="/Admin/Projects/AddProject.aspx" class="d-block py-1 text-dark text-decoration-none">Add Project</a>
            <a href="/Admin/Projects/AddTask.aspx" class="d-block py-1 text-dark text-decoration-none">Add Task</a>
            <a href="/Admin/Projects/EditProject.aspx" class="d-block py-1 text-dark text-decoration-none">Edit Project</a>
            <a href="/Admin/Projects/Project.aspx" class="d-block py-1 text-dark text-decoration-none">Project</a>
            <a href="/Admin/Projects/ProjectList.aspx" class="d-block py-1 text-dark text-decoration-none">Project List</a>
            <a href="/Admin/Projects/TaskList.aspx" class="d-block py-1 text-dark text-decoration-none">Task List</a>
        </div>

        <!-- PAYROLL (FUTURE) -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#payrollMenu" onclick="onMenuToggle(this)">
            <span>Payroll</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="payrollMenu" class="collapse ps-4">
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Add Employee Salary</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Master Payroll</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Employee Salary List</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Generate Payslip</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Transaction History</a>
        </div>

        <!-- REPORTS (FUTURE) -->
        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#reportsMenu" onclick="onMenuToggle(this)">
            <span>Reports</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="reportsMenu" class="collapse ps-4">
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Employee Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Attendance Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Leave Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Payslip Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Project Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Task Report</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Daily Report</a>
        </div>

        <!-- EVENTS / TICKETS (FUTURE) -->
        <a href="#" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none mt-3">Events</a>
        <a href="#" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none">Tickets</a>

        <!-- SIMPLE -->
        <a href="/Admin/Promotion/Promotion.aspx" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none mt-2">Promotion</a>
        <a href="/Admin/Resignation/Resignation.aspx" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none">Resignation</a>
        <a href="/Admin/Termination/Termination.aspx" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none">Termination</a>

    </asp:Panel>

    <!-- ================= MANAGER ================= -->
    <asp:Panel ID="pnlManager" runat="server" Visible="false">
        <a href="/Manager/Timesheets.aspx" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none">
            Timesheets
        </a>
    </asp:Panel>

    <!-- ================= EMPLOYEE ================= -->
    <asp:Panel ID="pnlEmployee" runat="server" Visible="false">

        <a href="/Employee/EmployeeProfile.aspx" class="d-block px-3 py-2 fw-semibold text-dark text-decoration-none">Profile</a>

        <button type="button" class="menu-btn w-100 d-flex justify-content-between align-items-center px-3 py-2 fw-semibold border-0 bg-transparent rounded mt-2"
                data-bs-toggle="collapse" data-bs-target="#empAttendance" onclick="onMenuToggle(this)">
            <span>Attendance</span><i class="bi bi-chevron-down"></i>
        </button>
        <div id="empAttendance" class="collapse ps-4">
            <a href="/Employee/Attendance/employeeattendance.aspx" class="d-block py-1 text-dark text-decoration-none">Attendance</a>
            <a href="/Employee/Attendance/Leaves.aspx" class="d-block py-1 text-dark text-decoration-none">Leaves</a>
            <a href="#" class="d-block py-1 text-dark text-decoration-none">Timesheet</a>
        </div>

        <a href="/Employee/Documents.aspx" class="d-block px-3 py-2 text-dark text-decoration-none">Documents</a>
        <a href="#" class="d-block px-3 py-2 text-dark text-decoration-none">Payslip</a>
        <a href="#" class="d-block px-3 py-2 text-dark text-decoration-none">Events</a>
        <a href="#" class="d-block px-3 py-2 text-dark text-decoration-none">Tickets</a>

    </asp:Panel>

</asp:Panel>
