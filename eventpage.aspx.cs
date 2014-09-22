using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace ProjectNinja
{
    public partial class eventpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //using (SqlConnection thisConnection = new SqlConnection("Server=172.16.212.212;Database=SEI_Ninja;User ID=999999;Password=99999999;Trusted_Connection=True;"))
            //{
            //    thisConnection.Open();

            //    using (SqlCommand thisCommand = thisConnection.CreateCommand())
            //    {
            //        thisCommand.CommandText = "SELECT * FROM [SEI_Ninja].[dbo].[SCHEDULED_USERS] NschedUsers JOIN [SEI_TimeMachine2].[dbo].[USER] TMusers ON TMusers.user_id = NschedUsers.userID JOIN [SEI_Ninja].[dbo].[EVENT_TIMES] Ntime ON NschedUsers.eventTimeID = Ntime.eventTimeID JOIN [SEI_Ninja].[dbo].[EVENT] Nevent ON Nevent.eventID = Ntime.eventID WHERE NschedUsers.userID = 113920;";

            //        using (SqlDataReader thisReader = thisCommand.ExecuteReader())
            //        {
            //            while (thisReader.Read())
            //            {
            //                //MessageBox.Show(thisReader["user_first_name"].ToString());
            //                string display = "Pop-up!";
            //                ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
            //            }
            //        }
            //    }
            //}
            //int rows = 3;
            //int cols = 2;
            //for (int j = 0; j < rows; j++)
            //{
            //    TableRow r = new TableRow();
            //    for (int i = 0; i < cols; i++)
            //    {
            //        TableCell c = new TableCell();
            //        c.Controls.Add(new LiteralControl("row " + j.ToString() + ", cell " + i.ToString()));
            //        r.Cells.Add(c);
            //    }
            //    Table1.Rows.Add(r);
            //}
        }
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //if (_text == null)
            //   _text = "Here is some default text.";
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //needs code here
        }

        protected void EventNameSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }


        




    }
}