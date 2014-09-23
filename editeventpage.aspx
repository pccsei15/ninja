 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="EditEventPage.aspx.cs" Inherits="ProjectNinja.neweventpage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sign in to Timeslots</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- App CSS -->
    <link href="css/app.css" rel="stylesheet" />
    
   
   <link rel="stylesheet" type="text/css" href="css/jquery.timepicker.css" />
   <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.css" />
   <style>
      .removeIcon {
         color:#ff0000;
      }
      
      .addIcon {
         color:#00ff00;
      }
    </style>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container">
      <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
         <div class="container-fluid">
            <div class="navbar-header">
               <a class="navbar-brand" href="teacherdash.html">Project Ninja</a>
            </div>
         </div>
      </div>

      <div class="row">
         <div class="col-md-6">
            <h2 class="form-signin-heading">Edit Event</h2>
         </div>
         <div class="col-md-6">
            <a href="teacherdash.html" class="btn btn-primary pull-right">Save Event</a>
         </div>
      </div>


    <asp:FormView id="eventFormView"
        datasourceid="sqlEvents"
        datakeynames="eventID"
        runat="server">

        <ItemTemplate>

            <asp:Label ID="Label1" runat="server" Text="Label">Event Name
            <asp:TextBox ID="txtEventName" runat="server" text='<%# Eval("eventName") %>'></asp:TextBox>
            </asp:Label>

               <!--<label for="eventName"></label>
               <input type="text" class="form-control" id="eventName" name="eventName" />-->



               <!--<label for="eventDate">Dates</label>
                     <span class="glyphicon glyphicon-calendar"></span>
                  <input type="text" class="form-control" id="eventDate" name="eventDate" />-->



               <!--<label for="eventTime">Times</label>
                     <span class="glyphicon glyphicon-dashboard"></span>
                  <input type="text" class="form-control" id="eventTime" name="eventTime"  />-->




              <!--  <label><span class="glyphicon glyphicon-user"></span> Attendees</label>
               <span class="addAttendees" onclick="addRow(this);">
                  <span class="glyphicon glyphicon-plus-sign addIcon"></span> (Add Class)
               </span>end addAttendees -->

                  <!--<select class="form-control" onchange="disableSelectedAttendees();" name="eventAttendees[]">
                     <option  selected></option>
                     <option value="Class1">Class1</option>
                     <option value="Class2">Class2</option>
                     <option value="Class3">Class3</option>
                     <option value="Class4">Class4</option>
                     <option value="Class5">Class5</option>
                  </select>-->
                  <!--<div class="input-group-addon" onclick="removeRow(this);">
                     <span class="glyphicon glyphicon-minus-sign removeIcon"></span>
                  </div> end input-group-addon -->

            <asp:Label ID="Label5" runat="server" Text="Label">
                <asp:ListBox ID="ListBox2" runat="server" DataTextField="eventLocation" DataValueField="eventID">
                </asp:ListBox>
            </asp:Label>
            

               <!--<label>Location</label>
                     <span class="glyphicon glyphicon-globe"></span>
                  <select class="form-control" name="eventLocation">
                     <option value='' selected></option>
                     <option value="AC">AC</option>
                     <option value="MK">MK</option>
                  </select>-->

          </ItemTemplate>
         </asp:FormView>


      </div>
      <div class="col-md-9" id="agendaTableHolder">
         <table class="table table-bordered table-responsive" style="background:#fff;" id="agendaTable">
            <thead>
               <tr>
                  <th style="width:15%"></th>
                  <th style="width:17%">Monday</th>
                  <th style="width:17%">Tuesday</th>
                  <th style="width:17%">Wednesday</th>
                  <th style="width:17%">Thursday</th>
                  <th style="width:17%">Friday</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td>8am</td>
                  <td class="agenda-slot"></td>
                  <td class="agenda-slot"></td>
                  <td class="agenda-slot"></td>
                  <td class="agenda-slot"></td>
                  <td class="agenda-slot"></td>
               </tr>
            </tbody>
         </table>
      </div><!-- end agendaTableHolder -->
     
     <asp:SqlDataSource
      
        ID="sqlEvents"
        runat="server" 
        ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" 
        ProviderName="System.Data.SqlClient"
        SelectCommand=" 
            SELECT ec.courseID, e.eventLocation, e.eventName
            FROM [SEI_Ninja].[dbo].EVENT e
            JOIN [SEI_Ninja].[dbo].EVENT_COURSES ec ON (e.eventID = ec.eventID)
            WHERE ec.eventID = @eventID"
        CancelSelectOnNullParameter="False" 
        UpdateCommand="
            UPDATE SEI_Ninja.dbo.[EVENT]
            SET eventName = @eventName
            WHERE eventID   = @eventID"
       DeleteCommand="
            DELETE FROM event
            WHERE eventID = @eventID">
         </asp:SqlDataSource>

        <asp:SqlDataSource 
        ID="Timeslots"
        runat="server" 
        ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" 
        ProviderName="System.Data.SqlClient"
        SelectCommand=" 
            SELECT et.eventDate
            FROM [SEI_Ninja].[dbo].EVENT_TIMES et
            WHERE et.eventID = @eventID"

        CancelSelectOnNullParameter="False" 
        UpdateCommand="
            UPDATE SEI_Ninja.dbo.[EVENT]
            SET eventName = @eventName
            WHERE eventID   = @eventID"
       DeleteCommand="
            DELETE FROM event
            WHERE eventID = @eventID">
         </asp:SqlDataSource>
      
      <!-- end main content -->  

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.timepicker.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
   <script>
       // Start the time and date picker
       $(function () {
           $('#eventTime').timepicker();
           $('#eventDate').datepicker({
               'format': 'm/d/yyyy',
               'autoclose': true
           });
       });

       // Add a new row to the bottom of a form group
       function addRow(addRowButton) {
           var parent = $(addRowButton).closest('.form-group');
           var newRow = parent.children('.input-group').last().clone();
           newRow.children().each(function () {
               $('input', this).val('');
           })
           parent.append(newRow);

           // Disable any used options from the select options
           disableSelectedAttendees();
           return;
       }

       // Remove a row from a form group
       function removeRow(removeRowButton) {
           var rows = $(removeRowButton).closest('.form-group').children('.input-group');
           if (rows.length > 1) {
               // Remove the row that was clicked
               $(removeRowButton).closest('.input-group').remove();

               // Disable any used options from the select options
               disableSelectedAttendees();
           }
           else {
               alert("You cannot remove the last one!");
           }
           return;
       }

       // From http://jsfiddle.net/QKy4Y/
       // Disables selection options for classes that are selected.
       function disableSelectedAttendees() {

           // start by setting everything to enabled
           $('#eventAttendees select option').attr('disabled', false);

           // loop each select and set the selected value to disabled in all other selects
           $('#eventAttendees select').each(function () {
               var $this = $(this);
               $('#eventAttendees select').not($this).find('option').each(function () {
                   if ($(this).attr('value') == $this.val())
                       $(this).attr('disabled', true);
               });
           });
           return;
       }

       function generateAgendaTable() {

       }
    </script>
</asp:Content>
