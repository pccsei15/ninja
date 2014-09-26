using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja
{
    public partial class Calendar : System.Web.UI.Page
    {
        private ScheduledAppointment[] allAppointments = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            GetScheduledAppointments();
            PopulateScheduledAppointments();
        }

        public class ScheduledAppointment
        {
            public int eventID { get; set; }
            public string eventName { get; set; }
            public string eventLocation { get; set; }
            public DateTime eventDate { get; set; }
            public float eventDuration { get; set; }
            public string eventUserName { get; set; }
        }

        public void PopulateScheduledAppointments()
        {
            string jsonScheduledAppointments = JsonConvert.SerializeObject(allAppointments);
            hdnScheduledAppointments.Value = jsonScheduledAppointments;
        }

        public void GetScheduledAppointments()
        {
            var con = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0");



            string sql = @"SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate, et.eventDuration, u.user_first_name + ' ' + u.user_last_name AS name
                             FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
                                  JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
                                  JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id)
                                  JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID)
                            WHERE e.eventOwner = 'mgeary'
                            ORDER BY e.eventID";
            using (var command = new SqlCommand(sql, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    var list = new List<ScheduledAppointment>();
                    while (reader.Read())
                        list.Add(new ScheduledAppointment
                        {
                            eventID = reader.GetInt32(0),
                            eventName = reader.GetString(1),
                            eventLocation = reader.GetString(2),
                            eventDate = reader.GetDateTime(3),
                            eventDuration = (float)reader.GetDouble(4),
                            eventUserName = reader.GetString(5)
                        });
                    allAppointments = list.ToArray();
                }
            }
        }

        protected void btnExportCalendar_Click(object sender, EventArgs e)
        {
            HiddenField hdnScheduledAppointmentsJson = (HiddenField)hdnScheduledAppointments.FindControl("hdnScheduledAppointments");
            String calendarJson = Convert.ToString(hdnScheduledAppointmentsJson.Value);

            JavaScriptSerializer js = new JavaScriptSerializer();
            ScheduledAppointment[] appointments = js.Deserialize<ScheduledAppointment[]>(calendarJson);

            StringWriter oStringWriter = new StringWriter();
            oStringWriter.WriteLine("Subject,Start Date,Start Time,End Date,End Time,All Day Event,Description,Location,Private");

            for (int i = 0; i < appointments.Length; i++)
            {
                DateTime date = new DateTime();
                date = appointments[i].eventDate;
                //oStringWriter.WriteLine("Subject,Start Date,Start Time,End Date,End Time,All Day Event,Description,Location,Private");
                oStringWriter.WriteLine("\"" + appointments[i].eventName + "\"" + "," +
                                       (date.Date.ToString()).Split(' ').First() + "," +
                                        date.TimeOfDay + "," +
                                       (date.Date.ToString()).Split(' ').First() + "," +
                                        date.AddMinutes(appointments[i].eventDuration).TimeOfDay + "," +
                                        "False" + "," +
                                        "\"" + appointments[i].eventUserName + "\"" + "," +
                                        "\"" + appointments[i].eventLocation + "\"" + "," + "True");

            }
            Response.ContentType = "text/plain";
            Response.AddHeader("content-disposition", "attachment;filename=" + string.Format("scheduledEvents-{0}.csv", string.Format("{0:ddMMyyyy}", DateTime.Today)));
            Response.Clear();

            using (StreamWriter writer = new StreamWriter(Response.OutputStream, Encoding.UTF8))
            {
                writer.Write(oStringWriter.ToString());
            }
            Response.End();
        }
    }
}