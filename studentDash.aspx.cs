using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja
{

    public partial class studentDash : System.Web.UI.Page
    {
       int ddlSelectedValue;

        protected void Page_Load(object sender, EventArgs e)
        {
           if (Session["Ninja.UserID"] != null)
              hdnStudentID.Value = Session["Ninja.UserID"].ToString();
              hdnStudentID.Value = "112043";
        }

        protected void ddlEventTimes_SelectedIndexChanged(object sender, System.EventArgs e)
        {
           DropDownList SelecteTime = (DropDownList)sender;
           lblTest.Text = SelecteTime.SelectedValue;
        }

        /// <summary>
        /// Redirects to the eventpage, and stores the eventID in a session variable
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdStudentEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           //hdnEventTimes.Value = e.CommandArgument.ToString();
           if (e.CommandName == "signUpEvent")
           {
              //(DropDownList)e.Row.FindControl("DDL_StatusList1");
              //lblTest.Text = grdEventsAvailable;
              //hdnEventTimes.Value = e.CommandArgument.ToString();
              //grdEventsAvailable.EditIndex = Convert.ToInt32(e.CommandArgument);
              //grdEventsAvailable.DataBind();
              //Session["Ninja.eventID"] = Convert.ToInt32(e.CommandArgument);
              //Response.Redirect("eventpage.aspx");
           }
        }

        /// <summary>
        /// Nessessary for getting grdView header in the EventsTable to display its style
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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

        /// <summary>
        /// Nessessary for getting grdView header in the EventsAvailable table to display its style
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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