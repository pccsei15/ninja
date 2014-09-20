﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="eventpage.aspx.cs" Inherits="ProjectNinja.eventpage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mr. Geary's Dashboard</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.css" />

    <!-- App CSS -->
    <link href="css/app.css" rel="stylesheet" />

    <!-- Datatables CSS -->
   <link rel="stylesheet" href="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="teacherdash.html">Project Ninja</a>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <ol class="breadcrumb" style="margin-bottom: 0;">
          <li><a href="teacherdash.html">Dashboard</a></li>
          <li class="active">First Interviews</li>
        </ol>
      </div>

      <div class="row">
        <div class="col-sm-6 col-md-6 main">
          <h1>First Interviews</h1>
        </div>
        
      </div>
        
      <div class="row">
        <div class="col-md-3"  > 
          <div class=" datepicker datepicker-inline" id="eventDate"></div>

        </div> <!-- end datapicker -->

        <div class="col-md-3"> 
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="eventName" DataValueField="eventName"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventName] FROM [EVENT]"></asp:SqlDataSource>
        </div>

        <div class="col-md-9">
            
            <asp:Table ID="Table1" runat="server" CssClass="table table-bordered table-responsive">
            
            </asp:Table>
        </div>
      </div>

      <div class="row">
        
      </div>
    </div>

    <!-- jQuery -->
   <script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" charset="utf8" src="http://code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
   <script type="text/javascript" charset="etf8" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
   <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>

   <!-- DataTables -->
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/1.10.1/js/jquery.dataTables.min.js"></script>
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.js"></script>
    <script src="js/app.js"></script>

</asp:Content>
