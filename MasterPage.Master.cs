using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public static class GlobalVar
{
   public const string True  = "1";
   public const string False = "0";
}

namespace ProjectNinja
{
   public partial class MasterPage : System.Web.UI.MasterPage
   {
      protected void Page_Load(object sender, EventArgs e)
      {

      }
   }
}