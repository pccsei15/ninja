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
        /*private Info[]      info = null;
        private Timeslots[] timeslots = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            GetInfo();
            GetTimeslots();
            PopulateScheduledAppointments();
            
        }

        public class Info
        {
            public int courseID { get; set; }
            public string eventLocation { get; set; }
            public string eventName { get; set; }
        }

        public class Timeslots
        {
            public int eventTimeID { get; set; }
            public DateTime eventDate { get; set; }
        }

        public void PopulateScheduledAppointments()
        {
            string jsonInfo = JsonConvert.SerializeObject(info);
            string jsonTimeslots = JsonConvert.SerializeObject(timeslots);

            eventInfo.Value = jsonInfo;
            eventTimeslots.Value = jsonTimeslots;

        }

        public void GetInfo()
        {
            var con = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0");



            string sql1 = @"SELECT ec.courseID, e.eventLocation, e.eventName
                            FROM [SEI_Ninja].[dbo].EVENT e
                            JOIN [SEI_Ninja].[dbo].EVENT_COURSES ec ON (e.eventID = ec.eventID)
                            WHERE ec.eventID = 5;";
            //" + (String)Session["Ninja.eventID"] + "

            using (var command = new SqlCommand(sql1, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    var list = new List<Info>();
                    while (reader.Read())
                        list.Add(new Info
                        {
                            courseID = reader.GetInt32(0),
                            eventLocation = reader.GetString(1),
                            eventName = reader.GetString(2)
                        });
                    info = list.ToArray();
                }
                con.Close();
            }
        }

        public void GetTimeslots()
        {
            var con = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0");



            //" + (String)Session["Ninja.eventID"] + "
            string sql2 = @"SELECT et.eventDate, et.eventTimeID
                            FROM [SEI_Ninja].[dbo].EVENT_TIMES et
                            WHERE et.eventID = 5 AND et.eventTimeID NOT IN (SELECT su.eventTimeID FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su);";

            using (var command = new SqlCommand(sql2, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    var list = new List<Timeslots>();
                    while (reader.Read())
                        list.Add(new Timeslots
                        {
                            eventDate = reader.GetDateTime(0),
                            eventTimeID = reader.GetInt32(1)
                        });
                    timeslots = list.ToArray();
                }
                con.Close();
            }
        }*/

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand cmdLoadID = new SqlCommand(@"
SELECT e.eventLocation, e.eventName 
                            FROM [SEI_Ninja].[dbo].EVENT e
                            WHERE e.eventID = @p_userID;",
      new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdLoadID.Parameters.AddWithValue("p_userID", 5);//Session["Ninja.eventID"].ToString());

            cmdLoadID.Connection.Open();
            SqlDataReader drUser = cmdLoadID.ExecuteReader();
            if (drUser.Read())
            {
                txteventLocation.Text = Convert.ToString(drUser["eventLocation"]);
                txteventName.Text = Convert.ToString(drUser["eventName"]);
            }
            cmdLoadID.Connection.Close();
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            SqlCommand cmdLoadID = new SqlCommand(@"
                UPDATE [SEI_Ninja].[dbo].EVENT 
                SET eventName='@p_eventName', eventLocation='@p_eventLocation' 
                WHERE eventID='@p_eventID'",
        new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
            cmdLoadID.Parameters.AddWithValue("p_userID", 5);
            cmdLoadID.Parameters.AddWithValue("p_eventName", txteventName.Text);
            cmdLoadID.Parameters.AddWithValue("p_eventLocation", txteventLocation.Text);
            cmdLoadID.Parameters.AddWithValue("p_eventTime", ddleventTime.SelectedValue);

            cmdLoadID.Connection.Open();
        }
    }

}