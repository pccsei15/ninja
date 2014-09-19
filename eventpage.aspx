<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="eventpage.aspx.cs" Inherits="ProjectNinja.eventpage" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="teacherdash.html">Project Ninja</a>
        </div>
      </div>
    </div>

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
          <div class=" datepicker datepicker-inline" id="eventDate">
              
            </div>
        </div> <!-- end datapicker -->
        <div class="col-md-9">
            <asp:GridView ID="eventTimesGV" runat="server" AllowSorting="True" CssClass="table table-bordered table-responsive" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataSourceID="SqlDataSource1" Width="855px">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        </div>
      </div>

      <div class="row">
        
      </div>
    </div>

   
    
</asp:Content>
