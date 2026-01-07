<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EmployeeMaster.Master" AutoEventWireup="true" CodeFile="Attendanceadmin.aspx.cs" Inherits="HR_System.Employee.Attendance.Attendanceadmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .profile-card {
            text-align: center;
            padding: 30px;
        }

        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin: 20px auto;
            border: 4px solid #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .production-badge {
            background-color: #fd7e14;
            color: white;
            padding: 8px 20px;
            border-radius: 6px;
            font-weight: 600;
            display: inline-block;
            margin: 15px 0;
        }

        .punch-status {
            color: #6c757d;
            font-size: 14px;
            margin: 15px 0;
        }

        .punch-status i {
            color: #0d6efd;
        }

        .attendance-btn {
            background-color: #fd7e14;
            border: none;
            color: white;
            padding: 12px 40px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            max-width: 250px;
        }

        .attendance-btn:hover {
            background-color: #e86b0b;
            transform: translateY(-2px);
        }

        .attendance-btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        .table-card {
            margin-top: 20px;
        }

        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: #495057;
            padding: 12px;
        }

        .table tbody td {
            padding: 12px;
            vertical-align: middle;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-success {
            background-color: #198754;
            color: white;
        }

        .badge-danger {
            background-color: #dc3545;
            color: white;
        }

        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }

        .filter-section {
            display: flex;
            gap: 15px;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-section label {
            margin: 0;
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 6px;
        }

        .greeting-text {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .time-text {
            font-size: 18px;
            font-weight: 600;
            color: #212529;
        }
    </style>
</head>
<body>
 

        
        <div class="container-fluid py-4">
            <h2 class="mb-4">Employee Attendance</h2>

            <div class="row">
                <!-- Profile Card -->
                <div class="col-lg-3 col-md-4 mb-4">
                    <div class="card profile-card">
                        <div class="greeting-text">
                            Good Morning, <asp:Label ID="lblEmployeeName" runat="server" />
                        </div>
                        <div class="time-text">
                            <asp:Label ID="lblCurrentTime" runat="server" />
                        </div>

                        <img src="" alt="Profile" class="profile-image" />

                        <div class="production-badge">
                            Production: <asp:Label ID="lblProduction" runat="server" Text="0h:0m" />
                        </div>

                        <div class="punch-status">
                            <i class="ti ti-fingerprint"></i>
                            Punch In at <strong><asp:Label ID="lblCheckInTime" runat="server" Text="Not Checked In" /></strong>
                        </div>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="btnAttendance"
                                    CssClass="attendance-btn" 
                                    Text="Check-In" 
                                    OnClick="btnAttendance_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>

                <!-- Attendance Table -->
                <div class="col-lg-9 col-md-8">
                    <div class="card table-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0">Employee Attendance</h5>
                        </div>
                        <div class="card-body">
                            <div class="filter-section">
                                <div class="d-flex align-items-center">
                                    <label class="me-2">Start:</label>
                                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" 
                                        CssClass="form-control" AutoPostBack="true" 
                                        />
                                </div>
                                <div class="d-flex align-items-center">
                                    <label class="me-2">End:</label>
                                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" 
                                        CssClass="form-control" AutoPostBack="true"  />
                                </div>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select" 
                                    AutoPostBack="true">
                                    <asp:ListItem Value="">Select Status</asp:ListItem>
                                    <asp:ListItem Value="Present">Present</asp:ListItem>
                                    <asp:ListItem Value="Absent">Absent</asp:ListItem>
                                    <asp:ListItem Value="Half Day">Half Day</asp:ListItem>
                                </asp:DropDownList>
                                <div class="d-flex align-items-center">
                                    <label class="me-2">Rows:</label>
                                    <asp:DropDownList ID="ddlRowsPerPage" runat="server" CssClass="form-select" 
                                        AutoPostBack="true" >
                                        <asp:ListItem Value="10">10</asp:ListItem>
                                        <asp:ListItem Value="25">25</asp:ListItem>
                                        <asp:ListItem Value="50">50</asp:ListItem>
                                        <asp:ListItem Value="100">100</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" 
                                    placeholder="Search" />
                            </div>

                            <div class="table-responsive">
                                <asp:GridView ID="gvAttendance" runat="server" 
                                    AutoGenerateColumns="False"
                                    CssClass="table table-hover"
                                    GridLines="None"
                                    AllowPaging="True"
                                    PageSize="10"
                        >
                                    <Columns>
                                        <asp:BoundField DataField="Date" HeaderText="Date" 
                                            DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:BoundField DataField="CheckIn" HeaderText="Check In" 
                                            DataFormatString="{0:hh:mm tt}" />
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                               
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CheckOut" HeaderText="Check Out" 
                                            DataFormatString="{0:hh:mm tt}" />
                                        <asp:BoundField DataField="BreakHours" HeaderText="Break" />
                                        <asp:BoundField DataField="Late" HeaderText="Late" />
                                        <asp:BoundField DataField="OvertimeHours" HeaderText="Overtime" />
                                        <asp:TemplateField HeaderText="Production Hours">
                                            <ItemTemplate>
                                        
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light" />
                                    <PagerStyle CssClass="pagination" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Client-side search filter
        document.getElementById('<%= txtSearch.ClientID %>').addEventListener('input', function() {
            var searchText = this.value.toLowerCase();
            var table = document.getElementById('<%= gvAttendance.ClientID %>');
            var rows = table.getElementsByTagName('tr');
            
            for (var i = 1; i < rows.length; i++) {
                var row = rows[i];
                var cells = row.getElementsByTagName('td');
                var found = false;
                
                for (var j = 0; j < cells.length; j++) {
                    if (cells[j].textContent.toLowerCase().includes(searchText)) {
                        found = true;
                        break;
                    }
                }
                
                row.style.display = found ? '' : 'none';
            }
        });
    </script>
</body>
</html>
</asp:Content>
