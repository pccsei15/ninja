<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" MasterPageFile="Default.Master" Inherits="ProjectNinja.VersionedCode.Default" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Defualt</title>
    <!-- Glenn and Dory's Page -->
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <!-- Error page contents. -->
    <form id="Form1" runat="server">
        <div class="row text-center" style="margin: 267px auto;">
           <h1>We're Sorry</h1>
           <p style="font-size: 20px">You do not have access to Project Ninja. If you should have access please see your administrator.</p>
        </div>
    </form>
</asp:Content>