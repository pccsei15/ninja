<%@ Page Title="Sign up" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="eventpage.aspx.cs" Inherits="ProjectNinja.eventpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="pageTitle" runat="server">
    <title>Sign up</title>
</asp:content>

<asp:Content ID="BreadCrumb" ContentPlaceHolderID="breadCrumb" runat="server">
    <li class="active">Sign Up</li>
</asp:content>

<asp:Content ID="Content" ContentPlaceHolderID="mainContent" runat="server">

      <div class="row">
        <div class="col-sm-6 col-md-6 main">
          <h1>First Interviews</h1>
        </div>
      </div>
      
      <div class="row">

        <div class="col-md-3">
            <%--<asp:DropDownList ID="EventNameSelect" runat="server" DataSourceID="sqlSelectEvent" DataTextField="eventName" DataValueField="eventID" OnSelectedIndexChanged="EventNameSelect_SelectedIndexChanged" AutoPostBack="True">

            </asp:DropDownList>
            <asp:SqlDataSource ID="sqlSelectEvent" runat="server" ConnectionString="<%$ ConnectionStrings:SEI_NinjaConnectionString %>" SelectCommand="SELECT [eventName], eventID FROM [EVENT]"></asp:SqlDataSource>
        --%>
            <div id="eventDate" onclick="generateAgendaTable();"></div>
            
        </div>
        </div>

        <div class="col-md-9" id="agendaTableHolder">
      </div><!-- end agendaTableHolder -->
      <%--  <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="sqlEventpage" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-responsive" GridLines="None" >
                    <Columns>
                   <asp:BoundField DataField="eventName" HeaderText="Event" SortExpression="eventName">
                   </asp:BoundField>
                   <asp:BoundField DataField="eventLocation" HeaderText="Location" SortExpression="eventLocation" >
                   </asp:BoundField>
                   <asp:BoundField DataField="beginDate" HeaderText="Begin" SortExpression="beginDate" ReadOnly="True" >
                   </asp:BoundField>
                   <asp:BoundField DataField="endDate" HeaderText="End" SortExpression="endDate" ReadOnly="True" >
                   </asp:BoundField>
                   
                   <asp:TemplateField HeaderText="Action">
				       <itemtemplate>
					         <asp:button id="btnSignUp" runat="server" commandname="SignUpEvent" text="Sign Up" CssClass="btn btn-default btn-primary btn-block" CommandArgument='<%# Eval("eventID") %>' />
				       </itemtemplate>
			           
			       </asp:TemplateField>
                  
               </Columns>
                    <HeaderStyle BackColor="#428BCA" HorizontalAlign="Center" ForeColor="black" />
                </asp:GridView>
                <asp:SqlDataSource ID="sqlEventpage" runat="server" ConnectionString="Data Source=CSDB;Initial Catalog=SEI_Ninja;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="
                    SELECT ev.eventID, eventName, eventLocation, MIN(ev_ti.eventDate) AS beginDate, MAX(ev_ti.eventDate) AS endDate,
                           ( SELECT COUNT(DISTINCT scheduledUserID)
                               FROM SEI_Ninja.dbo.SCHEDULED_USERS su
                              WHERE su.eventTimeID = ev_ti.eventTimeID ) AS attendees
                      FROM SEI_Ninja.dbo.[EVENT] ev
                           LEFT OUTER JOIN SEI_Ninja.dbo.EVENT_TIMES ev_ti ON (ev.eventID = ev_ti.eventID)
                     WHERE ev.eventID   = @eventID
                     GROUP BY ev.eventID, eventName, eventLocation, eventTimeID
                     ORDER BY eventName;" CancelSelectOnNullParameter="False"  UpdateCommand="
                    UPDATE SEI_Ninja.dbo.[EVENT]
                       SET eventName = @eventName
                     WHERE eventID   = @eventID"> 
                  <SelectParameters>
                      <asp:ControlParameter ControlID="EventNameSelect" DefaultValue="0" Name="eventID" PropertyName="SelectedValue" Type="Int32" />
                  </SelectParameters>
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
      </div>--%>
    <script>
        // Holds all selected date and times
        var dateTimes = [];

        // Things to do when the page loads
        $(document).ready(function () {
            // Initialize schedule table
            var currentDate = new Date();
            var day = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            document.getElementById('eventDate').value = month + '/' + day + '/' + year;
            generateAgendaTable();

            // Start the date picker
            $('#eventDate').datepicker({
                'format': 'm/d/yyyy',
                todayBtn: "linked",
                todayHighlight: true
            });
        });

        // Add a new row to the bottom of a form group
        function addRow(addRowButton) {
            var parent = $(addRowButton).closest('.form-group');
            var newRow = parent.children('.input-group').last().clone();
            newRow.children().each(function () {
                $('input', this).val('');
            })
            parent.append(newRow);

            // Disable any used options from the select options
            disableSelectedAttendees();
            return;
        }

        // Remove a row from a form group
        function removeRow(removeRowButton) {
            var rows = $(removeRowButton).closest('.form-group').children('.input-group');
            if (rows.length > 1) {
                // Remove the row that was clicked
                $(removeRowButton).closest('.input-group').remove();

                // Disable any used options from the select options
                disableSelectedAttendees();
            }
            else {
                alert("You cannot remove the last one!");
            }
            return;
        }

        // From http://jsfiddle.net/QKy4Y/
        // Disables selection options for classes that are selected.
        function disableSelectedAttendees() {

            // start by setting everything to enabled
            $('#eventAttendees select option').attr('disabled', false);

            // loop each select and set the selected value to disabled in all other selects
            $('#eventAttendees select').each(function () {
                var $this = $(this);
                $('#eventAttendees select').not($this).find('option').each(function () {
                    if ($(this).attr('value') == $this.val())
                        $(this).attr('disabled', true);
                });
            });
            return;
        }

        function generateAgendaTable() {
            // Date must of the form m/d/yyyy

            // Number of days to display at a time
            var numberOfDaysToDisplay = 5;
            // Number of minutes each row should be separated by
            var step = parseInt(document.getElementById('eventTime').value);
            // Holds the agenda table
            var agendaTable;
            // Holds the names of days of the week
            var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            // Holds the date the user has chosen as an array
            var inputDate = document.getElementById('eventDate').value.split("/");
            //Holds all the dates that will be displayed
            var datesToDisplay = [];

            // Gets the dates for each of the days to display
            for (var index = 0; index < numberOfDaysToDisplay; index++) {
                datesToDisplay[datesToDisplay.length] = new Date(inputDate[2], parseInt(inputDate[0]) - 1, parseInt(inputDate[1]) + index);
            }

            agendaTable = '<div class="btn-group btn-group-justified"><div class="btn-group"><input type="button" class="btn btn-primary" onclick="changeSchedualDateRange(-1)" value="Prev Day" /></div><div class="btn-group"><input type="button" class="btn btn-primary" onclick="changeSchedualDateRange(1)" value="Next Day" /></div></div>';
            agendaTable += '<table class="table table-bordered table-responsive" style="background:#fff;" id="agendaTable"><thead><tr><th style="width:15%"></th>';

            for (var offset = 0; offset < numberOfDaysToDisplay; offset++) {
                agendaTable += '<th style="width:17%">' + (datesToDisplay[offset].getMonth() + 1) + '/' + datesToDisplay[offset].getDate() + ' ' + days[datesToDisplay[offset].getDay()] + '</th>';
            }
            agendaTable += '</tr></thead><tbody>';

            // Print the times
            // Time to start at
            datesToDisplay[0].setHours(8, 0, 0, 0);
            // Time to end at
            var endDateTime = new Date(datesToDisplay[0].getTime());
            endDateTime.setHours(17, 0, 0, 0);
            var time;
            while (datesToDisplay[0] <= endDateTime) {
                if (datesToDisplay[0].getHours() <= 12) {
                    time = datesToDisplay[0].getHours() + ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'AM';
                }
                else {
                    time = (datesToDisplay[0].getHours() % 12) + ':' + ('0' + datesToDisplay[0].getMinutes()).slice(-2) + 'PM';
                }
                agendaTable += '<tr><td>' + time + '</td>';

                // Add the days
                for (var numColumns = 0; numColumns < numberOfDaysToDisplay; numColumns++) {
                    agendaTable += '<td class="agenda-slot" onclick="toggleSelectedDateTime(this);" data-dateTime="' + datesToDisplay[numColumns].toLocaleDateString() + ' ' + time + '"></td>';
                }
                agendaTable += '</tr>';
                datesToDisplay[0].setMinutes(datesToDisplay[0].getMinutes() + step);
            }
            agendaTable += '</tbody></table>';

            // Add the agendaTable to the body
            document.getElementById('agendaTableHolder').innerHTML = agendaTable;

            // Select any dates that has been selected already
            for (index = 0; index < dateTimes.length; index++) {
                $("td[data-datetime='" + dateTimes[index] + "']").addClass("selectedDateTime");
            }
            return;
        }

        // Toggles whether an object is selected or not
        function toggleSelectedDateTime(object) {
            // The class of all objects that are selected
            var selectedClassName = "selectedDateTime";
            // Attribute name of the data to be added or removed from the array
            var dataAttributeName = "data-dateTime";

            if ($(object).hasClass(selectedClassName)) {
                // Has the class so remove the class and the associated value from the array
                $(object).removeClass(selectedClassName);
                dateTimes = $.grep(dateTimes, function (value) {
                    return value != $(object).attr(dataAttributeName);
                });
            }
            else {
                // Does not have the class so add it and the associated value
                $(object).addClass(selectedClassName);
                if (dateTimes.indexOf($(object).attr(dataAttributeName)) == -1) {
                    dateTimes.push($(object).attr(dataAttributeName));
                }
            }
            return;
        }

        function getAllSelectedDateTimes() {
            var formInputsForDateTimes = "";

            for (var index = 0; index < dateTimes.length; index++) {
                formInputsForDateTimes += "<input type=\"hidden\" name=\"dateTimes[]\" value=\"" + dateTimes[index] + "\" />";
            }

            //alert(formInputsForDateTimes);
            $("form").append(formInputsForDateTimes);
            $("form").submit();
            return;
        }

        // Adds any number of days to the current day and recreates the schedule
        function changeSchedualDateRange(daysToAdd) {
            // Find the new input date
            var dateToDisplay = document.getElementById('eventDate').value.split("/");
            dateToDisplay = new Date(dateToDisplay[2], parseInt(dateToDisplay[0]) - 1, parseInt(dateToDisplay[1]) + daysToAdd);

            // Change the input date and recreate the schedule
            var day = dateToDisplay.getDate();
            var month = dateToDisplay.getMonth() + 1;
            var year = dateToDisplay.getFullYear();
            document.getElementById('eventDate').value = month + '/' + day + '/' + year;
            generateAgendaTable();
            return;
        }
    </script>
</asp:content>
