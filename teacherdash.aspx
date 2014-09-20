<%@ Page Title="Teacher Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherdash.aspx.cs" Inherits="ProjectNinja.teacherdash" %>
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
               <a href="newevent.aspx" class="btn btn-primary pull-right">New Event</a>
            </div>
         </div>
      </div>
   </div>

   <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="table-responsive">
            <asp:GridView ID="grdEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
               DataSourceID="sqlEvents" ShowHeaderWhenEmpty="True" DataKeyNames="eventID" onrowcommand="grdEventsTable_RowCommand" AllowPaging="True" AllowSorting="True">
               <Columns>
                   <asp:TemplateField HeaderText="Event Name" SortExpression="eventName">
                       <ItemTemplate>
                           <asp:LinkButton ID="lblEditName" runat="server" Text='<%# Bind("eventName") %>' CommandArgument='<%# Bind("eventID") %>' OnClick="editeventpage.aspx"></asp:LinkButton>
                       </ItemTemplate>
                       <HeaderStyle Width="30%" BackColor="#428BCA" CssClass="sorting" />
                   </asp:TemplateField>
                   <asp:BoundField DataField="eventLocation" HeaderText="Event Location" SortExpression="eventLocation">
                      <HeaderStyle BackColor="#428BCA" CssClass="sorting" />
                   </asp:BoundField>
                   <asp:BoundField DataField="beginDate" HeaderText="Begin Date" SortExpression="beginDate" >
                      <HeaderStyle BackColor="#428BCA" CssClass="sorting" />
                   </asp:BoundField>
                   <asp:BoundField DataField="endDate" HeaderText="End Date" SortExpression="endDate" >
                      <HeaderStyle BackColor="#428BCA" CssClass="sorting" />
                   </asp:BoundField>
                   <asp:BoundField DataField="attendees" HeaderText="Attendees" SortExpression="attendees" >
                      <HeaderStyle BackColor="#428BCA" CssClass="sorting" />
                   </asp:BoundField>
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
					         <asp:LinkButton id="btnDelete" runat="server" commandname="DeleteEvent" text="Delete" CssClass="btn btn-default btn-danger" CommandArgument='<%# Eval("eventID") %>'>
                                 <i aria-hidden="true" class="glyphicon glyphicon-trash"></i> Delete
                             </asp:LinkButton>
				       </itemtemplate>
			           <HeaderStyle BackColor="#428BCA" />
			       </asp:TemplateField>
                  
               </Columns>
               <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="White" CssClass="sorting" />
                <SortedAscendingHeaderStyle CssClass="sorting_asc" />
                <SortedDescendingHeaderStyle CssClass="sorting_desc" />
            </asp:GridView>
         </div>
      </div>
   </div>
   <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="
SELECT ev.eventID, eventName, eventLocation, Convert(varchar(11), CAST(MIN(ev_ti.eventDate) AS datetime)) AS beginDate, Convert(varchar(11), CAST(MAX(ev_ti.eventDate) AS datetime)) AS endDate,
       ( SELECT COUNT(DISTINCT scheduledUserID)
           FROM SEI_Ninja.dbo.SCHEDULED_USERS su
          WHERE su.eventTimeID = ev_ti.eventTimeID ) AS attendees
  FROM SEI_Ninja.dbo.[EVENT] ev
       LEFT OUTER JOIN SEI_Ninja.dbo.EVENT_TIMES ev_ti ON (ev.eventID = ev_ti.eventID)
 GROUP BY eventName, eventLocation, eventTimeID, ev.eventID
 ORDER BY eventName;" CancelSelectOnNullParameter="False"  UpdateCommand="
UPDATE SEI_Ninja.dbo.[EVENT]
   SET eventName = @eventName
 WHERE eventID   = @eventID" DeleteCommand="
DELETE FROM event
     WHERE eventID = @eventID">
      <DeleteParameters>
          <asp:ControlParameter ControlID="hdnRowID" DefaultValue="0" Name="eventID" PropertyName="Value" Type="Int32" />
      </DeleteParameters>
      <UpdateParameters>
          <asp:ControlParameter ControlID="hdnName" Name="eventName" PropertyName="Value" />
          <asp:ControlParameter ControlID="hdnID" Name="eventID" PropertyName="Value" />
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
