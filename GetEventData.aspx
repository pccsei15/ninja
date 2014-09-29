<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetEventData.aspx.cs" Inherits="ProjectNinja.VersionedCode.GetEventData" %>

<%
                           System.Data.SqlClient.SqlCommand cmdLoadID = new System.Data.SqlClient.SqlCommand(@"
                                            SELECT eventLocation, eventOwner, eventStep, eventName
                                             FROM [SEI_Ninja].[dbo].[EVENT]",
                            new System.Data.SqlClient.SqlConnection("Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0"));

                           cmdLoadID.Connection.Open();
                           System.Data.SqlClient.SqlDataReader drUser = cmdLoadID.ExecuteReader();

                           while (drUser.Read())
                           {
                               Response.Write("location: " + drUser["eventLocation"].ToString() + " owner: " + drUser["eventOwner"].ToString() + " step: " + drUser["eventStep"].ToString() + " name: " + drUser["eventName"].ToString() +  "<br />");
                           }
                            
                           cmdLoadID.Connection.Close();
                            %>