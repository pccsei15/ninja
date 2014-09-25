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

            if (Session["Ninja.eventID"] != null)
            {
                DropDownList1.SelectedValue = Session["Ninja.eventID"].ToString();
            }
        }

        public class ScheduledAppointment
        {
            public int        eventID       { get; set; }
            public string     eventName     { get; set; }
            public string     eventLocation { get; set; }
            public DateTime   eventDate     { get; set; }
            public float      eventDuration { get; set; }
            public string     eventUserName { get; set; }
            public int        eventTimeID   { get; set; }
        }

        public void PopulateScheduledAppointments()
        {
            string jsonScheduledAppointments = JsonConvert.SerializeObject(allAppointments);

            hdnScheduledAppointments.Value = jsonScheduledAppointments;
        }

        public void GetScheduledAppointments()
        {
            var con = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True");



            string sql = @"SELECT et.eventDate, et.eventTimeID
                             FROM [SEI_Ninja].[dbo].EVENT_TIMES et
                            WHERE et.eventID = 7
                              AND et.eventTimeID NOT IN (SELECT su.eventTimeID
							 FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su);";
            using (var command = new SqlCommand(sql, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    var list = new List<ScheduledAppointment>();
                    while (reader.Read())
                        list.Add(new ScheduledAppointment { eventDate     = reader.GetDateTime(0),
                                                            eventTimeID   = reader.GetInt32(1)});
                    allAppointments = list.ToArray();
                }
            }
        }
    }

        




    }
