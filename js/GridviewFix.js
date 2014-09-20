﻿//GridviewFix Plugin Code
    /*
 An object required as an argument for the class names of the header , 
 rows and footer of the target table.
 Below are the default values for the plugins parameter object.
 {
     header:"headerStyle" // header class name
     ,row:"rowStyle" //row class name
     ,footer:"footerStyle" //footer class name
 }
 */
 /*   (function ($, undefined) {
        $.fn.GridviewFix = function (params) {
            var settings = $.extend({}, {
                header: "headerStyle", row: "rowStyle",
                footer: "footerStyle"
            }, params);
            return this.each(function () {
                var
                ctxt = $(this)
                , thead = $("").append($("tr.".concat(settings.header), ctxt))
                , tbody = $("").append($("tr.".concat(settings.row), ctxt))
                , tfooter = $("").append($("tr.".concat(settings.footer), ctxt));
                $("tbody", ctxt).remove();
                ctxt.append(thead).append(tbody).append(tfooter);
            });
        }
    })(jQuery);*/

function fixGridView(tableEl) {
    var jTbl = $(tableEl);

    if (jTbl.find("tbody>tr>th").length > 0) {
        jTbl.find("tbody").before("<thead><tr></tr></thead>");
        jTbl.find("thead tr").append(jTbl.find("th"));
        jTbl.find("tbody tr:first").remove();
    }
}