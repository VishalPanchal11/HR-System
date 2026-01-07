<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/AdminMaster.Master" AutoEventWireup="true" CodeFile="AddTask.aspx.cs" Inherits="HR_System.Admin.Projects.AddTask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<div class="container mt-4">
    <div class="card p-4">

        <h4 class="mb-4">Add New Task</h4>

        <!-- Title -->
        <div class="mb-3">
            <label class="form-label">Title</label>
            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
        </div>

        <!-- Deadline + Project -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Due Date</label>
                <asp:TextBox ID="txtDeadline" runat="server"
                    CssClass="form-control" TextMode="Date" />
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Project</label>
                <asp:DropDownList ID="ddlProject" runat="server" CssClass="form-select" />
            </div>
        </div>

        <!-- Team Members -->
        <div class="mb-3">
            <label class="form-label">Team Members</label>

            <!-- Selected Names -->
            <input type="text" id="txtSelectedMembers"
                   class="form-control mb-2"
                   readonly
                   placeholder="Selected members will appear here" />

            <!-- Hidden field to store selected IDs -->
            <asp:HiddenField ID="hdnSelectedMembers" runat="server" />

            <div class="dropdown w-100">
                <button type="button" id="btnMembersDropdown"
                        class="btn btn-outline-secondary dropdown-toggle w-100 text-start"
                        data-bs-toggle="dropdown"
                        aria-expanded="false">
                    Select Team Members
                </button>

                <ul class="dropdown-menu w-100 p-2" id="membersList" style="max-height: 300px; overflow-y: auto;">
                    <li><span class="dropdown-item text-muted">Select a project first</span></li>
                </ul>
            </div>
        </div>

        <!-- Status + Priority -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Select" Value="" />
                    <asp:ListItem Text="Pending" />
                    <asp:ListItem Text="Inprogress" />
                    <asp:ListItem Text="Completed" />
                    <asp:ListItem Text="Onhold" />
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Priority</label>
                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Select" Value="" />
                    <asp:ListItem Text="High" />
                    <asp:ListItem Text="Medium" />
                    <asp:ListItem Text="Low" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <asp:TextBox ID="txtDescription" runat="server"
                CssClass="form-control" TextMode="MultiLine" Rows="4" />
        </div>

        <!-- File -->
        <div class="mb-3">
            <label class="form-label">Attachment</label>
            <asp:FileUpload ID="fuFile" runat="server" CssClass="form-control" />
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger" />

        <div class="text-end">
            <asp:Button ID="btnSave" runat="server"
                Text="Add Task"
                CssClass="btn btn-primary"
                OnClick="btnSave_Click" />
        </div>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        console.log("Page loaded - jQuery ready");

        // Project dropdown change event
        $('#<%= ddlProject.ClientID %>').on('change', function () {
            console.log("Project changed:", $(this).val());
            loadMembers();
        });

        // Prevent dropdown from closing on click inside
        $('#membersList').on('click', function (e) {
            e.stopPropagation();
        });

        // Handle checkbox changes
        $(document).on('change', '.memberChk', function () {
            updateSelectedMembers();
        });
    });

    function loadMembers() {
        var projectId = $('#<%= ddlProject.ClientID %>').val();
        console.log("loadMembers called with projectId:", projectId);

        if (!projectId || projectId === "") {
            $('#membersList').html('<li><span class="dropdown-item text-muted">Select a project first</span></li>');
            $('#txtSelectedMembers').val('');
            return;
        }

        // Show loading
        $('#membersList').html('<li><span class="dropdown-item text-muted">Loading...</span></li>');

        $.ajax({
            type: "POST",
            url: "AddTask.aspx/GetProjectMembers",
            data: JSON.stringify({ projectId: parseInt(projectId) }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                console.log("AJAX Success:", response);

                let html = "";

                if (!response.d || response.d.length === 0) {
                    html = '<li><span class="dropdown-item text-muted">No members found</span></li>';
                } else {
                    response.d.forEach(function (member) {
                        html += '<li>' +
                            '<label class="dropdown-item mb-0">' +
                            '<input type="checkbox" class="memberChk me-2" ' +
                            'name="MemberIds" ' +
                            'value="' + member.UserId + '" ' +
                            'data-name="' + member.FullName + '" /> ' +
                            member.FullName +
                            '</label>' +
                            '</li>';
                    });
                }

                $("#membersList").html(html);
                console.log("Members loaded successfully");
            },
            error: function (xhr, status, error) {
                console.error("AJAX Error:", status, error);
                console.error("Response:", xhr.responseText);
                $('#membersList').html('<li><span class="dropdown-item text-danger">Error: ' + error + '</span></li>');
            }
        });
    }

    function updateSelectedMembers() {
        let names = [];
        let ids = [];

        $('.memberChk:checked').each(function () {
            names.push($(this).data('name'));
            ids.push($(this).val());
        });

        $('#txtSelectedMembers').val(names.join(', '));
        console.log("Selected members:", names);
    }
</script>

</asp:Content>