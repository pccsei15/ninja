using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ProjectNinja
{
    public partial class teacherdash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hdnRowID.Value = "mgeary";//Session["Ninja.UserID"].ToString();
        }

        /// <summary>
        /// Deletes a specified event from the list of events a teacher has on the TeacherDash page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>  
        protected void grdEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEvent")
            {
                hdnRowID.Value = e.CommandArgument.ToString();

                sqlEvents.Delete();                
                //grdEventsTable.DataBind();

                hdnRowID.Value = null;
            }
            else if (e.CommandName == "EditEvent")
            {
               Session["Ninja.eventID"] = e.CommandArgument.ToString();
               Response.Redirect("eventpage.aspx");
            }

        }

        /// <summary>
        /// Redirects to the eventpage, and stores the eventID in a session variable
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkEvent_Click(object sender, EventArgs e)
        {
            Session["Ninja.eventID"] = ((LinkButton)sender).CommandArgument;
            Response.Redirect("eventpage.aspx");
        }

        /// <summary>
        /// Nessessary for getting grdView header in the EventsTable to display its style
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdEventsTable_PreRender(object sender, EventArgs e)
        {

            if (grdEventsTable.Rows.Count > 0)
            {
                //This replaces <td> with <th> and adds the scope attribute
                grdEventsTable.UseAccessibleHeader = true;

                //This will add the <thead> and <tbody> elements
                grdEventsTable.HeaderRow.TableSection = TableRowSection.TableHeader;

                //This adds the <tfoot> element. 
                //Remove if you don't have a footer row

                grdEventsTable.FooterRow.TableSection = TableRowSection.TableFooter;
            }

        }
    }
}