$(document).ready(function() {
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

} );

$(function() {
  $('#datepicker').datepicker();
});

function TodaysDate() {
 var currentTime = new Date()
 var month = currentTime.getMonth() + 1
 var day = currentTime.getDate()
 var year = currentTime.getFullYear()

 return month + "/" + day + "/" + year;
}

$("#btn-today").click(function() {
  var today = new Date();
  $('#datepicker').datepicker('setDate', TodaysDate()); 
});