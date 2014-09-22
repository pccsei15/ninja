<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="eventpage.aspx.cs" Inherits="ProjectNinja.eventpage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                    
                
    <div class="container-fluid">
      <div class="row">
        <ol class="breadcrumb" style="margin-bottom: 0;">
          <li><a href="teacherdash.html">Dashboard</a></li>
          <li class="active">First Interviews</li>
        </ol>
      </div>

      <div class="row">
        <div class="col-sm-6 col-md-6 main">
          <h1>First Interviews</h1>
        </div>
      </div>
      
      <div class="row">
       
        <%--<div class="col-md-3"> 
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="eventTime" DataValueField="eventTime"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventDate] FROM [EVENT_TIMES]"></asp:SqlDataSource>
        </div>--%>
        <div class="col-md-3">
            <asp:DropDownList ID="EventNameSelect" runat="server" DataSourceID="sqlSelectEvent" DataTextField="eventName" DataValueField="eventName">

            </asp:DropDownList>
            <asp:SqlDataSource ID="sqlSelectEvent" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventName] FROM [EVENT]"></asp:SqlDataSource>
        </div>
        <div class="col-md-10">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="sqlEventpage" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged2" CssClass="table table-striped table-hover table-responsive" GridLines="None">
                    <Columns>
                   <asp:BoundField DataField="eventName" HeaderText="eventName" SortExpression="eventName">
                   </asp:BoundField>
                   <asp:BoundField DataField="eventLocation" HeaderText="eventLocation" SortExpression="eventLocation" >
                   </asp:BoundField>
                   <asp:BoundField DataField="beginDate" HeaderText="beginDate" SortExpression="beginDate" ReadOnly="True" >
                   </asp:BoundField>
                   <asp:BoundField DataField="endDate" HeaderText="endDate" SortExpression="endDate" ReadOnly="True" >
                   </asp:BoundField>
                   <asp:BoundField DataField="attendees" HeaderText="attendees" ReadOnly="True" SortExpression="attendees" />
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
					         <asp:button id="btnSignUp" runat="server" commandname="SignUpEvent" text="Sign Up" CssClass="btn btn-default btn-primary" CommandArgument='<%# Eval("eventID") %>' />
				       </itemtemplate>
			           
			       </asp:TemplateField>
                  
               </Columns>
                    <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="black" />
                </asp:GridView>
                <%--<asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>--%>
                <asp:SqlDataSource ID="sqlEventpage" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="
                    SELECT ev.eventID, eventName, eventLocation, MIN(ev_ti.eventDate) AS beginDate, MAX(ev_ti.eventDate) AS endDate,
                           ( SELECT COUNT(DISTINCT scheduledUserID)
                               FROM SEI_Ninja.dbo.SCHEDULED_USERS su
                              WHERE su.eventTimeID = ev_ti.eventTimeID ) AS attendees
                      FROM SEI_Ninja.dbo.[EVENT] ev
                           LEFT OUTER JOIN SEI_Ninja.dbo.EVENT_TIMES ev_ti ON (ev.eventID = ev_ti.eventID)
                     GROUP BY ev.eventID, eventName, eventLocation, eventTimeID
                     ORDER BY eventName;" CancelSelectOnNullParameter="False"  UpdateCommand="
                    UPDATE SEI_Ninja.dbo.[EVENT]
                       SET eventName = @eventName
                     WHERE eventID   = @eventID" DeleteCommand="
                    DELETE FROM event
                         WHERE eventID = @eventID">
                  <DeleteParameters>
                      <asp:ControlParameter ControlID="hdnRowID" DefaultValue="0" Name="eventID" PropertyName="Value" Type="Int32" />
                  </DeleteParameters>
                  <UpdateParameters>
                      <asp:ControlParameter ControlID="hdnName" Name="eventName" PropertyName="Value" />
                      <asp:ControlParameter ControlID="hdnID" Name="eventID" PropertyName="Value" />
                  </UpdateParameters>
               </asp:SqlDataSource>
        </div>
      </div>
     </div>
    </div>
</asp:content>
