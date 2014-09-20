<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="studentDash.aspx.cs" Inherits="ProjectNinja.studentDash" %>
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
   <asp:HiddenField ID="hdnStudentID" runat="server" />
   <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
         <div class="navbar-header">
            <a class="navbar-brand" href="teacherdash.aspx">Project Ninja</a>
         </div>
      </div>
   </div>
    <br />
    <br />
    <asp:Label ID="lblEventsAvail" runat="server" Text="Events Available for Sign Up" Font-Size="X-Large"></asp:Label>
       <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="table-responsive">
            <asp:GridView ID="grdEventsAvailable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
               DataSourceID="sqlAvailEvents" DataKeyNames="eventID" onrowcommand="grdStudentEventsTable_RowCommand" OnPreRender="grdEventsAvailable_PreRender1">
               <Columns>
                   <asp:BoundField DataField="eventName" HeaderText="Event Name" SortExpression="eventName">
                   </asp:BoundField>
                   <asp:BoundField DataField="eventLocation" HeaderText="Event Location" SortExpression="eventLocation">
                   </asp:BoundField>
                   <asp:BoundField DataField="beginDate" HeaderText="Begin Date" SortExpression="beginDate" DataFormatString="{0:f}" >
                   </asp:BoundField>
                   <asp:BoundField DataField="endDate" HeaderText="End Date" SortExpression="endDate" DataFormatString="{0:f}" >
                   </asp:BoundField>
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
					         <asp:LinkButton id="btnSignUp" runat="server" commandname="signUpEvent" CssClass="btn btn-default" CommandArgument='<%# Eval("eventID") %>'>
                                 <i aria-hidden="true" class="glyphicon glyphicon-ok-sign"></i> Sign Up
                             </asp:LinkButton>
				       </itemtemplate>
                       
			       </asp:TemplateField>
                  
               </Columns>
               <RowStyle CssClass="rowStyle" />
               <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="White" CssClass="headerStyle" />
               <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
         </div>
      </div>
   </div>
    <asp:SqlDataSource ID="sqlAvailEvents" runat="server" SelectCommand="
SELECT DISTINCT ec.eventID, e.eventLocation, e.eventName, MIN(et.eventDate) AS beginDate, MAX(et.eventDate) AS endDate
   FROM [SEI_Ninja].[dbo].[EVENT_COURSES] [ec]
		JOIN [SEI_Ninja].[dbo].[EVENT] [e] ON (ec.eventID = e.eventID)
		LEFT OUTER JOIN [SEI_Ninja].[dbo].[EVENT_TIMES] [et] ON (e.eventID = et.eventID)
  WHERE ec.courseID IN (SELECT DISTINCT course.course_id
								   FROM [SEI_TimeMachine2].[dbo].COURSE [course]
								        JOIN [SEI_TimeMachine2].[dbo].MEMBER [member] ON (course.course_id = member.member_course_id)
								  WHERE member.member_user_id = '120420')
    AND e.eventID NOT IN ( SELECT e.eventID
							 FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
							      JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
								  JOIN [SEI_Ninja].[dbo].[EVENT] e ON (et.eventID = e.eventID)
						    WHERE su.userID = '120420' )																	
  GROUP BY ec.eventID, eventLocation, eventName
 HAVING MAX(et.eventDate) >= SYSDATETIME();" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" ProviderName="<%$ ConnectionStrings:SEI_NinjaConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnStudentID" Name="p_StudentID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Label ID="lblStudentEvents" runat="server" Text="Events Signed Up For" Font-Size="X-Large"></asp:Label>
   <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="table-responsive">
            <asp:GridView ID="grdStudentEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
               DataSourceID="sqlEvents" DataKeyNames="eventID" onrowcommand="grdStudentEventsTable_RowCommand" OnPreRender="grdStudentEventsTable_PreRender1">
               <Columns>
                   <asp:BoundField DataField="eventName" HeaderText="Event Name" SortExpression="eventName">
                   </asp:BoundField>
                   <asp:BoundField DataField="eventLocation" HeaderText="Event Location" SortExpression="eventLocation">
                   </asp:BoundField>
                   <asp:BoundField DataField="eventDate" HeaderText="Begin Date" SortExpression="eventDate" DataFormatString="{0:f}" >
                   </asp:BoundField>
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
					         <asp:LinkButton id="btnDelete" runat="server" commandname="editEvent" CssClass="btn btn-default" CommandArgument='<%# Eval("eventID") %>'>
                                 <i aria-hidden="true" class="glyphicon glyphicon-pencil"></i> Edit
                             </asp:LinkButton>
				       </itemtemplate>
                       
			       </asp:TemplateField>
                  
               </Columns>
               <RowStyle CssClass="rowStyle" />
               <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="White" CssClass="headerStyle" />
               <FooterStyle CssClass="footerStyle" />
            </asp:GridView>
         </div>
      </div>
   </div>
   <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="
SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate
  FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
       JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
       JOIN [SEI_Ninja].[dbo].[EVENT] e ON (et.eventID = e.eventID)
 WHERE su.userID = '120420' " CancelSelectOnNullParameter="False">

   </asp:SqlDataSource>

    <!-- jQuery -->
   <script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
   <script type="text/javascript" charset="etf8" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

   <!-- DataTables -->
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/1.10.1/js/jquery.dataTables.min.js"></script>
   <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/bootstrap/3/dataTables.bootstrap.js"></script>
   <script type="text/javascript" charset="utf8" src="js/GridviewFix.js"></script>
   <script type="text/javascript" charset="utf8" src="js/app.js"></script>
</asp:Content>
