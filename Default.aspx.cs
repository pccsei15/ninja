﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectNinja.VersionedCode
{
   public partial class Default : System.Web.UI.Page
   {
      protected void Page_Load(object sender, EventArgs e)
      {
         //Veriables 
         int    isStudent = 0,
                isTeacher = 0,
                isEnabled = 0;
         string current_login_id,
                current_user_id;

                   //Get the user name
                   if (HttpContext.Current.Session["username"] == null)
                   {
                      current_login_id = HttpContext.Current.User.Identity.Name;
                      current_user_id  = current_login_id.Substring(current_login_id.LastIndexOf('\\') + 1);
                      HttpContext.Current.Session["username"] = current_user_id;
                   }

                   //Prepare the DB for selecting access levels.
                   SqlCommand cmdLoadID = new SqlCommand(@"
          SELECT user_is_enabled, user_is_student, user_is_teacher
            FROM SEI_TimeMachine2.dbo.[USER]
           WHERE user_id = @p_userID",
                new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
                   cmdLoadID.Parameters.AddWithValue("p_userID", HttpContext.Current.Session["username"].ToString());

                   //Run the select command and retirve the data from the DB
                   cmdLoadID.Connection.Open();
                   SqlDataReader drUser = cmdLoadID.ExecuteReader();
                   if (drUser.Read())
                   {
                      isStudent = Convert.ToInt32(drUser["user_is_student"]);
                      isTeacher = Convert.ToInt32(drUser["user_is_teacher"]);
                      isEnabled = Convert.ToInt32(drUser["user_is_enabled"]);
                   }
                   cmdLoadID.Connection.Close();

                   //Set the access level session veriables.
                   Session["Ninja.isStudent"] = isStudent;
                   Session["Ninja.isTeacher"] = isTeacher;
                   Session["Ninja.isEnabled"] = isEnabled;

          //Please remove me.
          if( HttpContext.Current.Session["username"] == "115339")
          {
             SqlCommand cmdJoe = new SqlCommand(@"
SELECT user_is_enabled, user_is_student, user_is_teacher
  FROM SEI_TimeMachine2.dbo.[USER]
 WHERE user_id = @p_userID",
             new SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));
             cmdLoadID.Parameters.AddWithValue("p_userID", "mgeary");

             //Run the select command and retirve the data from the DB
             cmdJoe.Connection.Open();
             SqlDataReader drJoe = cmdJoe.ExecuteReader();
             if (drUser.Read())
             {
                isStudent = Convert.ToInt32(drUser["user_is_student"]);
                isTeacher = Convert.ToInt32(drUser["user_is_teacher"]);
                isEnabled = Convert.ToInt32(drUser["user_is_enabled"]);
             }
             cmdJoe.Connection.Close();
          }

                   //Direct to the correct dashpage based on access levels.
                   if (isStudent == int.Parse(GlobalVar.True) && isEnabled == int.Parse(GlobalVar.True))
                   {
                      Response.Redirect("studentDash.aspx");
                   }
                   else if (isTeacher == int.Parse(GlobalVar.True) && isEnabled == int.Parse(GlobalVar.True))
                   {
                      Response.Redirect("teacherDash.aspx");
                   }
      }
   }
}