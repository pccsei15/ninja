// Start the date picker
$('#eventDate').datepicker({
    'format': 'm/d/yyyy',
    todayBtn: "linked",
    todayHighlight: true
});

$("#mainContent_grdEventsTable").dataTable({
    "paging": true,
    "columns": [
        null,
        null,
        null,
        null,
        null,
        { "orderable": false }
    ],
    "order": [0, 'asc'],
    "info": false
});

$("#mainContent_grdStudentEventsTable").dataTable({
    "paging": true,
    "columns": [
        null,
        null,
        null,
        { "orderable": false }
    ],
    "order": [0, 'asc'],
    "info": false
});

$("#mainContent_grdEventsAvailable").dataTable({
    "paging": true,
    "columns": [
        null,
        null,
        null,
        { "orderable": false }

    ],
    "order": [0, 'asc'],
    "info": false
});

fixGridView($("#mainContent_grdEventsTable"));
fixGridView($("#grdStudentEventsTable"));
fixGridView($("#mainContent_grdEventsAvailable"));

//GridviewFix Plugin Code
function fixGridView(tableEl) {
    var jTbl = $(tableEl);

    if (jTbl.find("tbody>tr>th").length > 0) {
        jTbl.find("tbody").before("<thead><tr></tr></thead>");
        jTbl.find("thead tr").append(jTbl.find("th"));
        jTbl.find("tbody tr:first").remove();
    }
}

//----------------------------------------------------------------
// AJAX handler for changing the week of the calendar
//----------------------------------------------------------------

function getDate() {
    var dateObj = new Date(),
        day = dateObj.getDate(),
        month = dateObj.getMonth() + 1,
        year = dateObj.getFullYear(),
        date = month + '/' + day + '/' + year;

    return date;
}

$(function () {
    var colCount = 0;
    $('tr:nth-child(1) td').each(function () {
        if ($(this).attr('colspan')) {
            colCount += +$(this).attr('colspan');
        } else {
            colCount++;
        }
    });
});

$(function () {
    var child;
    $(this).attr('rowspan');
});

$(function () {
    $('#eventDate').datepicker('update', getDate());
});

function getParameters() {
    var parameters = "";

    if (document.title === "Teacher Calendar")
        parameters = "?haveInfo=";
    else if (document.title === "Add Event")
        parameters = "?selectable=yes";
    else if (document.title === "Edit Event")
        parameters = "?haveInfo=&selectable=";

    return parameters;
}

$(function () {
    var dateParam = getDate();

    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters()
    }).done(function (responseText) {
        $('#agendaTableHolder').html(responseText);
        console.log('Calendar added successfully on page load');
    });
});

$('body').on('click', '#forward-btn', function () {
    var currentDate = getDate(),
        dateParam = $('#sunday-header').html().split(">");
    dateParam = dateParam[1];

    console.log(getParameters());

    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters() + '&direction=' + 'forward&startDate=' + dateParam
    }).done(function (responseText) {
        var dateString = $('#eventDate').data('date');
        var oldDate = new Date(dateString);

        oldDate.setDate(oldDate.getDate() + 7);
        $('#eventDate').datepicker('update', (oldDate.getMonth() + 1) + '/' + oldDate.getDate() + '/' + oldDate.getFullYear());
        $('#agendaTableHolder').html(responseText);
        console.log('Forward button changed the week');
    });

    return false;
});

$('body').on('click', '#back-btn', function () {
    var currentDate = getDate(),
        dateParam = $('#sunday-header').html().split(">");
    dateParam = dateParam[1];

    console.log(getParameters());

    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters() + '&direction=back&startDate=' + dateParam
    }).done(function (responseText) {
        var dateString = $('#eventDate').data('date');
        var oldDate = new Date(dateString);

        oldDate.setDate(oldDate.getDate() - 7);
        $('#eventDate').datepicker('update', (oldDate.getMonth() + 1) + '/' + oldDate.getDate() + '/' + oldDate.getFullYear());
        $('#agendaTableHolder').html(responseText);
        console.log('Backward button changed the week');
    });

    return false;
});

$('#eventDate').datepicker().on("changeDate", function () {
    /*var dateParam = $('.datepicker').datepicker().getDate();

    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters() + '&startDate=' + dateParam
    }).done(function (responseText) {
        console.log('Datepicker changed the week');
        $('#agendaTableHolder').html(responseText);
    });

    return false;*/

    var currentDate = getDate(),
    dateParam = $('#eventDate').data('date');

    console.log(dateParam);
    console.log(getParameters());

    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters() + '&startDate=' + dateParam
    }).done(function (responseText) {
        
        $('#agendaTableHolder').html(responseText);
        console.log('Datepicker changed the week');
    });

    return false;
});

// Update the calendar when the duration changes
$('#eventTime').on("change", function () {
    $.ajax({
        url: 'GenerateCalendar.aspx' + getParameters() + '&startDate=' + $('#eventDate').data('date') + "&step=" + document.getElementById('eventTime').value
    }).done(function (responseText) {

        $('#agendaTableHolder').html(responseText);
    });

    return false;
});