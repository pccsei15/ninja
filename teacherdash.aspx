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
            <asp:GridView ID="grdEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
               DataSourceID="sqlEvents" ShowHeaderWhenEmpty="True" DataKeyNames="eventID" onrowcommand="grdEventsTable_RowCommand" AllowPaging="True" AllowSorting="True">
               <Columns>
                   <asp:TemplateField HeaderText="Event Name" SortExpression="eventName">
                       <EditItemTemplate>
                           <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("eventName") %>'></asp:TextBox>
                       </EditItemTemplate>
                       <ItemTemplate>
                           <asp:Label ID="lblEditName" runat="server" Text='<%# Bind("eventName") %>'></asp:Label>
                       </ItemTemplate>
                       <HeaderStyle Width="30%" BackColor="#428BCA" />
                   </asp:TemplateField>
                   <asp:TemplateField HeaderText="Event Location" SortExpression="eventLocation">
                       <EditItemTemplate>
                           <asp:TextBox ID="txtEditLoc" runat="server" Text='<%# Bind("eventLocation") %>'></asp:TextBox>
                       </EditItemTemplate>
                       <ItemTemplate>
                           <asp:Label ID="lblEditLoc" runat="server" Text='<%# Bind("eventLocation") %>'></asp:Label>
                       </ItemTemplate>
                       <HeaderStyle Width="20%" BackColor="#428BCA" />
                   </asp:TemplateField>
                   <asp:BoundField DataField="beginDate" HeaderText="Begin Date" SortExpression="beginDate" />
                   <asp:BoundField DataField="endDate" HeaderText="End Date" SortExpression="endDate" />
                   <asp:BoundField DataField="attendees" HeaderText="Attendees" SortExpression="attendees" />
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
                          <div class="btn-group btn-group-sm">
					         <asp:button id="btnEdit" runat="server" commandname="EditEvent" text="Edit" CssClass="btn btn-default" />
					         <asp:button id="btnDelete" runat="server" commandname="DeleteEvent" text="Delete" CssClass="btn btn-default btn-danger" />
                          </div>
				       </itemtemplate>
				       <edititemtemplate>
                         <div class="btn-group btn-group-sm">
					        <asp:button id="btnUpdate" runat="server" commandname="AcceptEdit" text="Update" CssClass="btn btn-default" />
					        <asp:button id="btnCancel" runat="server" commandname="CancelEdit" text="Cancel" CssClass="btn btn-default btn-danger" />
                         </div>
				       </edititemtemplate>
			           <HeaderStyle BackColor="#428BCA" />
			       </asp:TemplateField>
                  
               </Columns>
               <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" />
            </asp:GridView>
         </div>
      </div>
   </div>
   <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="
SELECT ev.eventId, eventName, eventLocation, MIN(ev_ti.eventDate) AS beginDate, MAX(ev_ti.eventDate) AS endDate,
       ( SELECT COUNT(DISTINCT scheduledUserID)
           FROM SEI_Ninja.dbo.SCHEDULED_USERS su
          WHERE su.eventTimeID = ev_ti.eventTimeID ) AS attendees
  FROM SEI_Ninja.dbo.[EVENT] ev
       LEFT OUTER JOIN SEI_Ninja.dbo.EVENT_TIMES ev_ti ON (ev.eventID = ev_ti.eventID)
 GROUP BY ev.eventID, eventName, eventLocation, eventTimeID
 ORDER BY eventName;" CancelSelectOnNullParameter="False"  UpdateCommand="
UPDATE SEI_Ninja.dbo.[EVENT]
   SET eventName = @eventName
 WHERE eventID = 2" DeleteCommand="
DELETE FROM event
     WHERE event_id = @event_id">
      <DeleteParameters>
         <asp:ControlParameter ControlID="hdnRowID" Name="event_id" PropertyName="Value" />
      </DeleteParameters>
      <UpdateParameters>
         <asp:Parameter Name="eventName" />
         <asp:Parameter Name="eventID" />
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
