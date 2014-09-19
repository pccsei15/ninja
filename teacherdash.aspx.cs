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
            
        }

        protected void grdEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEvent")
            {
                hdnRowID.Value = e.CommandArgument.ToString();
                sqlEvents.Delete();
                grdEventsTable.DataBind();
                hdnRowID.Value = null;
            }

        }

        protected void lnkEvent_Click(object sender, EventArgs e)
        {
            Session["Ninja.eventID"] = ((LinkButton)sender).CommandArgument;
            Response.Redirect("eventpage.aspx");
        }
    }
}