<%@ Page Title="Teacher Dashboard" Language="C#" MasterPageFile="./MasterPage.Master" AutoEventWireup="true" CodeBehind="TeacherDash.aspx.cs" Inherits="ProjectNinja.teacherdash" %>
<asp:Content ID="PageTitle" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Teacher Dashboard</title>
    <!-- Glenn and Dory's Page -->
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="mainContent" runat="server">
   <form runat="server">
            <asp:HiddenField ID="hdnRowID" runat="server" />

            <div class="row">
                <div class="col-md-6">
                    <h1>Teacher Dashboard</h1>
                </div>
                <div class="col-md-6">
                    <a href="neweventpage.aspx" class="btn btn-primary pull-right" style="margin-top:28px;">Create Event</a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12 col-md-12 main" style="margin-top: 20px;">
                    <div class="table-responsive">
                    <asp:GridView ID="grdEventsTable" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
                        DataSourceID="sqlEvents" DataKeyNames="eventID" onrowcommand="grdEventsTable_RowCommand" OnPreRender="grdEventsTable_PreRender">
                        <Columns>
                            <asp:BoundField DataField="eventName" HeaderText="Event Name" SortExpression="eventName" >
                            </asp:BoundField>
                            <asp:BoundField DataField="eventLocation" HeaderText="Event Location" SortExpression="eventLocation">
                            </asp:BoundField>
                            <asp:BoundField DataField="beginDate" HeaderText="Begin Date" SortExpression="beginDate" DataFormatString="{0:f}" >
                            </asp:BoundField>
                            <asp:BoundField DataField="endDate" HeaderText="End Date" SortExpression="endDate" DataFormatString="{0:f}" >
                            </asp:BoundField>
                            <asp:BoundField DataField="attendees" HeaderText="Attendees" SortExpression="attendees" >
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Action">
				                <itemtemplate>
                                   <div class="btn-group btn-group-sm">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEvent" CssClass="btn btn-default" CommandArgument='<%# Eval("eventID") %>' >
                                            <i aria-hidden="true" class="glyphicon glyphicon-pencil"></i>
                                        </asp:LinkButton>
					                    <asp:LinkButton id="btnDelete" runat="server" commandname="DeleteEvent" CssClass="btn btn-default btn-danger" CommandArgument='<%# Eval("eventID") %>'>
                                            <i aria-hidden="true" class="glyphicon glyphicon-trash"></i>
                                        </asp:LinkButton>
                                   </div>
				                </itemtemplate>
                       
			                </asp:TemplateField>
                  
                        </Columns>
                        <RowStyle CssClass="rowStyle" />
                        <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="White" CssClass="headerStyle" />
                        <FooterStyle CssClass="footerStyle" />
                    </asp:GridView>
                    </div>
                </div>
            </div>
            <asp:SqlDataSource ID="sqlEvents" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Persist Security Info=True;UID=sei_timemachine;PWD=z5t9l3x0" ProviderName="System.Data.SqlClient" SelectCommand="
            SELECT DISTINCT ev.eventID, eventName, eventLocation, MIN(ev_ti.eventDate) AS beginDate, MAX(ev_ti.eventDate) AS endDate,  ev.eventOwner,
                ( SELECT COUNT(DISTINCT scheduledUserID)
                    FROM SEI_Ninja.dbo.SCHEDULED_USERS su
                        JOIN SEI_Ninja.dbo.EVENT_TIMES et_prev ON (su.eventTimeID = et_prev.eventTimeID)
                    WHERE et_prev.eventID = ev.eventID) AS attendees
            FROM SEI_Ninja.dbo.[EVENT] ev
                LEFT OUTER JOIN SEI_Ninja.dbo.EVENT_TIMES ev_ti ON (ev.eventID = ev_ti.eventID)
            WHERE ev.eventOwner = @p_User
            GROUP BY eventName, eventLocation, ev.eventID,  ev.eventOwner;" CancelSelectOnNullParameter="False"  UpdateCommand="
            UPDATE SEI_Ninja.dbo.[EVENT]
            SET eventName = @eventName
            WHERE eventID   = @eventID" DeleteCommand="
            DELETE FROM event
                WHERE eventID = @eventID">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="hdnRowID" DefaultValue="0" Name="eventID" PropertyName="Value" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hdnRowID" Name="p_User" PropertyName="Value" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="hdnName" Name="eventName" PropertyName="Value" />
                    <asp:ControlParameter ControlID="hdnID" Name="eventID" PropertyName="Value" />
                </UpdateParameters>
            </asp:SqlDataSource>
   </form>
</asp:Content>
