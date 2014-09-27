using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
           if (HttpContext.Current.Session["username"] != null)
              hdnStudentID.Value = HttpContext.Current.Session["username"].ToString();
        }

        protected void ddlEventTimes_SelectedIndexChanged(object sender, System.EventArgs e)
        {
           //DropDownList SelecteTime = (DropDownList)sender;
           //lblTest.Text = SelecteTime.SelectedValue;

        }

        /// <summary>
        /// Redirects to the eventpage, and stores the eventID in a session variable
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdStudentEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //Session["Ninja.eventID"] = Convert.ToInt32(e.CommandArgument);
            //Response.Redirect("eventpage.aspx");
           //hdnEventTimes.Value = e.CommandArgument.ToString();
           if (e.CommandName == "signUpEvent")
           {
              string[] arguments = new string[2];
              arguments = e.CommandArgument.ToString().Split(',');

              //DataRowView drv = ((GridView)e).Row
              DropDownList ddlEventTimes = (DropDownList)(grdEventsAvailable.Rows[int.Parse(arguments[1])].Cells[2].FindControl("ddlEventTimes"));//(DropDownList)((GridView)e).Rows[int.Parse(arguments[1])].Cells[2].FindControl("ddlEventTimes");

              //lblTest.Text = ddlEventTimes.SelectedValue;
              
              SqlCommand cmdSignUp = new SqlCommand(@"
INSERT INTO [SEI_Ninja].[dbo].SCHEDULED_USERS (eventTimeID, userID)
VALUES(@p_eventTimeID, @p_userID)",
      new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
              cmdSignUp.Parameters.AddWithValue("p_eventTimeID", ddlEventTimes.SelectedValue);
              cmdSignUp.Parameters.AddWithValue("p_userID", "112043");//Session["Ninja.UserID"].ToString());

              cmdSignUp.Connection.Open();

              cmdSignUp.ExecuteNonQuery();

              cmdSignUp.Connection.Close();

              grdStudentEventsTable.DataBind();
              grdEventsAvailable.DataBind();
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