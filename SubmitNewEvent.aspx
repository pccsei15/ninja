<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubmitNewEvent.aspx.cs" Inherits="ProjectNinja.VersionedCode.SubmitNewEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" method="post">
    <div>
        <form action="#" method="post">
            <input type="text" name="eventName" value="1234567890123456789012345678901234567890" />
            <input type="text" name="eventLocation" value="AC 212" />
            <input type="text" name="eventAttendees[]" value="Class 1" />
            <input type="text" name="dateTimes[]" value="9/23/2014 8:00AM" />
            <input type="text" name="dateTimes[]" value="9/24/2014 9:00PM" />
            <input type="submit" />
        </form>
        <% 
            string error = "";
            
            // Get the event name
            if (Request.Form.GetValues("eventName") != null)
            {
                string eventName = Request.Form["eventName"];
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
                ArrayList eventAttendees = new ArrayList();
                foreach(string value in Request.Form.GetValues("eventAttendees[]"))
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
                string eventName = Request.Form["eventLocation"];
                if (!Regex.IsMatch(eventName, @"^[a-zA-Z0-9 _]{1,255}$"))
                {
                    // Name does not match schema
                    error += "<br />Event location must be 255 characters or less";
                }
            }
            else
            {
                error += "<br />Event location is required";
            }
            
            // Get all the data time componations
            ArrayList dateTimes = new ArrayList();
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
            
            foreach (DateTime tempDateTime in dateTimes)
            {
                Response.Write("<br />" + tempDateTime.ToString("MM-dd-yyyy HH:mm:ss"));
            }
            
            Response.Write(error);

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

            
            // Insert data into the database
            using (System.Data.SqlClient.SqlConnection thisConnection = new System.Data.SqlClient.SqlConnection("Server=172.16.212.212;Database=SEI_Ninja;User ID=sei_timemachine;Password=z5t9l3x0;Trusted_Connection=True;"))
            {
                thisConnection.Open();

                using (System.Data.SqlClient.SqlCommand thisCommand = thisConnection.CreateCommand())
                {
                    //thisCommand.CommandText = "SELECT * FROM [SEI_Ninja].[dbo].[SCHEDULED_USERS] NschedUsers JOIN [SEI_TimeMachine2].[dbo].[USER] TMusers ON TMusers.user_id = NschedUsers.userID JOIN [SEI_Ninja].[dbo].[EVENT_TIMES] Ntime ON NschedUsers.eventTimeID = Ntime.eventTimeID JOIN [SEI_Ninja].[dbo].[EVENT] Nevent ON Nevent.eventID = Ntime.eventID WHERE NschedUsers.userID = 113920;";

                    thisCommand.ExecuteNonQuery();
                    /*using (System.Data.SqlClient.SqlDataReader thisReader = thisCommand.ExecuteReader())
                    {
                        while (thisReader.Read())
                        {
                            MessageBox.Show(thisReader["user_first_name"].ToString());
                        }
                    }*/
                }
            }
            
            // Ridirect when done
            //Response.Redirect("http://www.google.com/");
            
        %>
    </div>
    </form>
</body>
</html>
