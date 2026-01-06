<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeBehind="MasterPayroll.aspx.cs" Inherits="HR_System.Admin.Attendance.MasterPayroll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<!DOCTYPE html>
<html>
<head runat="server">
    <title>Payroll Setup</title>
</head>

<body>
<form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <h2>Payroll Structure</h2>

    <!-- Section Selector -->
    <asp:RadioButtonList ID="rblSections" runat="server"
        AutoPostBack="true"
        OnSelectedIndexChanged="rblSections_SelectedIndexChanged">

        <asp:ListItem Value="EarningType">Earning Types</asp:ListItem>
        <asp:ListItem Value="Earning">Earnings</asp:ListItem>
        <asp:ListItem Value="DeductionType">Deduction Types</asp:ListItem>
        <asp:ListItem Value="Deduction">Deductions</asp:ListItem>
    </asp:RadioButtonList>

    <br />

    <!-- Add Button -->
    <asp:Button ID="btnAdd" runat="server"
        CssClass="btn"
        Text="Add"
        OnClick="btnAdd_Click" />

    <br /><br />

    <!-- ======================= -->
    <!-- Earning Type Grid -->
    <!-- ======================= -->
    <asp:Panel ID="pnlEarningType" runat="server">

        <h3>Earning Types</h3>

        <asp:GridView ID="gvEarningType" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Code" DataField="Code" />
                <asp:BoundField HeaderText="Name" DataField="Name" />
            </Columns>
        </asp:GridView>

    </asp:Panel>

    <!-- ======================= -->
    <!-- Earning Grid -->
    <!-- ======================= -->
    <asp:Panel ID="pnlEarning" runat="server" Visible="false">

        <h3>Earnings</h3>

        <asp:GridView ID="gvEarning" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Code" DataField="Code" />
                <asp:BoundField HeaderText="Name" DataField="Name" />
                <asp:BoundField HeaderText="Type" DataField="Type" />
            </Columns>
        </asp:GridView>

    </asp:Panel>

    <!-- ======================= -->
    <!-- Deduction Type Grid -->
    <!-- ======================= -->
    <asp:Panel ID="pnlDeductionType" runat="server" Visible="false">

        <h3>Deduction Types</h3>

        <asp:GridView ID="gvDeductionType" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Code" DataField="Code" />
                <asp:BoundField HeaderText="Name" DataField="Name" />
            </Columns>
        </asp:GridView>

    </asp:Panel>

    <!-- ======================= -->
    <!-- Deduction Grid -->
    <!-- ======================= -->
    <asp:Panel ID="pnlDeduction" runat="server" Visible="false">

        <h3>Deductions</h3>

        <asp:GridView ID="gvDeduction" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField HeaderText="Code" DataField="Code" />
                <asp:BoundField HeaderText="Name" DataField="Name" />
                <asp:BoundField HeaderText="Type" DataField="Type" />
            </Columns>
        </asp:GridView>

    </asp:Panel>

    <!-- ======================= -->
    <!-- ADD FORM POPUP -->
    <!-- ======================= -->

    <asp:Panel ID="pnlPopup" runat="server" CssClass="popup" Style="background:#fff; padding:15px; border:1px solid #ccc;">
        <h3>
            <asp:Label ID="lblPopupTitle" runat="server" />
        </h3>

        Code:
        <asp:TextBox ID="txtCode" runat="server" /><br /><br />

        Name:
        <asp:TextBox ID="txtName" runat="server" /><br /><br />

        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        <asp:Button ID="btnClose" runat="server" Text="Cancel" />

    </asp:Panel>

    <!-- Modal Extender -->
    <ajax:modalpopupextender
        ID="popupExt"
        runat="server"
        TargetControlID="btnHiddenTrigger"
        PopupControlID="pnlPopup"
        CancelControlID="btnClose" />

    <asp:Button ID="btnHiddenTrigger" runat="server" Style="display:none" />

</form>
</body>
</html>


</asp:Content>
