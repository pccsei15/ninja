<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="./MasterPage.Master" CodeBehind="EditEventPage.aspx.cs" Inherits="ProjectNinja.VersionedCode.EditEventPage1" %>

<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Edit Event</title>
</asp:Content>
<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Edit Event</li>
</asp:content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">  

        <div class="row">
      <div class="col-sm-12 col-md-12 main">

         <div class="col-md-6">
            <h1>Edit Event</h1>
         </div>
         <div class="col-md-6">
         </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-3">
        <form runat="server">
            <div class="form-group">
               <label for="eventName">Event Name</label>
              <!-- <input type="text" class="form-control" id="eventName" name="eventName" value="" /> -->
                <asp:TextBox CssClass="form-control" ID="txteventName" runat="server"></asp:TextBox>
            </div><!-- end form-group -->
            
            <asp:HiddenField ID="eventInfo" runat="server" />
            <asp:HiddenField ID="eventTimeslots" runat="server" />

            <div class="form-group">
               <label for="eventDate">Date</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-calendar"></span>
                  </div><!-- end input-group-addon -->
                  <asp:TextBox CssClass="form-control" ID="eventDate" runat="server"></asp:TextBox>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group">
               <label for="eventTime">Time Step</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-dashboard"></span>
                  </div><!-- end input-group-addon -->
                  <asp:DropDownList CssClass="form-control" ID="ddleventTime" runat="server">  
                       <asp:ListItem>15</asp:ListItem>
                       <asp:ListItem>30</asp:ListItem>
                       <asp:ListItem>60</asp:ListItem>
                   </asp:DropDownList>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group" id="eventAttendees">
               <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
               <div class="input-group">
                   <asp:CheckBoxList ID="cblAttendees" runat="server">
                   </asp:CheckBoxList>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            
            <div class="form-group" id="eventLocation">
               <label>Location</label>
               <div class="input-group">
                  <div class="input-group-addon">
                     <span class="glyphicon glyphicon-globe"></span>
                  </div><!-- end input-group-addon -->
                  <asp:TextBox CssClass="form-control" ID="txteventLocation" runat="server" ></asp:TextBox>
               </div><!-- end input-group -->
            </div><!-- end form-group -->
            <asp:Button CssClass="btn btn-primary pull-right" Text="Submit" ID="submit" OnClick="submit_Click" runat="server" />
        </form>
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->     
      <!-- end main content -->      
    </div>   
</asp:Content>
