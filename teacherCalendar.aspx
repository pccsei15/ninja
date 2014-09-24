﻿<%@ Page Title="" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherCalendar.aspx.cs" Inherits="ProjectNinja.teacherCalendar" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <!-- Leah & Erin's page -->
    <title>Teacher Calendar</title>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">

    <asp:HiddenField ID="hdnScheduledAppointments" runat="server" Value="shouldn't be here" />

      <div class="col-sm-12 col-md-12 main">
         <div class="col-md-6">
            <h2 class="form-signin-heading">Filter Events</h2>
         </div>
      </div>

      <div class="col-md-3">
         <form role="form" action="WebForm1.aspx" method="post">        
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
                  <input type="text" class="form-control" id="eventDate" name="eventDate" onchange="generateAgendaTable('false');" />
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
                     
            <div class="form-group" id="eventAttendees">
               <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
               <span class="addAttendees" onclick="addRow(this);">
                  <span class="glyphicon glyphicon-plus-sign addIcon"></span> (Add Class)
               </span><!-- end addAttendees -->
               <div class="input-group">
                  <select class="form-control" onchange="disableSelectedAttendees();" name="eventAttendees[]">
                     <option value="" selected></option>
                     <option value="Class1">Class1</option>
                     <option value="Class2">Class2</option>
                     <option value="Class3">Class3</option>
                     <option value="Class4">Class4</option>
                     <option value="Class5">Class5</option>
                  </select>
                  <div class="input-group-addon" onclick="removeRow(this);">
                     <span class="glyphicon glyphicon-minus-sign removeIcon"></span>
                  </div><!-- end input-group-addon -->
               </div><!-- end input-group -->
            </div><!-- end form-group -->
                        
         </form>
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->  
</asp:Content>

<asp:Content ID="ExtraJS" ContentPlaceHolderID="extraJs" runat="server">
    <script type="text/javascript" charset="utf8" src="js/calendar.js"></script>
</asp:Content>
