﻿// Holds all selected date and times
var dateTimes = [];
// The first hour to show on the calendar
var beginHour = 8;
// The last hour to show on the calendar
var endHour = 17;


// Things to do when the page loads
$(document).ready(function () {
    // Initialize schedule table
    var currentDate = new Date();
    var day = currentDate.getDate();
    var month = currentDate.getMonth() + 1;
    var year = currentDate.getFullYear();
   // var eDate = document.getElementById('eventDate').value;
    document.getElementById('eventDate').value = month + '/' + day + '/' + year;

    /*
    if (document.title === "Teacher Calendar")
        generateAgendaTable("TC");
    else if (document.title === "Event Sign Up") 
        generateAgendaTable("ESU");
    else
        generateAgendaTable();
    */
});

$("#eventDatePicker").datepicker({
    onSelect: function (dateText, inst) {
        var dateAsString = dateText; //the first parameter of this function
        var dateAsObject = $(this).datepicker('getDate'); //the getDate method
        document.getElementById('eventDate').value = dateAsString;
    }
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

function generateAgendaTable(pageName) {

    // The default pageName was added to accommodate small changes for the teacherCalendar page
    //pageName = pageName || "true";
    if (pageName === undefined) {
        pageName = "undefined";
    }
    

    // Date must of the form m/d/yyyy

    // Number of days to display at a time
    var numberOfDaysToDisplay = 5;
    // Number of minutes each row should be separated by
    //var step = (pageName === "TC" ? 15 : (parseInt(document.getElementById('eventTime').value)));
    if (pageName === "TC")
        var step = 15;
    else {
        var step = parseInt(document.getElementById('eventTime').value);
    }

    // Holds the agenda table
    var agendaTable;
    // Holds the names of days of the week
    var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    // Holds the date the user has chosen as an array
    var inputDate = document.getElementById('eventDate').value.split("/");
    // Holds all the dates that will be displayed
    var datesToDisplay = [];
    //
    var includeOnClick = "";


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
    datesToDisplay[0].setHours(beginHour, 0, 0, 0);
    // Time to end at
    var endDateTime = new Date(datesToDisplay[0].getTime());
    endDateTime.setHours(endHour, 0, 0, 0);
    var time;
    while (datesToDisplay[0] <= endDateTime) {
        if (datesToDisplay[0].getHours() < 12) {
            time = datesToDisplay[0].getHours() + ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'AM';
        }
        else {
            if (datesToDisplay[0].getHours() == 12) {
                time = 12;
            }
            else {
                time = (datesToDisplay[0].getHours() % 12);
            }
            time += ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'PM';
        }
        agendaTable += '<tr><td>' + time + '</td>';

        pageName === "TC" ? includeOnClick = '' : includeOnClick = 'onclick="toggleSelectedDateTime(this);"';

        // Add the days
        for (var numColumns = 0; numColumns < numberOfDaysToDisplay; numColumns++) {
            agendaTable += '<td class="agenda-slot" selectable="false" ' + includeOnClick + ' data-dateTime="' + datesToDisplay[numColumns].toLocaleDateString() + ' ' + time + '" id="' + datesToDisplay[numColumns].toLocaleDateString() + ' ' + time + '"></td>';
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

    pageName != "undefined" ? populateAgendaTable() : "undefined";

    return;
}

// Populate the calendar with scheduled appointments
function populateAgendaTable() {
    // Array/mapping that holds all the info for each scheduled event
    var appointmentArray = JSON.parse(document.getElementById("mainContent_hdnScheduledAppointments").value);
    // Array/mapping that holds scheduled event information grouped by eventID
    var eventsByIDArray = null;

    var eventIDIndex = 0;
                   //  red       purple    green     yellow    blue
    var colorArray = ["D73A2B", "9A3AE1", "3EE173", "D7D43A", "428BCA"];

    var currentColorNumber = 0;

    for (i = 0; i < appointmentArray.length; i++) {
        var message = appointmentArray.length + ' arrayLength';
        alert(message);
        // Date given from the database
        var date = parseDate(appointmentArray[i].eventDate);
        // Same date from database, just in the right format
        var dateID = (date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear() + " " + ((date.getHours() == 12) ? date.getHours() : (date.getHours() % 12)) + ":" + zeroPad(date.getMinutes(), 2);

        if (date.getHours() < 12)
            dateID += 'AM';
        else
            dateID += 'PM';

        // How many rows to fill in total to account for the duration of the event
        var rowsToFill = appointmentArray[i].eventDuration / 15;

        if (i != 0) {
            if (appointmentArray[i] != appointmentArray[i - 1]) {
                currentColorNumber = currentColorNumber == 4 ? 1 : currentColorNumber++;
            }
        }

        if (document.getElementById(dateID)) {
            document.getElementById(dateID).innerHTML = "<p style='font-size: 18px;style=line-height: 100%;'>" + appointmentArray[i].eventUserName + "</p><p style='line-height: 10%;'>" + appointmentArray[i].eventName + "</p><p style='line-height: 30%;'>" + appointmentArray[i].eventLocation + "</p>";
            document.getElementById(dateID).className += " selectedDateTime";
            document.getElementById(dateID).style.backgroundColor = "#" + colorArray[currentColorNumber];

            var minutes = parseInt(zeroPad(date.getMinutes(), 2));
            var hour = ((date.getHours() == 12) ? date.getHours() : (date.getHours() % 12));

            for (var i = 1; i <= rowsToFill - 1; i++) {
                
                if (minutes !== 45)
                    minutes += 15;
                else {
                    minutes = 0;
                    hour += 1;
                }

                dateID = (date.getMonth() + 1) + '/' + date.getDate() + '/' + date.getFullYear() + " " + hour + ":" + zeroPad(minutes, 2);
                if (date.getHours() < 12)
                    dateID += 'AM';
                else
                    dateID += 'PM';

                document.getElementById(dateID).className += " selectedDateTime";
                alert(dateID);
            }


        }


        //eventsByIDArray[i] = appointmentArray[i].eventID;
        //eventsByIDArray[i] = appointmentArray[i].eventLocation;

    }


}

function parseDate(str) {
    var m = str.match(/^(\d{4})\-(\d\d)\-(\d\d)T(\d\d):(\d\d):(\d\d)$/);
    return (m) ? new Date(m[1], m[2] - 1, m[3], m[4], m[5]) : null;
}

// Pad zeros to the left of a number
function zeroPad(num, places) {
    var zero = places - num.toString().length + 1;
    return Array(+(zero > 0 && zero)).join("0") + num;
}

// Toggles whether an object is selected or not
function toggleSelectedDateTime(object) {
    // The class of all objects that are selected
    var selectedClassName = "selectedDateTime";
    // Attribute name of the data to be added or removed from the array
    var dataAttributeName = "data-dateTime";

    if ($(object).hasClass("info")) {
        $(object).removeClass("info");
        $(object).css('border', '1px solid #ddd;!important');
        $(object).html("");
    }

    if ($(object).hasClass(selectedClassName)) {
        // Has the class so remove the class and the associated value from the array
        $(object).removeClass(selectedClassName);
        dateTimes = $.grep(dateTimes, function (value) {
            return value != $(object).attr(dataAttributeName);
        });

        if ($(object).hasClass("info")) {
            $(object).removeClass("info");
            $(object).css('border', '1px solid #ddd;!important');
            $(object).html("");
        }
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
    if (document.title === "Teacher Calendar")
        generateAgendaTable("TC");
    else if (document.title === "Event Sign Up")
        generateAgendaTable("ESU");
    else
        generateAgendaTable();
    return;
}

// Populates selected cell with user and event data (need to send to the db)
function signUp(object) {
    // Array/mapping that holds all the info for each scheduled event
    var appointmentArray = JSON.parse(document.getElementById("mainContent_hdnScheduledAppointments").value);
    // Array/mapping that holds scheduled event information grouped by eventID
    var eventsByIDArray = null;

    var eventIDIndex = 0;
    //  red       purple    green     yellow    blue
    var colorArray = ["D73A2B", "9A3AE1", "3EE173", "D7D43A", "428BCA"];

    var currentColorNumber = 0;

    // Need dateID, username, eventname and eventlocation -> userID and eventID and timeID for updating database
    // Figure out how to place in right cell with the updated plugin code
    document.getElementById(dateID).innerHTML =
        "<p style='font-size: 18px;style=line-height: 100%;'>"
        + appointmentArray[i].eventUserName
        + "</p><p style='line-height: 10%;'>"
        + appointmentArray[i].eventName
        + "</p><p style='line-height: 30%;'>"
        + appointmentArray[i].eventLocation
        + "</p>";
    document.getElementById(dateID).className += " selectedDateTime";
    document.getElementById(dateID).style.backgroundColor = "#" + colorArray[currentColorNumber];
}