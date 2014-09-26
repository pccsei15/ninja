<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.Master" CodeBehind="EditEventPage.aspx.cs" Inherits="ProjectNinja.VersionedCode.EditEventPage1" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Edit Event</title>
</asp:Content>
<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Edit Event</li>
</asp:content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">  
     <asp:HiddenField ID="hdnScheduledAppointments" runat="server" Value="shouldn't be here" />
        <div class="row">
      <div class="col-sm-12 col-md-12 main">

         <div class="col-md-6">
            <h1>Edit Event</h1>
         </div>
         <div class="col-md-6">
            <a href="TeacherCalender.aspx" class="btn btn-primary pull-right">Save Event</a>
         </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-3">
        
            <div class="form-group">
               <label for="eventName">Event Name</label>
             <!--  <input type="text" class="form-control" id="eventName" name="eventName" /> -->
                <asp:TextBox ID="eventName" runat="server"></asp:TextBox>
            </div><!-- end form-group -->
            
            <div class="form-group">
               <label for="eventDate">Date</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-calendar"></span>
                  </div><!-- end input-group-addon -->
                 <!-- <input type="text" class="form-control" id="eventDate" name="eventDate" onchange="generateAgendaTable();" />-->
                   <asp:TextBox ID="eventDate" runat="server"></asp:TextBox>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group">
               <label for="eventTime">Time Step</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-dashboard"></span>
                  </div><!-- end input-group-addon -->
                  <!-- <input type="text" class="form-control" id="eventTime" name="eventTime" /> -->
                 <!-- <select class="form-control" id="eventTime" name="eventTime" onchange="generateAgendaTable();">
                      
                     <option>15</option>
                     <option>30</option>
                     <option selected="selected">60</option>
                  </select> -->
                   <asp:DropDownList ID="eventTime" runat="server">  


                   </asp:DropDownList>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group" id="eventAttendees">
               <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
               <span class="addAttendees" onclick="addRow(this);">
                  <span class="glyphicon glyphicon-plus-sign addIcon"></span> (Add Class)
               </span><!-- end addAttendees -->
               <div class="input-group">
            <!--      <select class="form-control" onchange="disableSelectedAttendees();" name="eventAttendees[]">
                     <option value="" selected></option>
                     <option value="1">1</option>
                     <option value="2">2</option>
                     <option value="3">3</option>
                     <option value="4">4</option>
                     <option value="5">5</option>
                  </select>-->
                   <asp:DropDownList ID="evenAttendees" runat="server">

                   </asp:DropDownList>
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
                 <!-- <select class="form-control" name="eventLocation">
                     <option value="" selected></option>
                     <option value="AC">AC</option>
                     <option value="MK">MK</option>
                  </select>-->
                   <asp:DropDownList ID="eventLocationList" runat="server">

                   </asp:DropDownList>
               </div><!-- end input-group -->
                <asp:Button OnClick="submit" Text="Submit" runat="server" />
            </div><!-- end form-group -->
     
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->
      
      <!-- end main content -->      
    </div>   
</asp:Content>
