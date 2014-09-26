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

function callGetEventData() {
    $.ajax({
        type: "POST",
        url: "GetEventData.aspx",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (response) {
            alert(response.d);
        }
    });
    $.post("GetEventData.aspx",
      ,
      function(data,status){
          alert("Data: " + data + "\nStatus: " + status);
      });
    });
}
