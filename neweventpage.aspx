﻿<%@ Page Title="" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="NewEventPage.aspx.cs" Inherits="ProjectNinja.neweventpage" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Add Event</title>
</asp:Content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Add Event</li>
</asp:content>

<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server">
        <div class="row">
          <div class="col-sm-12 col-md-12 main">
             <div class="col-md-6">
                <h1>Add Event</h1>
             </div>
             <div class="col-md-6">
                <a href="javascript:getAllSelectedDateTimes();" class="btn btn-primary pull-right" style="margin-top:28px;">Create Event</a>
             </div>
          </div>
        </div>
        <div class="row" style="margin-top: 20px;">
          <div class="col-md-3">
             <form role="form" action="SubmitNewEvent.aspx" method="post">        
                <div class="form-group">
                   <label for="eventName">Event Name</label>
                   <input type="text" class="form-control" id="eventName" name="eventName" />
                </div><!-- end form-group -->
            
                <div class="form-group">
                   <label for="eventDate">Date</label>
                   <div class="input-group">
                      <div class="input-group-addon">
                         <span class="glyphicon glyphicon-calendar"></span>
                      </div><!-- end input-group-addon -->
                      <input type="text" class="form-control" id="eventDate" name="eventDate" onchange="generateAgendaTable();" />
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
            
                <div class="form-group">
                   <label for="eventTime">Time Step</label>
                   <div class="input-group">
                      <div class="input-group-addon">
                         <span class="glyphicon glyphicon-dashboard"></span>
                      </div><!-- end input-group-addon -->
                      <!-- <input type="text" class="form-control" id="eventTime" name="eventTime" /> -->
                      <select class="form-control" id="eventTime" name="eventTime" onchange="generateAgendaTable();">
                         <option>15</option>
                         <option>30</option>
                         <option selected="selected">60</option>
                      </select>
                   </div><!-- end input-group -->
                </div><!-- end form-group -->
            
                <div class="form-group" id="eventAttendees">
                   <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
                   <div class="input-group">
                       <asp:CheckBoxList ID="cblAttendeesList" runat="server" DataSourceID="sqlCourses" DataTextField="course_name" DataValueField="course_id"></asp:CheckBoxList>

                       <asp:SqlDataSource 
                            ID="sqlCourses" 
                            runat="server" 
                            SelectCommand="SELECT c.course_id, c.course_name
                                             FROM [SEI_TimeMachine2].[dbo].[COURSE] c
                                            WHERE c.course_end_date &gt;= SYSDATETIME()" 
                            ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0" 
                            ProviderName="System.Data.SqlClient">
                       </asp:SqlDataSource>
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
