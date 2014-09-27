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
//$("#mainContent_eventSelectList").onchange = function () {
//    alert("YO!");
//    $.post("demo_test_post.asp",
//           $("#mainContent_eventSelectList :selected").val(),
//           function (data, status) {
//               alert("Data: " + data + "\nStatus: " + status);
//           });
//}

//----------------------------------------------------------------
// AJAX handler for changing the week of the calendar
//----------------------------------------------------------------
$('body').on('click', '#forward-btn', function () {
    var firstDay = $('#sunday-header').html();

    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: firstDay + 'forward'
    }).done(function (responseText) {
        console.log('Forward button changed the week');
        $('#agendaTableHolder').html() = responseText;
    });

    return false;
});

$('body').on('click', '#back-btn', function () {
    var firstDay = $('#sunday-header').html();

    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: firstDay + 'back'
    }).done(function (responseText) {
        console.log('Backward button changed the week');
        $('#agendaTableHolder').html() = responseText;
    });

    return false;
});

$('.datepicker').datepicker().on("change", function() {
    $.ajax({
        type: 'GET',
        url: '../GenerateCalendar.aspx',
        data: day
    }).done(function (responseText) {
        console.log('Datepicker changed the week');
        $('#agendaTableHolder').html() = responseText;
    });
});