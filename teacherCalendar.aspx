<%@ Page Title="" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherCalendar.aspx.cs" Inherits="ProjectNinja.teacherCalendar" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <!-- Leah & Erin's page -->
    <title>Teacher Calendar</title>
</asp:Content>

<asp:Content ID="TeacherCalendar" ContentPlaceHolderID="teacherCal" runat="server">
    <h4>Test</h4>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server">
    
    <asp:HiddenField ID="hdnScheduledAppointments" runat="server" Value="shouldn't be here" />

      <div class="col-sm-12 col-md-12 main">
         <div class="col-md-6">
            <h2 class="form-signin-heading">Filter Events</h2>
         </div>
      </div>

      <div class="col-md-3">   
        <div id="eventDate">
            
        </div><!-- end input-group -->

        <div class="form-group" id="Div1">
            <label>Export your calendar</label>
            <!--span class="addAttendees" onclick="addRow(this);"-->
            <!--/span><!-- end addAttendees -->
            <div class="input-group">
                <asp:LinkButton ID="btnExportCalendar" runat="server" CommandArgument='<%# Eval("hdnScheduledAppointments") %>' CommandName="exportCalendar" OnClick="btnExportCalendar_Click" Text ="Export" >
                      
                </asp:LinkButton>
            </div><!-- end input-group -->
        </div><!-- end form-group -->
      </div>
        <div class="btn-group"><input type="button" class="btn btn-primary" id="back-btn" value="Previous Week" /></div>
        <div class="btn-group"><input type="button" class="btn btn-primary" id="forward-btn" value="Next Week" /></div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->  
    </form>
</asp:Content>
