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
        null,
        { "orderable": false }
    ],
    "order": [0, 'asc'],
    "info": false
});

fixGridView($("#mainContent_grdEventsTable"));
$("#mainContent_grdEventsTable").tablesorter({ sortlist: [[1, 0]] });
fixGridView($("#grdStudentEventsTable"));
$("#grdStudentEventsTable").tablesorter({ sortlist: [[1, 0]] });
fixGridView($("#mainContent_grdEventsAvailable"));
$("#mainContent_grdEventsAvailable").tablesorter({ sortlist: [[1, 0]] });

//GridviewFix Plugin Code
function fixGridView(tableEl) {
    var jTbl = $(tableEl);

    if (jTbl.find("tbody>tr>th").length > 0) {
        jTbl.find("tbody").before("<thead><tr></tr></thead>");
        jTbl.find("thead tr").append(jTbl.find("th"));
        jTbl.find("tbody tr:first").remove();
    }
}

// Student page tabs
$('#available a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
});

$('#scheduled a[href="#scheduled"]').tab('show');