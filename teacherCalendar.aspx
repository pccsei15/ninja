<%@ Page Title="" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherCalendar.aspx.cs" Inherits="ProjectNinja.teacherCalendar" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <!-- Leah & Erin's page -->
    <title>Teacher Calendar</title>
</asp:Content>

<asp:Content ID="TeacherCalendar" ContentPlaceHolderID="teacherCal" runat="server">
    <li><a href="TeacherCalendar.aspx">Full Calendar</a></li>
</asp:Content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Teacher Calendar</li>
</asp:content>

<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
    <form runat="server">
    
    <asp:HiddenField ID="hdnScheduledAppointments" runat="server" Value="shouldn't be here" />

      <div class="col-sm-12 col-md-12 main">
          <div class="row">
              <div class="col-md-3">
                 <h2 class="form-signin-heading">Filter Events</h2>
              </div>
              <div class="col-md-9" style="margin-top: 20px; margin-bottom: 20px;">
                  <a href="#" class="btn btn-primary" id="btn-today">Today</a>
                  <div class="btn-group" style="margin-left:15px;">
                      <button type="button" class="btn btn-default" id="back-btn">
                          <span class="glyphicon glyphicon-arrow-left"></span> Prev Week
                      </button>
                      <button type="button" class="btn btn-default" id="forward-btn">
                          Next Week <span class="glyphicon glyphicon-arrow-right"></span>
                      </button>
                  </div>
              </div>
          </div>
          <div class="row">
              <div class="col-md-3">   
                <div id="eventDate">
            
                </div><!-- end input-group -->

                <div class="form-group" id="exportCalendarOptions">
                    <label>Export your calendar</label>
                    <div class="input-group">
                        <label>Event:</label>&nbsp;
                        <asp:DropDownList runat="server" ID="ddlEventList" ClientIDMode="Static">
                            <asp:ListItem Text="All Events" Value="all"></asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        <button type="button" class="btn btn-default" id="btnExportCalendar"><span>Export Calendar</span></button>
                    </div><!-- end input-group -->
                </div><!-- end form-group -->
              </div>
              <div class="col-md-9" id="agendaTableHolder">
              </div><!-- end agendaTableHolder --> 
          </div>
          
      </div>
    </form>
</asp:Content>
