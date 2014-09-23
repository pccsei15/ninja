<%@ Page Title="Sign up" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="eventpage.aspx.cs" Inherits="ProjectNinja.eventpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Event Sign Up</title>
</asp:content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Event Sign Up</li>
</asp:content>

<asp:Content ID="Content" ContentPlaceHolderID="mainContent" runat="server">

    <div class="row">
        <div class="col-md-6">
            <h1>Title</h1>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="eventName" DataValueField="eventID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventID], [eventName] FROM [EVENT]">
                <%--<SelectParameters>
                   <asp:ControlParameter ControlID="hdnRowID" Name="p_User" PropertyName="Value" />
               </SelectParameters>--%>
            </asp:SqlDataSource>

            
            
        </div>
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
                  <input type="text" class="form-control" id="eventDate" name="eventDate" onchange="generateAgendaTable();" data-provide="datepicker-inline"/>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group">
               <div class="input-group">
                   <!--pull value from db -->
                   <input type="hidden" value="30" class="form-control" id="eventTime" name="eventTime" onchange="generateAgendaTable();" />
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



        