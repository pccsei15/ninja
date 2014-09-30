using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja.VersionedCode
{
    public partial class ExportCalendar : System.Web.UI.Page
    {
        private static List<ScheduledAppointment> teacherAppointments = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public static void generateExportedCalendar()
        {
            // Get the duration of each event from the database so that we can draw the calendar correctly
            using (SqlConnection thisConnection = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"))
            {
                thisConnection.Open();

                using (SqlCommand thisCommand = thisConnection.CreateCommand())
                {
                    // MAINTENANCE: Fix this to prevent SQL injection - Thanks!
                    thisCommand.CommandText = @"SELECT ";
                    //thisCommand.CommandText = "SELECT e.eventID, e.eventOwner, e.eventName, e.eventLocation, et.eventDate, e.eventStep, u.user_first_name + ' ' + u.user_last_name AS name FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID) JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id) JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID) WHERE e.eventOwner  = 'mgeary' AND et.eventDate <= DATEADD(DAY, 7, CAST(REPLACE('20140926', '', '') AS DATETIME)) AND et.eventDate >= '20140926' AND e.eventID = " + Request.QueryString["eventId"].ToString() + " ORDER BY e.eventID;";

                    using (SqlDataReader thisReader = thisCommand.ExecuteReader())
                    {
                        while (thisReader.Read())
                        {
                            // Create a list of all of the events that are going to be in the table
                            teacherAppointments.Add(new ScheduledAppointment(int.Parse(thisReader["eventID"].ToString()), thisReader["eventName"].ToString(), thisReader["eventLocation"].ToString(),
                                                    DateTime.Parse(thisReader["eventDate"].ToString()), int.Parse(thisReader["eventStep"].ToString()), thisReader["name"].ToString()));
                        }
                    }
                }
            }

            StringWriter oStringWriter = new StringWriter();
            oStringWriter.WriteLine("Subject,Start Date,Start Time,End Date,End Time,All Day Event,Description,Location,Private");

            for (int i = 0; i < teacherAppointments.Count; i++)
            {
                DateTime date = new DateTime();
                date = teacherAppointments[i].eventDate;
                //oStringWriter.WriteLine("Subject,Start Date,Start Time,End Date,End Time,All Day Event,Description,Location,Private");
                oStringWriter.WriteLine("\"" + teacherAppointments[i].eventName + "\"" + "," +
                                       (date.Date.ToString()).Split(' ').First() + "," +
                                        date.TimeOfDay + "," +
                                       (date.Date.ToString()).Split(' ').First() + "," +
                                        date.AddMinutes(teacherAppointments[i].eventDuration).TimeOfDay + "," +
                                        "False" + "," +
                                        "\"" + teacherAppointments[i].eventUserName + "\"" + "," +
                                        "\"" + teacherAppointments[i].eventLocation + "\"" + "," + "True");

            }

        }

        public class ScheduledAppointment
        {
            private string p1;
            private string p2;
            private string p3;
            private string p4;
            private string p5;
            private object p6;

            public int eventID { get; set; }
            public string eventName { get; set; }
            public string eventLocation { get; set; }
            public DateTime eventDate { get; set; }
            public float eventDuration { get; set; }
            public string eventUserName { get; set; }

            public ScheduledAppointment(int eventIDIn, string eventNameIn, string eventLocationIn, DateTime eventDateIn, float eventDurationIn, string eventUserNameIn)
            {
                eventID       = eventIDIn;
                eventName     = eventNameIn;
                eventLocation = eventLocationIn;
                eventDate     = eventDateIn;
                eventDuration = eventDurationIn;
                eventUserName = eventUserNameIn;
            }

        }
    }
}