<%@ Page Title=""
    Language="C#"
    MasterPageFile="~/Masters/AdminMaster.Master"
    AutoEventWireup="true"
    CodeFile="EditProject.aspx.cs"
    Inherits="HR_System.EditProject" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="MainContent"
    runat="server">

    <div class="container mt-4">
        <div class="card p-4">

            <h3>Edit Project</h3>

            <!-- Hidden Fields -->
            <asp:HiddenField ID="hfProjectId" runat="server" />
            <asp:HiddenField ID="hfOldLogoPath" runat="server" />
            <asp:HiddenField ID="hfOldFilePath" runat="server" />

            <label>Project Name</label>
            <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" />

            <label>Client Name</label>
            <asp:TextBox ID="txtClientName" runat="server" CssClass="form-control" />

            <label>Description</label>
            <asp:TextBox ID="txtDescription" runat="server"
                TextMode="MultiLine" CssClass="form-control" />

            <label>Start Date</label>
            <asp:TextBox ID="txtStartDate" runat="server"
                TextMode="Date" CssClass="form-control" />

            <label>End Date</label>
            <asp:TextBox ID="txtEndDate" runat="server"
                TextMode="Date" CssClass="form-control" />

            <label>Priority</label>
            <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select">
                <asp:ListItem Value="">Select Priority</asp:ListItem>
                <asp:ListItem>High</asp:ListItem>
                <asp:ListItem>Medium</asp:ListItem>
                <asp:ListItem>Low</asp:ListItem>
            </asp:DropDownList>

            <label>Project Value</label>
            <asp:TextBox ID="txtProjectValue" runat="server" CssClass="form-control" />

            <label>Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                <asp:ListItem Value="">Select Status</asp:ListItem>
                <asp:ListItem>Active</asp:ListItem>
                <asp:ListItem>Inactive</asp:ListItem>
            </asp:DropDownList>

            <!-- TEAM MEMBERS -->
            <label class="mt-2">Team Members</label>
            <div class="dropdown mb-3">
                <button type="button"
                    class="btn btn-outline-secondary dropdown-toggle w-100"
                    id="dropdownMenuButton"
                    data-bs-toggle="dropdown">
                    Select Team Members
                </button>

                <ul class="dropdown-menu w-100 p-2">
                    <asp:Repeater ID="rptUsers" runat="server">
                        <ItemTemplate>
                            <li class="dropdown-item">
                                <input type="checkbox"
                                    class="team-checkbox"
                                    name="Users"
                                    value="<%# Eval("UserId") %>"
                                    <%# (bool)Eval("IsSelected") ? "checked" : "" %> />
                                <label class="ms-2"><%# Eval("FirstName") %></label>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>

            <label>Project Manager</label>
            <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-select" />

            <label class="mt-2">Logo (Optional)</label>
            <asp:FileUpload ID="fuLogo" runat="server" CssClass="form-control" />

            <label class="mt-2">File (Optional)</label>
            <asp:FileUpload ID="fuFile" runat="server" CssClass="form-control" />

            <div class="text-end mt-4">
                <asp:Button ID="btnUpdate" runat="server"
                    Text="Save Changes"
                    CssClass="btn btn-primary"
                    OnClick="btnUpdate_Click" />
            </div>

        </div>
    </div>

    <!-- TEAM MEMBER DROPDOWN TEXT UPDATE -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const btn = document.getElementById('dropdownMenuButton');
            const boxes = document.querySelectorAll('.team-checkbox');

            function updateText() {
                const names = [];
                boxes.forEach(b => {
                    if (b.checked) names.push(b.nextElementSibling.innerText);
                });
                btn.textContent = names.length
                    ? names.join(', ') + ' (Selected)'
                    : 'Select Team Members';
            }

            boxes.forEach(b => b.addEventListener('change', updateText));
            updateText();
        });
    </script>

</asp:Content>
