<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="./MasterPage.Master" CodeBehind="EditEventPage.aspx.cs" Inherits="ProjectNinja.VersionedCode.EditEventPage1" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Edit Event</title>
</asp:Content>
<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Edit Event</li>
</asp:content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <%
        if (!IsPostBack)
        {
            using (System.Data.SqlClient.SqlConnection thisConnection = new System.Data.SqlClient.SqlConnection("Server=172.16.212.212;Database=SEI_Ninja;User ID=sei_timemachine;Password=z5t9l3x0;"))
            {
                thisConnection.Open();

                using (System.Data.SqlClient.SqlCommand thisCommand = thisConnection.CreateCommand())
                {
                    // Insert an event into the event table
                    thisCommand.CommandText = @"
                    SELECT e.eventLocation, e.eventName, e.eventStep 
                      FROM [SEI_Ninja].[dbo].EVENT e
                     WHERE e.eventID = " + Request.QueryString["eventID"] + ";";
                    System.Data.SqlClient.SqlDataReader drUser = thisCommand.ExecuteReader();
                    if (drUser.Read())
                    {
                        eventName.Value = Convert.ToString(drUser["eventName"]);
                        eventLocation.Value = Convert.ToString(drUser["eventLocation"]);
                        //ddleventTime.Items.FindByText(Convert.ToString(drUser["eventStep"])).Selected = true;
                    }
                }
                thisConnection.Close();
            }
        }
    %>
    <form runat="server" method="post" action="NewEventPage.aspx">
        <div class="row">
          <div class="col-sm-12 col-md-12 main">
             <div class="col-md-6">
                <h1>Edit Event</h1>
             </div>
             <div class="col-md-6">
                <a href="javascript:getAllSelectedDateTimes();" class="btn btn-primary pull-right" style="margin-top:28px;">Edit Event</a>
             </div>
          </div>
        </div>
        <div class="row" style="margin-top: 20px;">
          <div class="col-md-3">
             <form role="form" action="SubmitNewEvent.aspx" method="get">        
                <div class="form-group">
                   <label for="eventName">Event Name</label>
                   <input type="text" class="form-control" id="eventName" name="eventName" runat="server" />
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
                           System.Collections.ArrayList checkedEvents = new System.Collections.ArrayList();
                           
                           // Get the boxes that should be checked
                           
                           System.Data.SqlClient.SqlCommand cmdLoadID = new System.Data.SqlClient.SqlCommand(@"
                                            SELECT c.course_name
                            FROM [SEI_Ninja].[dbo].EVENT_COURSES ec
                                 JOIN [SEI_TimeMachine2].[dbo].COURSE c ON (ec.courseID = c.course_id)
                           WHERE ec.eventID = " + Request.QueryString["eventID"] + ";",
                            new System.Data.SqlClient.SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
                           cmdLoadID.Connection.Open();
                            System.Data.SqlClient.SqlDataReader drUser = cmdLoadID.ExecuteReader();
                            while (drUser.Read())
                           {
                               checkedEvents.Add(drUser["course_name"]);
                           }
                            cmdLoadID.Connection.Close();
                           
                           // Print the checkbox
                           cmdLoadID = new System.Data.SqlClient.SqlCommand(@"
                                            SELECT c.course_id, c.course_name
                                             FROM [SEI_TimeMachine2].[dbo].[COURSE] c
                                            WHERE c.course_end_date >= SYSDATETIME()",
                            new System.Data.SqlClient.SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));

                           cmdLoadID.Connection.Open();
                           drUser = cmdLoadID.ExecuteReader();

                           while (drUser.Read())
                           {
                               if (checkedEvents.Contains(drUser["course_name"].ToString()))
                               {
                                   Response.Write("<label><input type=\"checkbox\" checked value=\"" + drUser["course_id"].ToString() + "\" name=\"eventAttendees[]\">" + drUser["course_name"].ToString() + "</label>");
                               }
                               else
                               {
                                   Response.Write("<label><input type=\"checkbox\" value=\"" + drUser["course_id"].ToString() + "\" name=\"eventAttendees[]\">" + drUser["course_name"].ToString() + "</label>");
                               }
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
                      <input type="text" class="form-control" id="eventLocation" name="eventLocation" runat="server" />
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
