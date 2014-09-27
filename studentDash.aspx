<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="StudentDash.aspx.cs" Inherits="ProjectNinja.studentDash" %>
<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Student Dash</title>
    <!-- Glenn and Dory's Page -->
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server">
   <asp:HiddenField ID="hdnStudentID" runat="server" />

    <div class="row" style="margin-top: 15px;">
                <div class="col-md-12">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                      <li class="active"><a href="#available" role="tab" data-toggle="tab">Available</a></li>
                      <li><a href="#scheduled" role="tab" data-toggle="tab">Scheduled</a></li>
                    </ul>
                </div>
            </div>

            <!-- Tab panes -->
            <div class="tab-content">
              <div class="tab-pane active" id="available">
                <div class="row">
                    <div class="col-md-6">
                        <h1>Events Available</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="grdEventsAvailable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
                                DataSourceID="sqlAvailEvents" DataKeyNames="eventID" onrowcommand="grdStudentEventsTable_RowCommand" OnPreRender="grdEventsAvailable_PreRender1">
                                <Columns>
                                    <asp:BoundField DataField="eventName" HeaderText="Event" SortExpression="eventName">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="eventLocation" HeaderText="Location" SortExpression="eventLocation">
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Times">
                                        <EditItemTemplate>
                                            
                                        </EditItemTemplate>
                                        <itemtemplate>
                                            <asp:HiddenField ID="hdnEventTimes" Value='<%# Bind("eventID") %>' runat="server" />
                                            <asp:DropDownList ID="ddlEventTimes" runat="server" DataSourceID="sqlEventTimes" DataValueField="eventTimeID" DataTextField="eventDate"></asp:DropDownList>
                                            <asp:SqlDataSource ID="sqlEventTimes" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0" ProviderName="System.Data.SqlClient" SelectCommand="
SELECT et.eventDate, et.eventTimeID
  FROM [SEI_Ninja].[dbo].EVENT_TIMES et
 WHERE et.eventID = @eventID
   AND et.eventTimeID NOT IN (SELECT su.eventTimeID
							    FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su);">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hdnEventTimes" Name="eventID" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </itemtemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Action">
				                        <itemtemplate>
					                            <asp:LinkButton id="btnSignUp" runat="server" commandname="signUpEvent" CssClass="btn btn-success" CommandArgument='<%# Eval("eventID") %>'>
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
              </div>
<div class="tab-pane" id="scheduled">
                  <div class="row">
                     <div class="col-md-6">
                        <h1>Events Scheduled</h1>
                     </div>
                  </div>
                  <div class="row">
                      <div class="col-sm-12 col-md-12 main">
                         <div class="table-responsive">
                            <asp:GridView ID="grdStudentEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
                               DataSourceID="sqlEvents" DataKeyNames="eventID" onrowcommand="grdStudentEventsTable_RowCommand" OnPreRender="grdStudentEventsTable_PreRender1">
                               <Columns>
                                   <asp:BoundField DataField="eventName" HeaderText="Event" SortExpression="eventName">
                                   </asp:BoundField>
                                   <asp:BoundField DataField="eventLocation" HeaderText="Location" SortExpression="eventLocation">
                                   </asp:BoundField>
                                   <asp:BoundField DataField="eventDate" HeaderText="Scheduled Time" SortExpression="eventDate" DataFormatString="{0:f}" >
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
              </div>
            </div>

       <!-- Events available for signup grdView and server select statement -->
       <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0" ProviderName="System.Data.SqlClient" SelectCommand="
    SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate
      FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
           JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
           JOIN [SEI_Ninja].[dbo].[EVENT] e ON (et.eventID = e.eventID)
     WHERE su.userID = @p_StudentID " CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnStudentID" Name="p_StudentID" PropertyName="Value" />
            </SelectParameters>
       </asp:SqlDataSource>

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
     HAVING MAX(et.eventDate) &gt;= SYSDATETIME();" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0" ProviderName="<%$ ConnectionStrings:SEI_NinjaConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnStudentID" Name="p_StudentID" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
   </form>
</asp:Content>
