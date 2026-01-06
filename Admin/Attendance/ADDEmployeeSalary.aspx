<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ADDEmployeeSalary.aspx.cs" Inherits="HR_System.Admin.Attendance.ADDEmployeeSalary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add Employee Salary</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f6fa;
        }

        .card {
            border-radius: 8px;
        }

        .section-title {
            font-weight: 600;
            margin-top: 15px;
        }

        .amount-box {
            background: #eef1f4;
            border: none;
            border-radius: 6px;
            height: 40px;
        }

        .save-btn {
            background: #f26522;
            color: #fff;
        }

        .save-btn:hover {
            background: #d9571e;
            color: #fff;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="container mt-4">
    <div class="card p-4 shadow-sm">

        <h5 class="mb-4">Add Employee Salary</h5>

        <!-- Employee -->
        <div class="mb-3">
            <label class="form-label">Select Employee</label>
            <select class="form-select" id="employeeSelect">
                <option>-- Select Employee --</option>
                <option>John Doe</option>
                <option>Rahul Sharma</option>
            </select>
        </div>

        <!-- Total Salary -->
        <div class="mb-3">
            <label class="form-label">Total Salary</label>
            <input type="number" id="totalSalary" class="form-control"
                   placeholder="Enter total salary" onkeyup="calculateSalary()" />
        </div>

        <!-- Earnings -->
        <div class="section-title">Earnings</div>
        <div class="mb-2 text-muted">Bonus (5.00%)</div>
        <input type="text" id="bonusAmount" class="form-control amount-box mb-3" readonly />

        <!-- Deductions -->
        <div class="section-title">Deductions</div>
        <div class="mb-2 text-muted">Tax (10.00%)</div>
        <input type="text" id="taxAmount" class="form-control amount-box mb-4" readonly />

        <!-- Save -->
        <div class="text-end">
            <button type="button" class="btn save-btn px-4">
                Save Salary
            </button>
        </div>

    </div>
</div>

</form>

<script>
    function calculateSalary() {

        let total = parseFloat(document.getElementById("totalSalary").value);

        if (isNaN(total)) {
            document.getElementById("bonusAmount").value = "";
            document.getElementById("taxAmount").value = "";
            return;
        }

        let bonus = (total * 5) / 100;
        let tax = (total * 10) / 100;

        document.getElementById("bonusAmount").value = bonus.toFixed(2);
        document.getElementById("taxAmount").value = tax.toFixed(2);
    }
</script>

</body>
</html>

</asp:Content>
