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
        <div class="col-md-3"  > 
          <div class="datepicker datepicker-inline" id="eventDate"></div>
        </div> <!-- end datapicker -->

        <%--<div class="col-md-3"> 
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="eventName" DataValueField="eventName"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventName] FROM [EVENT]"></asp:SqlDataSource>
        </div>--%>
        <%--<div class="col-md-3"> 
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="eventTime" DataValueField="eventTime"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventTime] FROM [EVENT]"></asp:SqlDataSource>
        </div>--%>
        
        <div class="col-md-9">
            <div class="row">
      <div class="col-sm-12 col-md-12 main">
         <div class="table-responsive">
            <asp:GridView ID="gridview1" runat="server" CssClass="table table-striped table-hover table-responsive" GridLines="None" AutoGenerateColumns="False" 
               DataSourceID="sqlEvents" DataKeyNames="eventID"  >
               <Columns>
                   <asp:TemplateField HeaderText="Event Name" SortExpression="eventName">
                       <ItemTemplate>
                           <%--<asp:LinkButton ID="lblEditName" runat="server" Text='<%# Bind("eventName") %>' CommandArgument='<%# Bind("eventID") %>' OnClick="lnkEvent_Click"></asp:LinkButton>--%>
                       </ItemTemplate>
                   </asp:TemplateField>
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
					         <asp:LinkButton id="btnDelete" runat="server" commandname="DeleteEvent" text="Delete" CssClass="btn btn-default btn-danger" CommandArgument='<%# Eval("eventID") %>'>
                                 <i aria-hidden="true" class="glyphicon glyphicon-trash"></i> Delete
                             </asp:LinkButton>
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
      </div>
    </div>
</asp:content>
