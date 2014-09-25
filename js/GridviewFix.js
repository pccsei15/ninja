//GridviewFix Plugin Code

function fixGridView(tableEl) {
    var jTbl = $(tableEl);

    if (jTbl.find("tbody>tr>th").length > 0) {
        jTbl.find("tbody").before("<thead><tr></tr></thead>");
        jTbl.find("thead tr").append(jTbl.find("th"));
        jTbl.find("tbody tr:first").remove();
    }
}