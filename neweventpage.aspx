<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="NewEventPage.aspx.cs" Inherits="ProjectNinja.neweventpage" %>
<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Add Event</title>
</asp:Content>
<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Add Event</li>
</asp:content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="col-md-6">
            <h1>Add Event</h1>
         </div>
         <div class="col-md-6">
            <a href="javascript:getAllSelectedDateTimes();" class="btn btn-primary pull-right">Create Event</a>
         </div>
      </div>
    </div>
    <div class="row">
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
                  <input type="text" class="form-control" id="eventDate" name="eventDate" onchange="generateAgendaTable();" />
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group">
               <label for="eventTime">Time Step (Minutes)</label>
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
            
            <div class="form-group" id="eventLocation">
               <label>Location</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-globe"></span>
                  </div><!-- end input-group-addon -->
                  <select class="form-control" name="eventLocation">
                     <option value="" selected></option>
                     <option value="AC">AC</option>
                     <option value="MK">MK</option>
                  </select>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
         </form>
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->
      <!-- end main content -->      
    </div>

   
</asp:Content>
