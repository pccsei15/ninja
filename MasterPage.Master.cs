using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ProjectNinja
{
   public partial class MasterPage : System.Web.UI.MasterPage
   {
      protected void Page_Load(object sender, EventArgs e)
      {
         Page.ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script     language=JavaScript>alert('Testing');</script>");

          int isStudent = 0,
              isTeacher = 0,
              isEnabled = 0;
          string current_login_id,
                 current_user_id;

          //if (HttpContext.Current.Session["username"] == null)
          //{

      
              current_login_id = HttpContext.Current.User.Identity.Name;
              current_user_id = current_login_id.Substring(current_login_id.LastIndexOf('\\') + 1);
              HttpContext.Current.Session["username"] = 100;//current_user_id;

              SqlCommand cmdLoadID = new SqlCommand(@"
SELECT user_is_enabled, user_is_student, user_is_teacher
  FROM SEI_TimeMachine2.dbo.[USER]
 WHERE user_id = @p_userID",
           new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
              cmdLoadID.Parameters.AddWithValue("p_userID", HttpContext.Current.Session["username"].ToString());

              cmdLoadID.Connection.Open();
              SqlDataReader drUser = cmdLoadID.ExecuteReader();
              if (drUser.Read())
              {
                  isStudent = Convert.ToInt32(drUser["user_is_student"]);
                  isTeacher = Convert.ToInt32(drUser["user_is_teacher"]);
                  isEnabled = Convert.ToInt32(drUser["user_is_enabled"]);
              }

              Page.ClientScript.RegisterStartupScript(this.GetType(), "clientScript", "<script     language=JavaScript>alert('" + " " + isStudent + " " + " " + isTeacher + " " + " " + isEnabled + " " + HttpContext.Current.Session["username"].ToString() + "');</script>");

              if (isStudent == 1 && isEnabled == 1)
              {
                  //Response.Redirect("studentDash.aspx");
              }
              else if (isTeacher == 1 && isEnabled == 1)
              {
                  //Response.Redirect("teacherDash.aspx");
              }

          //}
      }
   }
}