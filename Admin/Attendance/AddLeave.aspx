<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="AddLeave.aspx.cs" Inherits="HR_System.Admin.Attendance.AddLeave" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-body">

                <h5 class="fw-bold mb-4">Allocate Leave Deptwise</h5>

                <!-- Department -->
                <div class="mb-3">
                    <label class="form-label">Select Department</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Select Department" Value="" />
                    </asp:DropDownList>
                </div>

                <!-- Leave Type -->
                <div class="mb-3">
                    <label class="form-label">Select Leave Type</label>
                    <asp:DropDownList ID="ddlLeaveType" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Select Leave Type" Value="" />
                    </asp:DropDownList>
                </div>

                <!-- Number of Leaves -->
                <div class="mb-4">
                    <label class="form-label">Number of Leaves Allocated</label>
                    <asp:TextBox ID="txtLeaves" runat="server"
                        CssClass="form-control"
                        placeholder="Enter number of leaves"
                        TextMode="Number" />
                </div>

                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server"
                        CssClass="form-select">
                        <asp:ListItem Text="Select Status" Value="" />
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>
                </div>

                <!-- Button -->
                <asp:Button ID="btnAllocate" runat="server"
                    Text="Allocate Leave"
                    CssClass="btn btn-warning text-white px-4" OnClick="btnAllocate_Click"/>

            </div>
        </div>
    </div>

</asp:Content>
