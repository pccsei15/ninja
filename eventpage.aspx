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
            <asp:Table ID="Table1" runat="server" CssClass="table table-bordered table-responsive">
            </asp:Table>
        </div>
      </div>
    </div>
</asp:content>
