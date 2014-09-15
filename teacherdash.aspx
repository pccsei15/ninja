<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherdash.aspx.cs" Inherits="ProjectNinja.teacherdash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mr. Geary's Dashboard</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- App CSS -->
    <link href="css/app.css" rel="stylesheet">

    <!-- Datatables CSS -->
   <link rel="stylesheet" href="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdnRowID" runat="server" />
   <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
         <div class="navbar-header">
            <a class="navbar-brand" href="teacherdash.aspx">Project Ninja</a>
         </div>
      </div>
   </div>

   <div class="container-fluid">
      <div class="row">
         <div class="col-sm-12 col-md-12 main">
            <h1 class="page-header col-md-6 col-xs-6" style="margin-bottom:0px;">My Events</h1>
            <div class="col-md-6 col-xs-6">
               <a href="newevent.html" class="btn btn-primary pull-right">New Event</a>
            </div>
         </div>
      </div>
   </div>

   <asp:Label ID="lblTest" runat="server" Text=""></asp:Label>

   <table style="float:right;">
      <tr>
         <td><asp:Button ID="btnSrcEvents" runat="server" Text="Search:" /></td>
         <td><asp:TextBox ID="txtSrcEvent" runat="server"></asp:TextBox></td>
      </tr>
   </table>
   <br />
   <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="table-responsive">
            <asp:GridView ID="grdEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" AutoGenerateColumns="False" 
               DataSourceID="ProjectNinjaDB" ShowHeaderWhenEmpty="True" DataKeyNames="eventID" onrowcommand="grdEventsTable_RowCommand" AutoGenerateEditButton="True" 
               Width="90%" AllowPaging="True" AllowSorting="True">
               <Columns>
                   <asp:BoundField DataField="eventID" HeaderText="Event ID" InsertVisible="False" ReadOnly="True" SortExpression="eventID" />
                   <asp:BoundField DataField="eventName" HeaderText="Event Name" SortExpression="eventName" />
                  <asp:BoundField HeaderText="Event Location" SortExpression="eventLocation" DataField="eventLocation">
                  </asp:BoundField>
                   <asp:BoundField DataField="eventOwner" HeaderText="Event Owner" SortExpression="eventOwner" />
 
                   <asp:ButtonField HeaderText="&amp;#x2a;" Text="Button">
                   <ControlStyle CssClass="btn btn-default btn-danger" />
                   </asp:ButtonField>
 
               </Columns>
               <HeaderStyle HorizontalAlign="Center" />
            </asp:GridView>
             <asp:SqlDataSource ID="ProjectNinjaDB" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventLocation], [eventOwner], [eventName], [eventID] FROM [EVENT]"></asp:SqlDataSource>
         </div>
      </div>
   </div>
   <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="data source=XE;user id=Glenn;password=Hatt;" ProviderName="System.Data.OracleClient" SelectCommand="
SELECT event_id, name, begin_date, end_date, attendees
  FROM event
 WHERE :p_EventName IS NULL OR UPPER(name) LIKE UPPER(:p_EventName)||'%'" CancelSelectOnNullParameter="False"  UpdateCommand="
UPDATE event
   SET name       = :name,
       begin_date = :begin_date,
       end_date   = :end_date,
       attendees  = :attendees
 WHERE event_id   = :event_id" DeleteCommand="
DELETE FROM event
     WHERE event_id = :event_id">
      <DeleteParameters>
         <asp:ControlParameter ControlID="hdnRowID" Name="event_id" PropertyName="Value" />
      </DeleteParameters>
      <SelectParameters>
         <asp:ControlParameter ControlID="txtSrcEvent" Name="p_EventName" PropertyName="Text" />
      </SelectParameters>
      <UpdateParameters>
         <asp:Parameter Name="name" />
         <asp:Parameter Name="begin_date" />
         <asp:Parameter Name="end_date" />
         <asp:Parameter Name="attendees" />
         <asp:Parameter Name="event_id" />
      </UpdateParameters>
   </asp:SqlDataSource>

    <!-- jQuery -->
   <script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" charset="etf8" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

   <!-- DataTables -->
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/1.10.1/js/jquery.dataTables.min.js"></script>
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.js"></script>
   <script src="js/app.js"></script>
</asp:Content>
