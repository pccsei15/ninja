using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ProjectNinja
{
    public partial class eventpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsPostBack)
            {
                //EventNameSelect.SelectedValue = Session["Ninja.eventId"];
            }
        }

        //protected void EventNameSelect_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    Session["Ninja.eventID"] = EventNameSelect.SelectedValue;
        //}


        




    }
}