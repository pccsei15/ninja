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
            hdnRowID.Value = e.CommandArgument.ToString();

            if (e.CommandName == "EditEvent")
            {
                grdEventsTable.EditIndex = Convert.ToInt32(e.CommandArgument);
                grdEventsTable.DataBind();
            }
            else if (e.CommandName == "DeleteEvent")
            {
                sqlEvents.Delete();
                grdEventsTable.DataBind();
            }

            hdnRowID.Value = null;
        }
    }
}