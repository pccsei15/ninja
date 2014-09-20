﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherCalendar.aspx.cs" Inherits="ProjectNinja.teacherCalendar" %>
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
        <div class="col-md-9">
          <table class="table table-bordered table-responsive" style="background:#fff;" id="agenda-table">
            <thead>
              <tr>
                <th style="width:15%"></th>
                <th style="width:17%">Monday</th>
                <th style="width:17%">Tuesday</th>
                <th style="width:17%">Wednesday</th>
                <th style="width:17%">Thursday</th>
                <th style="width:17%">Friday</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td rowspan="2">8am</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">9am</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">10am</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">11am</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">12pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">1pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">2pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">3pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">4pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td rowspan="2">5pm</td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
              <tr>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
                <td class="agenda-slot"></td>
              </tr>
            </tbody>
          </table>
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
    <script>
        // Start the time and date picker
        $(function () {
            $('#eventDate').datepicker({
                todayHighlight: true,
                todayBtn: "linked"
            });
        });
     </script>
</asp:Content>
