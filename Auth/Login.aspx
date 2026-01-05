<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="HR_System.Auth.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NexusTrack | Login</title>
</head>
<body>

<form id="form1" runat="server">

    <table style="width:100%; height:100vh;">
        <tr>
            <!-- LEFT SIDE -->
            <td style="width:50%; text-align:center; vertical-align:middle;">
                <h1 style="font-size:42px;">
                    Nexus<br />
                    <span style="color:#ff7a00;">Track</span>
                </h1>
            </td>

            <!-- RIGHT SIDE -->
            <td style="width:50%; text-align:center; vertical-align:middle;">
                <h3>Login</h3>

                <asp:TextBox ID="txtEmail" runat="server"
                    Placeholder="Email"
                    Width="250px" /><br /><br />

                <asp:TextBox ID="txtPassword" runat="server"
                    TextMode="Password"
                    Placeholder="Password"
                    Width="250px" /><br /><br />

                <asp:Button ID="btnLogin" runat="server"
                    Text="Login"
                    Width="120px"
                    OnClick="btnLogin_Click" /><br /><br />

                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
            </td>
        </tr>
    </table>

</form>

</body>
</html>
