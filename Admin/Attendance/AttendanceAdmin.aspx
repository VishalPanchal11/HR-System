<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AttendanceAdmin.aspx.cs" Inherits="HR_System.Admin.Attendance.AttendanceAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f5f6fa;
        }

        .page-container {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        }

        .page-title {
            font-size: 18px;
            font-weight: 600;
            color: #0d1b2a;
            margin-bottom: 15px;
        }

        /* Filters */
        .filter-bar {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }

        .date-input,
        .dropdown,
        .search-box {
            height: 34px;
            padding: 5px 10px;
            border: 1px solid #dcdfe6;
            border-radius: 4px;
            font-size: 13px;
            color: #555;
            background-color: #fff;
        }

        .search-box {
            margin-left: auto;
            width: 200px;
        }

        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 9999;
        }

        .modal-box {
            background: #fff;
            width: 420px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 8px;
        }

        .modal-title {
            text-align: center;
            font-size: 20px;
            margin-bottom: 15px;
        }

        .modal-input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .save-btn {
            width: 100%;
            background: #f97316;
            color: #fff;
            border: none;
            padding: 10px;
            font-weight: 600;
            border-radius: 4px;
            cursor: pointer;
        }

        .close-btn {
            width: 100%;
            margin-top: 8px;
            padding: 8px;
            background: #e5e7eb;
            border: none;
            border-radius: 4px;
        }

        /* GridView */
        .attendance-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

            .attendance-grid th {
                background-color: #e9ecef;
                color: #000;
                font-weight: 600;
                font-size: 13px;
                padding: 10px;
                border-bottom: 1px solid #dee2e6;
                text-align: left;
            }

            .attendance-grid td {
                padding: 12px 10px;
                font-size: 13px;
                color: #495057;
                border-bottom: 1px solid #e6e9f0;
                vertical-align: middle;
            }

            .attendance-grid tr:hover td {
                background-color: #f8f9fb;
            }

        /* Status badges */
        .badge-present {
            background-color: #00c853;
            color: #fff;
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }

        .badge-absent {
            background-color: #e53935;
            color: #fff;
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }

        /* Production hours */
        .prod-hours {
            background-color: #e53935;
            color: #fff;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
        }

        /* Action */
        .action-btn {
            color: #000;
            font-size: 16px;
            text-decoration: none;
        }

            .action-btn:hover {
                color: #0d6efd;
                cursor: pointer;
            }
    </style>

    <!DOCTYPE html>
    <html>
    <head>
        <title>Admin Attendance</title>
        <link href="Content/attendance.css" rel="stylesheet" />
    </head>
    <body>

        <div class="page-container">

            <!-- Header -->
            <h2 class="page-title">Admin Attendance</h2>
            <asp:Label ID="Label1" runat="server" Text="StartDate"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Label ID="Label2" runat="server" Text="EndDate"></asp:Label>
            <!-- Filters -->
            <div class="filter-bar">

                <asp:TextBox ID="txtStartDate" runat="server" CssClass="date-input" placeholder="dd-mm-yyyy" TextMode="Date" />
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="date-input" placeholder="dd-mm-yyyy" TextMode="Date" />

                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="All Departments" Value="" />
                    <asp:ListItem Text="IT" Value="IT" />
                </asp:DropDownList>

                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="dropdown">
                    <asp:ListItem Text="All" Value="" />
                    <asp:ListItem Text="Present" Value="Present" />
                    <asp:ListItem Text="Absent" Value="Absent" />
                </asp:DropDownList>

                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search" />
            </div>

            <!-- GridView -->
            <asp:GridView ID="gvAttendance" runat="server"
                CssClass="attendance-grid"
                AutoGenerateColumns="False"
                GridLines="None" DataSourceID="attendanceadminShowDB" DataKeyNames="AttendanceId" OnRowEditing="AttendanceadminEdit">

                <Columns>

                    <asp:BoundField DataField="AttendanceId" HeaderText="AttendanceId" InsertVisible="False" ReadOnly="True" SortExpression="AttendanceId" />

                    <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />

                    <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="CheckIn" HeaderText="CheckIn" SortExpression="CheckIn" />
                    <asp:BoundField DataField="CheckOut" HeaderText="CheckOut" SortExpression="CheckOut" />

                    <asp:BoundField DataField="Break" HeaderText="Break" ReadOnly="True" SortExpression="Break" />
                    <asp:BoundField DataField="Late" HeaderText="Late" SortExpression="Late" />
                    <asp:BoundField DataField="ProductionHours" HeaderText="ProductionHours" SortExpression="ProductionHours" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="action-btn" CommandName="EditAttendance" CommandArgument='<%# Eval("AttendanceId") %>' OnClientClick="openModal(); return false;"> ✏️
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>


                </Columns>
            </asp:GridView>
            <!-- ===== Edit Attendance Modal ===== -->
            <div id="editModal" class="modal-overlay">
                <div class="modal-box">

                    <h3 class="modal-title">Edit Attendance</h3>

                    <asp:HiddenField ID="hfAttendanceId" runat="server" />

                    <label>Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="modal-input" />

                    <label>Check In</label>
                    <asp:TextBox ID="txtCheckIn" runat="server" CssClass="modal-input" />

                    <label>Check Out</label>
                    <asp:TextBox ID="txtCheckOut" runat="server" CssClass="modal-input" />

                    <label>Break</label>
                    <asp:TextBox ID="txtBreak" runat="server" CssClass="modal-input" />

                    <label>Late</label>
                    <asp:TextBox ID="txtLate" runat="server" CssClass="modal-input" />

                    <label>Production Hours</label>
                    <asp:TextBox ID="txtProduction" runat="server" CssClass="modal-input" />

                    <label>Status</label>
                    <asp:DropDownList ID="ddlEditStatus" runat="server" CssClass="modal-input">
                        <asp:ListItem Text="Present" />
                        <asp:ListItem Text="Absent" />                
                    </asp:DropDownList>

                    <asp:Button ID="btnSave" runat="server" Text="Save"
                        CssClass="save-btn" OnClick="AttendanceAdmin_edit"
                        />

                    <button type="button" class="close-btn" onclick="closeModal()">Cancel</button>

                </div>
            </div>

            <asp:SqlDataSource ID="attendanceadminShowDB" runat="server" ConnectionString="<%$ ConnectionStrings:HRdbCon %>" SelectCommand="Pro_showAttendance" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

        </div>
        <script>
            function openModal() {
                document.getElementById("editModal").style.display = "block";
            }

            function closeModal() {
                document.getElementById("editModal").style.display = "none";
            }
        </script>

    </body>
    </html>
</asp:Content>
