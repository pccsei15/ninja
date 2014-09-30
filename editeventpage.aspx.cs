using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ProjectNinja.VersionedCode
{
    public partial class EditEventPage1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string error = "";
            string eventLocation = "";
            string eventName = "";
            ArrayList eventAttendees = new ArrayList();
            ArrayList dateTimes = new ArrayList();
            int lastID = -1;
            int eventDuration = -1;
            //hdnEventID.Value = Request.QueryString["eventID"];
            //Session["Ninja.eventID"] = Request.QueryString["eventID"];
            String eventID = Session["Ninja.eventID"].ToString();
            



            // Get the event name
            if (Request.Form.GetValues("eventName") != null)
            {
                eventName = Request.Form["eventName"];
                if (!Regex.IsMatch(eventName, @"^[a-zA-Z0-9 _]{1,255}$"))
                {
                    // Name does not match schema
                    error += "<br />Event name must be 255 characters or less";
                }
            }
            else
            {
                error += "<br />Event name is required";
            }

            // Get all attendees
            if (Request.Form.GetValues("eventAttendees[]") != null)
            {
                foreach (string value in Request.Form.GetValues("eventAttendees[]"))
                {
                    // Params does post and get
                    //Response.Write(value + "<br />");
                    if (Regex.IsMatch(value, @"^[a-zA-Z0-9 _]{1,255}$"))
                    {
                        eventAttendees.Add(value);
                    }
                    else
                    {
                        // Name does not match schema
                        error += "<br />Attendees can only have letters and numbers in their name";
                    }
                }
            }
            else
            {
                error += "<br />Must have at least 1 attendee";
            }

            // Get the event location
            if (Request.Form.GetValues("eventLocation") != null)
            {
                eventLocation = Request.Form["eventLocation"];
                if (!Regex.IsMatch(eventLocation, @"^[a-zA-Z0-9 _]{1,255}$"))
                {
                    // Name does not match schema
                    error += "<br />Event location must be 255 characters or less";
                }
            }
            else
            {
                error += "<br />Event location is required";
            }

            // Get the event duration
            if (Request.Form.GetValues("eventTime") != null)
            {
                if (!int.TryParse(Request.Form["eventTime"], out eventDuration) || (eventDuration % 15) != 0)
                {
                    // Name does not match schema
                    error += "<br />event duration must a multiple of 15";
                }
            }
            else
            {
                error += "<br />Event duration is required";
            }

            // Get all the data time componations
            if (Request.Form.GetValues("dateTimes[]") != null)
            {
                DateTime dateValue;
                foreach (string value in Request.Form.GetValues("dateTimes[]"))
                {
                    // Params does post and get
                    //Response.Write(value + "<br />");
                    if (DateTime.TryParse(value, out dateValue))
                    {
                        dateTimes.Add(dateValue);
                    }
                    else
                    {
                        error += "<br />" + value + " is not in the correct date time format";
                    }
                }
            }
            else
            {
                error += "<br />You must have at least 1 date and time";
            }

            //Response.Write(error);

            //sql validation
            //http://msdn.microsoft.com/en-us/library/ff648339.aspx

            /*
            // General loop though all post variables
            foreach(string key in Request.Form.Keys)
            {
                // Params does post and get
                Response.Write(key + ": " + Request.Params[key] + "<br />");
            }
            */

            if (error.Length == 0)
            {
                Response.Write(eventID);
                // Insert data into the database
                using (System.Data.SqlClient.SqlConnection thisConnection = new System.Data.SqlClient.SqlConnection("Server=172.16.212.212;Database=SEI_Ninja;User ID=sei_timemachine;Password=z5t9l3x0;"))
                {
                    thisConnection.Open();

                    using (System.Data.SqlClient.SqlCommand thisCommand = thisConnection.CreateCommand())
                    {
                        // Insert an event into the event table
                        thisCommand.CommandText = "UPDATE [SEI_Ninja].[dbo].[EVENT] SET eventLocation ='" + eventLocation + "', eventOwner = 'mgeary', eventName = '" + eventName + "', eventStep = " + eventDuration + " WHERE eventID = " + eventID;
                        // Add and get the id of the event that is being added
                        thisCommand.ExecuteNonQuery();
                        //Response.Write("<br />The last key was:" + lastId);

                        // Add the classes for this event to the EVENT_COURSES table
                        /*foreach (object attendee in eventAttendees)
                        {
                            thisCommand.CommandText = "INSERT INTO [SEI_Ninja].[dbo].[EVENT_COURSES] (courseID, eventID) VALUES('" + attendee.ToString() + "', '" + lastID + "')";
                            thisCommand.ExecuteNonQuery();
                        }

                        // Add the times for this event into EVENT_TIMES table
                        foreach (DateTime dateTime in dateTimes)
                        {
                            thisCommand.CommandText = "INSERT INTO [SEI_Ninja].[dbo].[EVENT_TIMES] (eventID,  eventDate) VALUES('" + lastID + "', '" + dateTime.ToString("yyyy-MM-dd HH:mm:ss") + "')";
                            thisCommand.ExecuteNonQuery();
                            //Response.Write("<br />" + dateTime.ToString("yyyy-MM-dd HH:mm:ss"));
                        }*/

                        // Ridirect when done
                        Response.Redirect("TeacherDash.aspx");
                    }
                }
            } // End checking for if the error is set

        }
    }

}