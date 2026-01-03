<%@ Page Title="Resignation"
    Language="C#"
    MasterPageFile="~/Masters/Admin.Master"
    AutoEventWireup="true"
    CodeBehind="Resignation.aspx.cs"
    Inherits="HR_System.Admin.Resignation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<link href="~/Content/resignation.css" rel="stylesheet" />

<div class="container mt-4">

    <h3 class="mb-4">Employee Resignation</h3>

    <asp:HiddenField ID="hfResignationID" runat="server" />

    <div class="card mb-4">
        <div class="card-body">

            <div class="row g-3">

                <div class="col-md-4">
                    <label>User ID</label>
                    <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Department ID</label>
                    <asp:TextBox ID="txtDepartmentId" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Notice Date</label>
                    <asp:TextBox ID="txtNoticeDate" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

                <div class="col-md-4">
                    <label>Resign Date</label>
                    <asp:TextBox ID="txtResignDate" runat="server" TextMode="Date" CssClass="form-control" />
                </div>

                <div class="col-md-8">
                    <label>Reason</label>
                    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="3"
                        CssClass="form-control" />
                </div>

                <div class="col-12 text-end">
                    <asp:Button ID="btnSave" runat="server"
                        Text="Save"
                        CssClass="btn btn-primary"
                        OnClick="btnSave_Click" />
                </div>

            </div>
        </div>
    </div>

    <asp:GridView ID="gvResignation"
        runat="server"
        CssClass="table table-bordered table-striped"
        AutoGenerateColumns="False"
        DataKeyNames="ResignationID"
        OnRowDeleting="gvResignation_RowDeleting"
        OnSelectedIndexChanged="gvResignation_SelectedIndexChanged">

        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="ResignationID" HeaderText="ID" />
            <asp:BoundField DataField="UserID" HeaderText="User ID" />
            <asp:BoundField DataField="DepartmentId" HeaderText="Department" />
            <asp:BoundField DataField="NoticeDate" HeaderText="Notice Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="ResignDate" HeaderText="Resign Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="Reason" HeaderText="Reason" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>

    </asp:GridView>

</div>
</asp:Content>
