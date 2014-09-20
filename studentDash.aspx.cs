using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja
{
    public partial class studentDash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hdnStudentID.Value = "120420";
        }

        protected void grdStudentEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           Session["Ninja.eventID"] = Convert.ToInt32(e.CommandArgument);
           Response.Redirect("eventpage.aspx");
        }

        protected void grdStudentEventsTable_PreRender1(object sender, EventArgs e)
        {
            // You only need the following 2 lines of code if you are not 
            // using an ObjectDataSource of SqlDataSource
            //grdStudentEventsTable.DataSource = sqlEvents.GetData();
            //grdStudentEventsTable.DataBind();

            if (grdStudentEventsTable.Rows.Count > 0)
            {
                //This replaces <td> with <th> and adds the scope attribute
                grdStudentEventsTable.UseAccessibleHeader = true;

                //This will add the <thead> and <tbody> elements
                grdStudentEventsTable.HeaderRow.TableSection = TableRowSection.TableHeader;

                //This adds the <tfoot> element. 
                //Remove if you don't have a footer row
                grdStudentEventsTable.FooterRow.TableSection = TableRowSection.TableFooter;
            }

        }

        protected void grdEventsAvailable_PreRender1(object sender, EventArgs e)
        {
            // You only need the following 2 lines of code if you are not 
            // using an ObjectDataSource of SqlDataSource
            //grdStudentEventsTable.DataSource = sqlEvents.GetData();
            //grdStudentEventsTable.DataBind();

            if (grdEventsAvailable.Rows.Count > 0)
            {
                //This replaces <td> with <th> and adds the scope attribute
                grdEventsAvailable.UseAccessibleHeader = true;

                //This will add the <thead> and <tbody> elements
                grdEventsAvailable.HeaderRow.TableSection = TableRowSection.TableHeader;

                //This adds the <tfoot> element. 
                //Remove if you don't have a footer row
                grdEventsAvailable.FooterRow.TableSection = TableRowSection.TableFooter;
            }

        }
    }
}