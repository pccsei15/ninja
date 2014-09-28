using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ProjectNinja.VersionedCode
{
    public partial class EditEventPage1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlCommand cmdLoadID = new SqlCommand(@"
                    SELECT e.eventLocation, e.eventName, e.eventStep 
                      FROM [SEI_Ninja].[dbo].EVENT e
                     WHERE e.eventID = @p_eventID;",
            new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
                cmdLoadID.Parameters.AddWithValue("p_eventID", 5);

                cmdLoadID.Connection.Open();
                SqlDataReader drUser = cmdLoadID.ExecuteReader();
                if (drUser.Read())
                {
                    txteventLocation.Text = Convert.ToString(drUser["eventLocation"]);
                    txteventName.Text = Convert.ToString(drUser["eventName"]);
                    ddleventTime.Items.FindByText(Convert.ToString(drUser["eventStep"])).Selected = true;                    
                }
                cmdLoadID.Connection.Close();

                SqlCommand cmdLoadList = new SqlCommand(@"
                    SELECT [course_id], [course_name]
                    FROM [SEI_TimeMachine2].[dbo].[COURSE]
                   WHERE course_end_date >= SYSDATETIME()",
            new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));

                cmdLoadList.Connection.Open();
                SqlDataReader drUser2 = cmdLoadList.ExecuteReader();
                while (drUser2.Read())
                {
                    ListItem classList = new ListItem();
                    classList.Text = Convert.ToString(drUser2["course_name"]);
                    classList.Value = Convert.ToString(drUser2["course_id"]);
                    cblAttendees.Items.Add(classList);
                }

                SqlCommand cmdLoadID2 = new SqlCommand(@"
                          SELECT c.course_name
                            FROM [SEI_Ninja].[dbo].EVENT_COURSES ec
                                 JOIN [SEI_TimeMachine2].[dbo].COURSE c ON (ec.courseID = c.course_id)
                           WHERE ec.eventID = @p_eventID;",
            new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
                cmdLoadID2.Parameters.AddWithValue("p_eventID", 5);//Session["Ninja.eventID"].ToString());

                cmdLoadID2.Connection.Open();
                SqlDataReader drUser3 = cmdLoadID2.ExecuteReader();
                if (drUser3.Read())
                {
                    for (int i = 0; i < cblAttendees.Items.Count; i++)
                    {
                        if (cblAttendees.Items[i].Text == Convert.ToString(drUser3["course_name"])) 
                            cblAttendees.Items[i].Selected = true;
                    }
                
                }
                cmdLoadID2.Connection.Close();

            }
        }

        protected void submit_Click (object sender, EventArgs e)
        {
            SqlCommand cmdLoadID1 = new SqlCommand(@"
                UPDATE [SEI_Ninja].[dbo].EVENT 
                   SET eventName = @p_eventName, eventLocation = @p_eventLocation, eventStep = @p_eventStep
                 WHERE eventID = @p_eventID;",
                 new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdLoadID1.Parameters.AddWithValue("p_eventID", 5);
            cmdLoadID1.Parameters.AddWithValue("p_eventName", txteventName.Text);
            cmdLoadID1.Parameters.AddWithValue("p_eventLocation", txteventLocation.Text);
            cmdLoadID1.Parameters.AddWithValue("p_eventStep", ddleventTime.SelectedItem.Text);

            cmdLoadID1.Connection.Open();
            cmdLoadID1.ExecuteNonQuery();
            cmdLoadID1.Connection.Close();


            SqlCommand cmdLoadID = new SqlCommand(@"
                    SELECT e.eventLocation, e.eventName 
                      FROM [SEI_Ninja].[dbo].EVENT e
                     WHERE e.eventID = @p_eventID;",
                     new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdLoadID.Parameters.AddWithValue("p_eventID", 5);//Session["Ninja.eventID"].ToString());

            cmdLoadID.Connection.Open();
            SqlDataReader drUser = cmdLoadID.ExecuteReader();
            if (drUser.Read())
            {
                txteventLocation.Text = Convert.ToString(drUser["eventLocation"]);
                txteventName.Text     = Convert.ToString(drUser["eventName"]);
            }
            cmdLoadID.Connection.Close();


        }
    }

}