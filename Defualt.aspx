<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.Master" CodeBehind="Defualt.aspx.cs" Inherits="ProjectNinja.VersionedCode.Defualt" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Defualt</title>
    <!-- Glenn and Dory's Page -->
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server">
        <table>
            <tr>
                <th><asp:Label ID="lblUserName" runat="server" Text="Please Enter Your Username: " AssociatedControlID="txtUserName"></asp:Label></th>
                <td><asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="btnUser" runat="server" Text="Submit" OnClick="btnUser_Click" /></td>
            </tr>
        </table>
    </form>
</asp:Content>
