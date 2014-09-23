<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="StudentDash.aspx.cs" Inherits="ProjectNinja.studentDash" %>
<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Student Dash</title>
    <!-- Glenn and Dory's Page -->
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <asp:HiddenField ID="hdnStudentID" runat="server" />
    <br />
    <br />
    <asp:Label ID="lbltest" runat="server"  />
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
								  WHERE member.member_user_id = @p_StudentID)
    AND e.eventID NOT IN ( SELECT e.eventID
							 FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
							      JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
								  JOIN [SEI_Ninja].[dbo].[EVENT] e ON (et.eventID = e.eventID)
						    WHERE su.userID = @p_StudentID )																	
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
					         <asp:LinkButton id="btnEdit" runat="server" commandname="editEvent" CssClass="btn btn-default" CommandArgument='<%# Eval("eventID") %>'>
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
 WHERE su.userID = @p_StudentID " CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnStudentID" Name="p_StudentID" PropertyName="Value" />
        </SelectParameters>
   </asp:SqlDataSource>
</asp:Content>
