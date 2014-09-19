using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja
{
    public partial class teacherdash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grdEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "EditEvent" || e.CommandName == "CancelEdit")
            {
                GridViewRow gvr = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                int RowIndex = gvr.RowIndex;

                if (e.CommandName == "EditEvent")
                    grdEventsTable.EditIndex = RowIndex;
                else
                    grdEventsTable.EditIndex = -1;
            }
            else if (e.CommandName == "AcceptEdit" || e.CommandName == "DeleteEvent")
            {
                hdnRowID.Value = e.CommandArgument.ToString();

                if (e.CommandName == "AcceptEdit")
                    sqlEvents.Update();
                else
                    sqlEvents.Delete();

                hdnRowID.Value = null;
            }

            grdEventsTable.DataBind();

        }
    }
}