using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja.VersionedCode
{
    /**
     *  Parameters to pass by URL:
     *      haveInfo
     *      selectable
     *      startDate
     * */
    public partial class GenerateCalendar : System.Web.UI.Page
    {

        private DateTime getSundayFromDate(DateTime dayOfWeek)
        {
            while (dayOfWeek.DayOfWeek.ToString() != "Sunday")
            {
                // Subtract one day, since even though they have an add days function they don't have a subtract days function. Joy.
                dayOfWeek = dayOfWeek.Subtract(TimeSpan.FromDays(1));
            }
            return dayOfWeek;
        }

        private class eventClass
        {
            public String eventOwner {get; set;}
            public String eventLocation { get; set; }
            public String eventName { get; set; }
            public DateTime eventDate { get; set; }
            public String userName { get; set; }
            public int eventStep { get; set; }
            //String eventTime {get; set; }

            //SQL TIME FORMAT: 2014-09-26 09:00:00

            public eventClass(String eventOwnerIn, String eventLocationIn, String eventNameIn, String eventDateIn, String userNameIn, int eventStepIn)
            {
                eventOwner = eventOwnerIn;
                eventLocation = eventLocationIn;
                eventName = eventNameIn;
                userName = userNameIn;
                eventStep = eventStepIn;

                eventDate = DateTime.Parse(eventDateIn);
            }

            public DateTime getDate()
            {
                return eventDate;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            string[] dayIds = new string[7] {"sunday-header", "monday-header", "tuesday-header", "wednesday-header", "thursday-header", "friday-header", "saturday-header"};
            
            List<eventClass> events = new List<eventClass>();

            string agendaTable = "";
            int duration = 60;
            DateTime startDate;//

            // Just putting these into variables for readability and so we can access them individually in later queries
            int startDay,
                startMonth,
                startYear;

            if (Request.QueryString["startDate"] == null)
            {
                startDate = getSundayFromDate(DateTime.Now);

                startDay = startDate.Day;
                startMonth = startDate.Month;
                startYear = startDate.Year;
            }
            else
            {
                string[] dateParts = Request.QueryString["startDate"].Split('/'); // Input is month[0], day[1], year[2]



                startDay = int.Parse(dateParts[1]);
                startMonth = int.Parse(dateParts[0]);
                startYear = int.Parse(dateParts[2]);

                startDate = new DateTime(startYear, startMonth, startDay);

                if (Request.QueryString["direction"] == "forward")
                {
                    startDate = startDate.AddDays(7);
                }
                else if (Request.QueryString["direction"] == "back")
                {
                    startDate = startDate.AddDays(-7);
                }

                startDay = startDate.Day;
                startMonth = startDate.Month;
                startYear = startDate.Year;

            }

            TimeSpan STARTTIME = new TimeSpan(8, 0, 0);
            TimeSpan ENDTIME   = new TimeSpan(17, 0, 0); // Originally 17
            TimeSpan outputTime = STARTTIME; // This is used in a for loop to draw the times on the side. Start it at STARTTIME.

            int totalMinutesAvailable = (ENDTIME.Hours - STARTTIME.Hours) * 60;

            if (Request.QueryString["eventId"] != null)
            {
                // Get the duration of each event from the database so that we can draw the calendar correctly
                using (SqlConnection thisConnection = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"))
                {
                    thisConnection.Open();

                    using (SqlCommand thisCommand = thisConnection.CreateCommand())
                    {
                        // MAINTENANCE: Fix this to prevent SQL injection - Thanks!
                        thisCommand.CommandText = @"SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate, e.eventStep, e.eventOwner, u.user_first_name + ' ' + u.user_last_name AS name
                             FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
                                  JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
                                  JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id)
                                  JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID)
                            WHERE e.eventOwner = 'mgeary' AND e.eventId = " + Request.QueryString["eventId"] + " AND et.eventDate <= DATEADD(DAY, 7, CAST(REPLACE('" + startYear.ToString("D" + 4) + "" + startMonth.ToString("D" + 2) + "" + startDay.ToString("D" + 2) + "', '', '') AS DATETIME)) AND et.eventDate >= '" + startYear.ToString("D" + 4) + "" + startMonth.ToString("D" + 2) + "" + startDay.ToString("D" + 2) + "' ORDER BY e.eventID";
                        //thisCommand.CommandText = "SELECT e.eventID, e.eventOwner, e.eventName, e.eventLocation, et.eventDate, e.eventStep, u.user_first_name + ' ' + u.user_last_name AS name FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID) JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id) JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID) WHERE e.eventOwner  = 'mgeary' AND et.eventDate <= DATEADD(DAY, 7, CAST(REPLACE('20140926', '', '') AS DATETIME)) AND et.eventDate >= '20140926' AND e.eventID = " + Request.QueryString["eventId"].ToString() + " ORDER BY e.eventID;";

                        using (SqlDataReader thisReader = thisCommand.ExecuteReader())
                        {
                            while (thisReader.Read())
                            {
                                // Get the smallest duration (They will usually all be the same, but just in case)
                                if (duration > int.Parse(thisReader["eventStep"].ToString()))
                                {
                                    duration = int.Parse(thisReader["eventStep"].ToString());
                                }

                                // Create a list of all of the events that are going to be in the table
                                events.Add(new eventClass(thisReader["eventOwner"].ToString(), thisReader["eventLocation"].ToString(), thisReader["eventName"].ToString(), thisReader["eventDate"].ToString(), thisReader["name"].ToString(), int.Parse(thisReader["eventStep"].ToString())));
                            }
                        }
                    }
                }
            }
            // No class ID specified, show all classes
            else
            {
                // Get the duration of each event from the database so that we can draw the calendar correctly
                using (SqlConnection thisConnection = new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"))
                {
                    thisConnection.Open();

                    using (SqlCommand thisCommand = thisConnection.CreateCommand())
                    {
                        thisCommand.CommandText = @"SELECT e.eventID, e.eventName, e.eventLocation, et.eventDate, e.eventStep, e.eventOwner, u.user_first_name + ' ' + u.user_last_name AS name
                             FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su
                                  JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID)
                                  JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id)
                                  JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID)
                            WHERE e.eventOwner = 'mgeary' AND et.eventDate <= DATEADD(DAY, 7, CAST(REPLACE('" + startYear.ToString("D" + 4) + "" + startMonth.ToString("D" + 2) + "" + startDay.ToString("D" + 2) + "', '', '') AS DATETIME)) AND et.eventDate >= '" + startYear.ToString("D" + 4) + "" + startMonth.ToString("D" + 2) + "" + startDay.ToString("D" + 2) + "' ORDER BY e.eventID";
                        //thisCommand.CommandText = "SELECT e.eventID, e.eventOwner, e.eventName, e.eventLocation, et.eventDate, e.eventStep, u.user_first_name + ' ' + u.user_last_name AS name FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su JOIN [SEI_Ninja].[dbo].EVENT_TIMES et ON (su.eventTimeID = et.eventTimeID) JOIN [SEI_TimeMachine2].[dbo].[USER] u ON (su.userID = u.user_id) JOIN [SEI_Ninja].[dbo].EVENT e ON (et.eventID = e.eventID) WHERE e.eventOwner  = 'mgeary' AND et.eventDate <= DATEADD(DAY, 7, CAST(REPLACE('20140926', '', '') AS DATETIME)) AND et.eventDate >= '20140926' AND e.eventID = " + Request.QueryString["eventId"].ToString() + " ORDER BY e.eventID;";

                        using (SqlDataReader thisReader = thisCommand.ExecuteReader())
                        {
                            while (thisReader.Read())
                            {
                                // Get the smallest duration (They will usually all be the same, but just in case)
                                if (duration > int.Parse(thisReader["eventStep"].ToString()))
                                {
                                    duration = int.Parse(thisReader["eventStep"].ToString());
                                }

                                // Create a list of all of the events that are going to be in the table
                                events.Add(new eventClass(thisReader["eventOwner"].ToString(), thisReader["eventLocation"].ToString(), thisReader["eventName"].ToString(), thisReader["eventDate"].ToString(), thisReader["name"].ToString(), int.Parse(thisReader["eventStep"].ToString())));
                            }
                        }
                    }
                }

            }

            startDate = getSundayFromDate(startDate);

            //startDate = new DateTime(startDate.Year, startDate.Month, startDate.Day, 8, 0, 0);

            agendaTable += "<table class='table table-bordered table-responsive table-striped table-hover' style='background:#fff;' id='agendaTable'>";
            agendaTable +=    "<thead>";
            agendaTable +=       "<tr style='background: #428BCA; color: white;'>";

            agendaTable += "<th style='width:12.5%;'>&nbsp;</th>"; // Blank heading because of the event time column being leftmost

            for (int currentDay = 0; currentDay < 7; currentDay++)
            {
                agendaTable += "<th id='" + dayIds[currentDay] + "' style='width:12.5%; text-align: center;'>" + startDate.DayOfWeek + "<br />" + startDate.ToString("M/d/yyyy") + "</th>";
                 
                startDate = startDate.AddDays(1);
            }

            agendaTable +=       "</tr>";
            agendaTable +=    "</thead>";

            int totalSlots = (totalMinutesAvailable / duration);

            // Reset the start date to the actual start date
            startDate = startDate.AddDays(-7);
            //Response.Write(startDate.ToString());
            
            // Add random dates to the events for testing
            /*Random rand = new Random();
            for (int count = 0; count < 10; count++)
            {
                events.Add(new eventClass("Owner", "Location", "Name", new DateTime(DateTime.Now.Year, DateTime.Now.Month, rand.Next(startDate.Day, startDate.Day + 7), rand.Next(8, 17), 0, 0).ToString()));
            }*/
            /*
            foreach(eventClass line in events)
            {
                Response.Write(line.getDate());
            }
            */

            int sundaySkipAmount = 0,
                mondaySkipAmount = 0,
                tuesdaySkipAmount = 0,
                wednesdaySkipAmount = 0,
                thursdaySkipAmount = 0,
                fridaySkipAmount = 0,
                saturdaySkipAmount = 0;

            for (int row = 0; row <= totalSlots; row++)
            {
                agendaTable += "<tr><td>" + DateTime.ParseExact(outputTime.ToString("hh\\:mm"), "HH:mm", null).ToString("h:mm tt") + "</td>";


                // If condition to check if the event exists
                startDate = new DateTime(startDate.Year, startDate.Month, startDate.Day, outputTime.Hours, outputTime.Minutes, outputTime.Seconds);
                int eventIndex;
                
                // Creat the tds for the rest of the row
                for(int dayOffSet = 0; dayOffSet < 7; dayOffSet++)
                {
                    if (dayOffSet == 0 && sundaySkipAmount > 0) // Sunday
                    {
                        sundaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 1 && mondaySkipAmount > 0) // Monday
                    {
                        mondaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 2 && tuesdaySkipAmount > 0) // Tuesday
                    {
                        tuesdaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 3 && wednesdaySkipAmount > 0) // Wednesday
                    {
                        wednesdaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 4 && thursdaySkipAmount > 0) // Thursday
                    {
                        thursdaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 5 && fridaySkipAmount > 0) // Friday
                    {
                        fridaySkipAmount--;
                        continue;
                    }
                    if (dayOffSet == 6 && saturdaySkipAmount > 0) // Saturday
                    {
                        saturdaySkipAmount--;
                        continue;
                    }

                    // Add any attributes to the td
                    agendaTable += "<td";

                    if (Request.QueryString["selectable"] != null)
                    {
                        agendaTable += " onclick=\"toggleSelectedDateTime(this);\" data-dateTime=\"" + startDate.AddDays(dayOffSet).ToString("M/d/yyyy HH:mmtt") + "\"";
                    }


                    // Add information to the td if there is an event for that date
                    eventIndex = events.FindIndex(x => x.getDate().Equals(startDate.AddDays(dayOffSet)));

                    if (eventIndex != -1 && Request.QueryString["haveInfo"] != null)
                    {
                        // This is where I'm at. - Add a rowspan for events that go more than the step
                        if (duration < events[eventIndex].eventStep)
                        {
                            agendaTable += (" rowspan='" + (events[eventIndex].eventStep / duration) + "'");

                            switch (dayOffSet)
                            {
                                case 0: // Sunday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        sundaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 1: // Monday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        mondaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 2: // Tuesday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        tuesdaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 3: // Wednesday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        wednesdaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 4: // Thursday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        thursdaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 5: // Friday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        fridaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                                case 6: // Saturday
                                    if ((events[eventIndex].eventStep / duration) > 0)
                                    {
                                        saturdaySkipAmount = (events[eventIndex].eventStep / duration) - 1;
                                    }
                                    break;
                            }
                        }

                        agendaTable += " class='info' style='border: 2px solid #428BCA;'";

                        agendaTable += ">";

                        // The event is in the list
                        agendaTable += "<strong>" + events[eventIndex].userName + "</strong><br />" + events[eventIndex].eventName + "<br />At " + events[eventIndex].eventLocation;
                    }
                    else
                    {
                        // The event is not in the list
                        agendaTable += ">&nbsp;";
                    }
                    agendaTable += "</td>";
                }
                
                agendaTable += "</tr>";

                // Again, no add minutes functionality? Who even wrote this object?
                outputTime = outputTime.Add(new TimeSpan(0, duration, 0));
            }

            agendaTable += "</table>";

            Response.Write(agendaTable);
        }
    }
}