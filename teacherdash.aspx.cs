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

        protected void grdEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEvent")
            {
                hdnRowID.Value = e.CommandArgument.ToString();
                sqlEvents.Delete();
                //grdEventsTable.DataBind();
                hdnRowID.Value = null;
            }

        }

        protected void lnkEvent_Click(object sender, EventArgs e)
        {
            Session["Ninja.eventID"] = ((LinkButton)sender).CommandArgument;
            Response.Redirect("eventpage.aspx");
        }

        protected void grdEventsTable_PreRender(object sender, EventArgs e)
        {
            // You only need the following 2 lines of code if you are not 
            // using an ObjectDataSource of SqlDataSource
            //grdEventsTable.DataSource = Sample.GetData();
            //grdEventsTable.DataBind();

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