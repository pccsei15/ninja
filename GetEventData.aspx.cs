using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace ProjectNinja.VersionedCode
{
    public partial class GetEventData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["classId"] != null)
            {
                SqlCommand cmdLoadID = new SqlCommand(@"
    SELECT et.eventDate, et.eventDuration
      FROM [SEI_Ninja].[dbo].EVENT_TIMES et
     WHERE et.eventID = " + Request.QueryString["classId"] + " AND et.eventTimeID NOT IN (SELECT su.eventTimeID FROM [SEI_Ninja].[dbo].SCHEDULED_USERS su);",
               new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));

                cmdLoadID.Connection.Open();
                SqlDataReader drUser = cmdLoadID.ExecuteReader();

                ArrayList list = new ArrayList();
                while (drUser.Read())
                {
                    //Response.Write(drUser["eventDate"].ToString() + drUser["eventDuration"].ToString());
                    list.Add("\"eventDate\":\"" + drUser["eventDate"].ToString() + "\",\"eventDuration\":\"" + drUser["eventDuration"].ToString() + "\"");
                }
                cmdLoadID.Connection.Close();

                string allDateTimes = "";
                foreach (string line in list)
                {
                    if (allDateTimes != "")
                    {
                        allDateTimes += ",";
                    }
                    allDateTimes += "{" + line + "}";
                    //Response.Write("<br />" + line);
                }

                allDateTimes = "{\"dateTimes\":[" + allDateTimes + "]}";
                Response.Write(allDateTimes);
            }
        }
    }
}