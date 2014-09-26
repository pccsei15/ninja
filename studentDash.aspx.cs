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
        protected void Page_Load(object sender, EventArgs e)
        {
           Page.ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script     language=JavaScript>alert('Testing');</script>");

           int isStudent = 0,
               isTeacher = 0,
               isEnabled = 0;
           string current_login_id,
                  current_user_id;

           //if (HttpContext.Current.Session["username"] == null)
           //{

           current_login_id = HttpContext.Current.User.Identity.Name;
           current_user_id = current_login_id.Substring(current_login_id.LastIndexOf('\\') + 1);
           HttpContext.Current.Session["username"] = 100;//current_user_id;

           SqlCommand cmdLoadID = new SqlCommand(@"
SELECT user_is_enabled, user_is_student, user_is_teacher
  FROM SEI_TimeMachine2.dbo.[USER]
 WHERE user_id = @p_userID",
        new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
           cmdLoadID.Parameters.AddWithValue("p_userID", HttpContext.Current.Session["username"].ToString());

           cmdLoadID.Connection.Open();
           SqlDataReader drUser = cmdLoadID.ExecuteReader();
           if (drUser.Read())
           {
              isStudent = Convert.ToInt32(drUser["user_is_student"]);
              isTeacher = Convert.ToInt32(drUser["user_is_teacher"]);
              isEnabled = Convert.ToInt32(drUser["user_is_enabled"]);
           }
           cmdLoadID.Connection.Close();
           if (isStudent == 1 && isEnabled == 1)
           {
              Response.Redirect("studentDash.aspx");
           }
           else if (isTeacher == 1 && isEnabled == 1)
           {
              Response.Redirect("techerDeash.aspx");
           }

           //}

            hdnStudentID.Value = "119355";// Session["Ninja.UserID"].ToString();


        }

        /// <summary>
        /// Redirects to the eventpage, and stores the eventID in a session variable
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdStudentEventsTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["Ninja.eventID"] = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("eventpage.aspx");
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