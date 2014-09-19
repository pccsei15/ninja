// DataTables Functions

$(document).ready(function () {
    $('#events-table').dataTable({
        "paging": false,
        "columns": [
            { "orderable": false },
            null,
            null,
            null,
            null,
            { "orderable": false }
        ],
        "order": [2, 'asc'],
        "info": false
    });

});

// DatePicker Functions

$(function () {
    $('#datepicker').datepicker();
});

// Start the time and date picker
$(function () {
    $('#eventDate').datepicker({
        todayHighlight: true,
        todayBtn: "linked"
    });
});