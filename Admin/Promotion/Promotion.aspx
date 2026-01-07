<%@ Page Title="Promotion" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="Promotion.aspx.cs" Inherits="HR_System.Admin.Promotion.Promotion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="promotion.css" rel="stylesheet" />

    <div class="promotion-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title">Promotion</h2>
            <asp:LinkButton ID="btnAddPromotion" runat="server" CssClass="btn btn-orange" OnClick="btnAdd_Click">
                <i class="fa fa-plus-circle"></i> Add Promotion
            </asp:LinkButton>
        </div>

        <asp:Panel ID="pnlForm" runat="server" CssClass="card shadow-sm mb-4">
            <div class="card-header bg-white"><h5>Add/Edit Promotion</h5></div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Employee Name</label>
                        <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Promotion Date</label>
                        <asp:TextBox ID="txtPromotionDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Designation From</label>
                        <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Designation To</label>
                        <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" />
                    </div>
                </div>
                
                <asp:HiddenField ID="hfPromotionID" runat="server" />

                <div class="mt-3">
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-orange" OnClick="btnSave_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" />
                </div>
            </div>
        </asp:Panel>

        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                <div class="row align-items-center">
                    <div class="col-md-4">
                        <h5 class="mb-0">Promotion List</h5>
                    </div>
                    <div class="col-md-8 d-flex justify-content-end gap-2">
                        <div class="filter-group d-flex align-items-center">
                            <label class="me-2">Sort:</label>
                            <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged" CssClass="form-select border">
                                <asp:ListItem Text="Ascending" Value="ASC"></asp:ListItem>
                                <asp:ListItem Text="Descending" Value="DESC" Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="filter-group d-flex align-items-center">
                            <label class="me-2">Date:</label>
                            <asp:DropDownList ID="ddlDateFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged" CssClass="form-select border">
                                <asp:ListItem Text="All Records" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Today" Value="Today"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6 text-end ms-auto">
                        Search: <asp:TextBox ID="txtSearchEmployee" runat="server" AutoPostBack="true" OnTextChanged="FilterChanged" CssClass="form-control d-inline-block w-auto" />
                    </div>
                </div>
                <asp:GridView ID="gvPromotion" runat="server" CssClass="table table-hover" AutoGenerateColumns="false" OnRowCommand="gvPromotion_RowCommand" GridLines="None" ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                        <asp:BoundField DataField="DesignationFrom" HeaderText="From" />
                        <asp:BoundField DataField="DesignationTo" HeaderText="To" />
                        <asp:BoundField DataField="PromotionDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="EditRow" CommandArgument='<%# Eval("PromotionID") %>' CssClass="btn btn-sm text-primary"><i class="fa fa-edit"></i> Edit</asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("PromotionID") %>' CssClass="btn btn-sm text-danger" OnClientClick="return confirm('Delete?');"><i class="fa fa-trash"></i> Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>