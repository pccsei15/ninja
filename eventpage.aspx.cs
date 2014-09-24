using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Newtonsoft.Json;

namespace ProjectNinja
{
    public partial class eventpage : System.Web.UI.Page
    {
        private ScheduledAppointment[] allAppointments = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            GetScheduledAppointments();
            PopulateScheduledAppointments();
        }

        public class ScheduledAppointment
        {
            public int      eventID       { get; set; }
            public string   eventName     { get; set; }
            public string   eventLocation { get; set; }
            public DateTime   eventDate     { get; set; }
            public float    eventDuration { get; set; }
            public string   eventUserName { get; set; }
        }

        public void PopulateScheduledAppointments()
        {
            string jsonScheduledAppointments = JsonConvert.SerializeObject(allAppointments);

            hdnScheduledAppointments.Value = jsonScheduledAppointments;
        }

        public void GetScheduledAppointments()
        {
            var con = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True");



            string sql = @"SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate, et.eventDuration, u.user_first_name + ' ' + u.user_last_name AS name
                             FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
                                  JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
                                  JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id)
                                  JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID)
                            WHERE e.eventOwner = 'mgeary'";
            using (var command = new SqlCommand(sql, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    var list = new List<ScheduledAppointment>();
                    while (reader.Read())
                        list.Add(new ScheduledAppointment { eventID = reader.GetInt32(0), eventName = reader.GetString(1), eventLocation = reader.GetString(2),
                                                            eventDate = reader.GetDateTime(3), eventDuration = (float)reader.GetDouble(4), eventUserName = reader.GetString(5) });
                    allAppointments = list.ToArray();
                }
            }
        }
    }

        




    }
