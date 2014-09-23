﻿// Holds all selected date and times
var dateTimes = [];

// Things to do when the page loads
$(function () {
    // Initialize schedule table
    var currentDate = new Date();
    var day = currentDate.getDate();
    var month = currentDate.getMonth() + 1;
    var year = currentDate.getFullYear();
    document.getElementById('eventDate').text = month + '/' + day + '/' + year;
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
    agendaTable += '<table class="table table-bordered table-responsive" style="background:#fff;" id="agendaTable" runat="server"><thead><tr><th style="width:15%"></th>';

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