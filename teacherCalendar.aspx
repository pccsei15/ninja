<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="teacherCalendar.aspx.cs" Inherits="ProjectNinja.teacherCalendar" %>
<<<<<<< HEAD
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>New Event</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- App CSS -->
    <link href="css/app.css" rel="stylesheet">
    
   
   <link rel="stylesheet" type="text/css" href="css/jquery.timepicker.css" />
   <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.css" />
   <style>
      .removeIcon {
         color:#ff0000;
      }
      
      .addIcon {
         color:#00ff00;
      }
      
      .selectedDateTime {
         color:#ffffff;
         background-color:#428bca;
         border-color:#357ebd;
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
   <div class="container-fluid">
      <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
         <div class="container-fluid">
            <div class="navbar-header">
               <a class="navbar-brand" href="teacherdash.html">Project Ninja</a>
            </div>
         </div>
      </div>

      <div class="col-sm-12 col-md-12 main">
         <div class="col-md-6">
            <h2 class="form-signin-heading">Filter Events</h2>
         </div>
=======
<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Teacher Calendar</title>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">

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
>>>>>>> b5de49b9bc1aee08e2d05aec105d82ffe14a6be2
      </div>
      <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->  
</asp:Content>

<<<<<<< HEAD
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
      
       <asp:SqlDataSource ID="sqlScheduledAppointments" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient"
            SelectCommand="SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate, et.eventDuration, u.user_first_name + ' ' + u.user_last_name AS name
                             FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
                                  JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
                                  JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id)
                                  JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID)
                            WHERE e.eventOwner = 'mgeary'"
           CancelSelectOnNullParameter="False">
      <SelectParameters>
          <asp:ControlParameter ControlID="hdnRowID" DefaultValue="0" Name="eventOwner" PropertyName="Value" Type="Int32" />
      </SelectParameters>
   </asp:SqlDataSource>

      <!-- end main content -->      
    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.timepicker.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
   <script>
       // Holds all selected date and times
       var dateTimes = [];

       // Things to do when the page loads
       $(document).ready(function () {
           // Initialize schedule table
           var currentDate = new Date();
           var day = currentDate.getDate();
           var month = currentDate.getMonth() + 1;
           var year = currentDate.getFullYear();
           document.getElementById('eventDate').value = month + '/' + day + '/' + year;
           generateAgendaTable();

           // Start the date picker
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
           // Date must of the form m/d/yyyy

           // Number of days to display at a time
           var numberOfDaysToDisplay = 5;
           // Number of minutes each row should be separated by
           var step = parseInt(document.getElementById('eventTime').value);
           // Holds the agenda table
           var agendaTable;
           // Holds the names of days of the week
           var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
           // Holds the date the user has chosen as an array
           var inputDate = document.getElementById('eventDate').value.split("/");
           //Holds all the dates that will be displayed
           var datesToDisplay = [];

           // Gets the dates for each of the days to display
           for (var index = 0; index < numberOfDaysToDisplay; index++) {
               datesToDisplay[datesToDisplay.length] = new Date(inputDate[2], parseInt(inputDate[0]) - 1, parseInt(inputDate[1]) + index);
           }

           agendaTable = '<div class="btn-group btn-group-justified"><div class="btn-group"><input type="button" class="btn btn-primary" onclick="changeSchedualDateRange(-1)" value="Prev Day" /></div><div class="btn-group"><input type="button" class="btn btn-primary" onclick="changeSchedualDateRange(1)" value="Next Day" /></div></div>';
           agendaTable += '<table class="table table-bordered table-responsive" style="background:#fff;" id="agendaTable"><thead><tr><th style="width:15%"></th>';

           for (var offset = 0; offset < numberOfDaysToDisplay; offset++) {
               agendaTable += '<th style="width:17%">' + (datesToDisplay[offset].getMonth() + 1) + '/' + datesToDisplay[offset].getDate() + ' ' + days[datesToDisplay[offset].getDay()] + '</th>';
           }
           agendaTable += '</tr></thead><tbody>';

           // Print the times
           // Time to start at
           datesToDisplay[0].setHours(8, 0, 0, 0);
           // Time to end at
           var endDateTime = new Date(datesToDisplay[0].getTime());
           endDateTime.setHours(17, 0, 0, 0);
           var time;
           while (datesToDisplay[0] <= endDateTime) {
               if (datesToDisplay[0].getHours() <= 12) {
                   time = datesToDisplay[0].getHours() + ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'AM';
               }
               else {
                   time = (datesToDisplay[0].getHours() % 12) + ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'PM';
               }
               agendaTable += '<tr><td>' + time + '</td>';

               // Add the days
               for (var numColumns = 0; numColumns < numberOfDaysToDisplay; numColumns++) {
                   agendaTable += '<td class="agenda-slot" onclick="toggleSelectedDateTime(this);" data-dateTime="' + datesToDisplay[numColumns].toLocaleDateString() + ' ' + time + '"></td>';
               }
               agendaTable += '</tr>';
               datesToDisplay[0].setMinutes(datesToDisplay[0].getMinutes() + step);
           }
           agendaTable += '</tbody></table>';

           // Add the agendaTable to the body
           document.getElementById('agendaTableHolder').innerHTML = agendaTable;

           // Select any dates that has been selected already
           for (index = 0; index < dateTimes.length; index++) {
               $("td[data-datetime='" + dateTimes[index] + "']").addClass("selectedDateTime");
           }
           return;
       }

       // Toggles whether an object is selected or not
       function toggleSelectedDateTime(object) {
           // The class of all objects that are selected
           var selectedClassName = "selectedDateTime";
           // Attribute name of the data to be added or removed from the array
           var dataAttributeName = "data-dateTime";

           if ($(object).hasClass(selectedClassName)) {
               // Has the class so remove the class and the associated value from the array
               $(object).removeClass(selectedClassName);
               dateTimes = $.grep(dateTimes, function (value) {
                   return value != $(object).attr(dataAttributeName);
               });
           }
           else {
               // Does not have the class so add it and the associated value
               $(object).addClass(selectedClassName);
               if (dateTimes.indexOf($(object).attr(dataAttributeName)) == -1) {
                   dateTimes.push($(object).attr(dataAttributeName));
               }
           }
           return;
       }

       function getAllSelectedDateTimes() {
           var formInputsForDateTimes = "";

           for (var index = 0; index < dateTimes.length; index++) {
               formInputsForDateTimes += "<input type=\"hidden\" name=\"dateTimes[]\" value=\"" + dateTimes[index] + "\" />";
           }

           //alert(formInputsForDateTimes);
           $("form").append(formInputsForDateTimes);
           $("form").submit();
           return;
       }

       // Adds any number of days to the current day and recreates the schedule
       function changeSchedualDateRange(daysToAdd) {
           // Find the new input date
           var dateToDisplay = document.getElementById('eventDate').value.split("/");
           dateToDisplay = new Date(dateToDisplay[2], parseInt(dateToDisplay[0]) - 1, parseInt(dateToDisplay[1]) + daysToAdd);

           // Change the input date and recreate the schedule
           var day = dateToDisplay.getDate();
           var month = dateToDisplay.getMonth() + 1;
           var year = dateToDisplay.getFullYear();
           document.getElementById('eventDate').value = month + '/' + day + '/' + year;
           generateAgendaTable();
           return;
       }
    </script>
=======
<asp:Content ID="ExtraJS" ContentPlaceHolderID="extraJs" runat="server">
    <script type="text/javascript" charset="utf8" src="js/calendar.js"></script>
>>>>>>> b5de49b9bc1aee08e2d05aec105d82ffe14a6be2
</asp:Content>
