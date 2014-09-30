<%@ Page Title="" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="NewEventPage.aspx.cs" Inherits="ProjectNinja.neweventpage" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Add Event</title>
</asp:Content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Add Event</li>
</asp:content>

<asp:Content ID="TeacherCalendar" ContentPlaceHolderID="teacherCal" runat="server">
    <li><a href="TeacherCalendar.aspx">Full Calendar</a></li>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server" method="post" action="NewEventPage.aspx">
        <div class="row">
          <div class="col-sm-12 col-md-12 main">
              <div class="col-md-3">
                <h2>Add Event</h2>
             </div>
             <div class="col-md-9"  style="margin-top:20px; margin-bottom: 20px;">
                <a href="#" class="btn btn-primary" id="btn-today">Today</a>
                  <div class="btn-group" style="margin-left:15px;">
                      <button type="button" class="btn btn-default" id="back-btn">
                          <span class="glyphicon glyphicon-arrow-left"></span> Prev Week
                      </button>
                      <button type="button" class="btn btn-default" id="forward-btn">
                          Next Week <span class="glyphicon glyphicon-arrow-right"></span>
                      </button>
                 </div>
                 <a href="javascript:getAllSelectedDateTimes();" class="btn btn-success pull-right">Create Event</a>
             </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-3">
             <form role="form" action="SubmitNewEvent.aspx" method="get">        
                <div class="form-group">
                   <label for="eventName">Event Name</label>
                   <input type="text" class="form-control" id="eventName" name="eventName" />
                </div><!-- end form-group -->
            
                <div class="form-group">
                   <label for="eventDate"><span class="glyphicon glyphicon-calendar"></span> Date</label>
                   <div class="input-group">
                      <div id="eventDate"></div>
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
            
                <div class="form-group">
                   <label for="eventTime">Duration</label>
                   <div class="input-group">
                      <div class="input-group-addon">
                         <span class="glyphicon glyphicon-dashboard"></span>
                      </div><!-- end input-group-addon -->
                      <!-- <input type="text" class="form-control" id="eventTime" name="eventTime" /> -->
                      <select class="form-control" id="eventTime" name="eventTime">
                         <option>15</option>
                         <option>30</option>
                         <option selected="selected">60</option>
                      </select>
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
            
                <div class="form-group" id="eventAttendees">
                   <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
                   <div class="input-group">
                       <%
                           System.Data.SqlClient.SqlCommand cmdLoadID = new System.Data.SqlClient.SqlCommand(@"
                                            SELECT c.course_id, c.course_name
                                             FROM [SEI_TimeMachine2].[dbo].[COURSE] c
                                            WHERE c.course_end_date >= SYSDATETIME()",
                            new System.Data.SqlClient.SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));

                           cmdLoadID.Connection.Open();
                           System.Data.SqlClient.SqlDataReader drUser = cmdLoadID.ExecuteReader();

                           while (drUser.Read())
                           {
                               Response.Write("<label><input type=\"checkbox\" value=\"" + drUser["course_id"].ToString() + "\" name=\"eventAttendees[]\">" + drUser["course_name"].ToString() + "</label>");
                           }
                            
                           cmdLoadID.Connection.Close();
                            %>
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
            
                <div class="form-group" id="eventLocation">
                   <label>Location</label>
                   <div class="input-group">
                      <div class="input-group-addon">
                         <span class="glyphicon glyphicon-globe"></span>
                      </div><!-- end input-group-addon -->
                      <input type="text" class="form-control" id="txtEventLocation" name="eventLocation" />
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
             </form>
          </div>
          <div class="col-md-9" id="agendaTableHolder">
          </div><!-- end agendaTableHolder -->
          <!-- end main content -->      
        </div>   
    </form>
</asp:Content>
