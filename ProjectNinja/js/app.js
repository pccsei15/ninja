$(document).ready(function () {
    $("#ContentPlaceHolder1_grdTeacherEventsTable").dataTable({
        "paging": false,
        "columns": [
            null,
            null,
            null,
            null,
            null,
            { "orderable": false }
        ],
        "order": [0, 'asc'],
        "info": true
    });

    $("#ContentPlaceHolder1_grdStudentEventsTable").dataTable({
      "paging": false,
      "columns": [
          null,
          null,
          null,
          { "orderable": false }
        ],
      "order": [0, 'asc'],
      "info": false
    });

    $("#ContentPlaceHolder1_grdEventsAvailable").dataTable({
        "paging": false,
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
    fixGridView($("#grdTeacherEventsTable"));
    $("#grdTeacherEventsTable").tablesorter({ sortList: [[1, 0]] });
    fixGridView($("#grdStudentEventTable"));
    $("#grdStudentEventTable").tablesorter({ sortList: [[1, 0]] });
    fixGridView($("#grdEventsAvailable"));
    $("#grdEventsAvailable").tablesorter({ sortList: [[1, 0]] });
});

//GridviewFix Plugin Code

function fixGridView(tableEl) {
    var jTbl = $(tableEl);

    if (jTbl.find("tbody>tr>th").length > 0) {
        jTbl.find("tbody").before("<thead><tr></tr></thead>");
        jTbl.find("thead tr").append(jTbl.find("th"));
        jTbl.find("tbody tr:first").remove();
    }
}