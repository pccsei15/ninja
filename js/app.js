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
        day     = currentDate.getDate(),
        month   = currentDate.getMonth() + 1,
        year    = currentDate.getFullYear(),
        date    = day + '/' + month + '/' + year;

    return date;
}

$(function () {
    var dateParam = getDate();
    
    $.ajax({
        type: GET,
        url: '../GenerateCalendar.aspx',
        data: dateParam
    }).done(function () {
        $('#agendaTableHolder').html() = responseText;
        console.log('Calendar added successfully on page load');
    });
});

$('body').on('click', '#forward-btn', function () {
    var currentDate = getDate(),
        dateParam = $('#sunday-header').substr(original.indexOf(" ") + 1) + '/' + '2014';

    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: dateParam + 'forward'
    }).done(function (responseText) {
        $('#agendaTableHolder').html() = responseText;
        console.log('Forward button changed the week');
    });

    return false;
});

$('body').on('click', '#back-btn', function () {
    var currentDate = getDate(),
        dateParam = $('#sunday-header').substr(original.indexOf(" ") + 1) + '/' + '2014';

    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: dateParam + 'back'
    }).done(function (responseText) {
        $('#agendaTableHolder').html() = responseText;
        console.log('Backward button changed the week');
    });

    return false;
});

$('.datepicker').datepicker().on("changeDate", function() {
    var dateParam = $('.datepicker').datepicker().getDate();

    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: dateParam
    }).done(function (responseText) {
        console.log('Datepicker changed the week');
        $('#agendaTableHolder').html() = responseText;
    });

    return false;
});
