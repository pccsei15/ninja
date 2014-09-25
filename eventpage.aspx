<%@ Page Title="Sign up" Language="C#" MasterPageFile="MasterPage.Master" AutoEventWireup="true" CodeBehind="EventPage.aspx.cs" Inherits="ProjectNinja.eventpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Event Sign Up</title>
</asp:content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Event Sign Up</li>
</asp:content>

<asp:Content ID="Content" ContentPlaceHolderID="mainContent" runat="server">
    <asp:HiddenField ID="hdnScheduledAppointments" runat="server" Value="shouldn't be here" />

    <div class="row">
        <%-- Drop down to change the event to sign up for --%> 
        <div class="col-md-6"> 
            <asp:DropDownList 
                ID="eventSelectList" 
                runat="server" 
                DataSourceID="selectedDataSource" 
                DataTextField="eventName" 
                DataValueField="eventID" 
                CssClass="form-control input-lg event-drop" 
                AutoPostBack="True" 
                OnSelectedIndexChanged="eventSelectList_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:SqlDataSource 
                ID="selectedDataSource" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" 
                SelectCommand="
                   SELECT [eventID], [eventName] 
                     FROM [EVENT] " 
                CancelSelectOnNullParameter="False">
                
            </asp:SqlDataSource>
        </div><!-- end drop-down-->
    </div>
      
    <div class="row">
      <div class="col-md-3">
         <form role="form" action="WebForm1.aspx" method="post">   
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
               <div class="input-group">
                   <!--pull value from db -->
                   <input type="hidden" value="30" class="form-control" id="eventTime" name="eventTime" />
               </div><!-- end input-group -->
            </div><!-- end form-group -->
         </form>
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->
    </div>
</asp:content>

<asp:Content ID="Content3" ContentPlaceHolderID="ExtraJs" runat="server">
    <script type="text/javascript" src="js/jquery.timepicker.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" charset="utf8" src="js/calendar.js"></script>
</asp:content>



        