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

function fillText() {
    var infoArray = JSON.parse(document.getElementById("mainContent_info").value);
    var timeslotsArray = JSON.parse(document.getElementById("mainContent_timeslots").value);

    for (i = 0; i < infoArray.length; i++) {
        var courseID = parseInt(infoArray[i].courseID);
        var eventLocation;
        switch (infoArray[i].eventLocation)
        {
            case "AC":  eventLocation = 1; break;
            case "MK":  eventLocation = 2; break;
            case "DHA": eventLocation = 3; break;
            default:    eventLocation = 0; break;
        }
        var eventName = infoArray[i].eventName;

        var pageEventName = document.getElementById("eventName");
        var pageEventLocation = document.getElementById("eventBuilding");
        var pageCourseID = document.getElementById("courseID");

        pageEventName.textContent = eventName;
        pageEventLocation.selectedIndex = eventLocation;
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

