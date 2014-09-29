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

      /// <summary>
      /// Redirects to the eventpage, and stores the eventID in a session variable
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      protected void grdAvailEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
      {
         if (e.CommandName == "signUpEvent")
         {
            string[] arguments = new string[2];
            arguments = e.CommandArgument.ToString().Split(',');
            DropDownList ddlEventTimes = (DropDownList)(grdEventsAvailable.Rows[int.Parse(arguments[1])].Cells[2].FindControl("ddlEventTimes"));
            
            //Prepare the DB for the insert
            SqlCommand cmdSignUp = new SqlCommand(@"
INSERT INTO [SEI_Ninja].[dbo].SCHEDULED_USERS (eventTimeID, userID)
VALUES(@p_eventTimeID, @p_userID)",
        new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdSignUp.Parameters.AddWithValue("p_eventTimeID", ddlEventTimes.SelectedValue);
            cmdSignUp.Parameters.AddWithValue("p_userID", HttpContext.Current.Session["username"].ToString());

            //Execute the insert
            cmdSignUp.Connection.Open();
            cmdSignUp.ExecuteNonQuery();
            cmdSignUp.Connection.Close();

            //Refresh both tables with the new information
            grdStudentEventsTable.DataBind();
            grdEventsAvailable.DataBind();
         }
      }

      protected void grdStudentEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
      {
         //Delete funcationality
         if (e.CommandName == "delete")
         {
            //Prepair the DB for the Delete
            SqlCommand cmdDrop = new SqlCommand(@"
DELETE FROM [SEI_Ninja].[dbo].SCHEDULED_USERS
WHERE (eventID == @p_eventID)",
            new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdDrop.Parameters.AddWithValue("p_eventID", e.CommandArgument.ToString());

            //Execute the Delete
            cmdDrop.Connection.Open();
            cmdDrop.ExecuteNonQuery();
            cmdDrop.Connection.Close();
         }
//         //Edit Functionality          
//         else if (e.CommandName == "edit")
//         {
//            //Sets the calling row into edit mode.
//            grdStudentEventsTable.EditIndex = int.Parse(e.CommandArgument.ToString());
//         }
//         else if (e.CommandName == "update" || e.CommandName == "cancel")
//         {
//            //Update Funcationality an
//            if (e.CommandName == "update")
//            {
//               string[] arguments = new string[2];
//               arguments = e.CommandArgument.ToString().Split(',');
//               DropDownList ddlEventTimes = (DropDownList)(grdEventsAvailable.Rows[int.Parse(arguments[1])].Cells[2].FindControl("ddlEventTimes"));

//               //Set Prepair the Database for Edit
//               SqlCommand cmdEdit = new SqlCommand(@"
//UPDATE [SEI_Ninja].[dbo].SCHEDULED_USERS
//   SET (eventTimeID = @p_eventTimeID)
//WHERE (eventID == @p_eventID)",
//               new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
//               cmdEdit.Parameters.AddWithValue("p_eventTimeID", ddlEventTimes.SelectedIndex);
//               cmdEdit.Parameters.AddWithValue("p_eventID", arguments[0]);

//               //Execute to DB command
//               cmdEdit.Connection.Open();
//               cmdEdit.ExecuteNonQuery();
//               cmdEdit.Connection.Close();
//            }
//            // Set table back to no edit.
//            grdStudentEventsTable.EditIndex = -1;
//         }

         //Update the gridviews with the new information.
         grdStudentEventsTable.DataBind();
         grdEventsAvailable.DataBind();
      }

      /// <summary>
      /// Nessessary for getting grdView header in the EventsTable to display its style
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      protected void grdStudentEventsTable_PreRender1(object sender, EventArgs e)
      {

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