<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reservation.aspx.cs" Inherits="CabForce.Reservation" MasterPageFile="~/Cab.Master" %>


<asp:Content ID="Reservation" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <script type="text/javascript">
        function Reset() {
            document.getElementById('<%=txtFirstName.ClientID%>').value = "";
            document.getElementById('<%=txtLastname.ClientID%>').value = "";
            document.getElementById('<%=txtHomePhone.ClientID%>').value = "";
            document.getElementById('<%=txtHomePhone1.ClientID%>').value = "";
            document.getElementById('<%=txtHomePhone2.ClientID%>').value = "";
            document.getElementById('<%=txtCellNo.ClientID%>').value = "";
            document.getElementById('<%=txtCellNo1.ClientID%>').value = "";
            document.getElementById('<%=txtCellNo2.ClientID%>').value = "";
            document.getElementById('<%=txtWorkNo.ClientID%>').value = "";
            document.getElementById('<%=txtWorkNo1.ClientID%>').value = "";
            document.getElementById('<%=txtWorkNo2.ClientID%>').value = "";
            document.getElementById('<%=txtWorkExt.ClientID%>').value = "";
            document.getElementById('<%=txtEmail.ClientID%>').value = "";
            document.getElementById('<%=txtConfirmEmail.ClientID%>').value = "";
            document.getElementById('<%=txtpickUp.ClientID%>').value = "";
            document.getElementById('<%=ddlFrom.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlTo.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlShare.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=txtPickupDate.ClientID%>').value = "";
            document.getElementById('<%=ddlHours.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlMin.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=chkSms.ClientID%>').checked = false;
            document.getElementById('<%=txtInst.ClientID%>').value = "";
            document.getElementById('<%=ddlRoundFrom.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlRoundTo.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=txtRoundPickupLocation.ClientID%>').value = "";
            document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
            document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex = 0;

        }
        function Validate() {
            if (Trim(document.getElementById('<%=txtFirstName.ClientID%>').value) == "") {
                document.getElementById('<%=txtFirstName.ClientID%>').focus();
                alert("Enter a valid First Name");
                return false;
            }
            if (Trim(document.getElementById('<%=txtLastname.ClientID%>').value) == "") {
                document.getElementById('<%=txtLastname.ClientID%>').focus();
                alert("Enter a valid Last Name");
                return false;
            }
            if (Trim(document.getElementById('<%=txtCellNo.ClientID%>').value) == "") {
                document.getElementById('<%=txtCellNo.ClientID%>').focus();
                alert("Enter a valid  Cell number");
                return false;
            }
            if (Trim(document.getElementById('<%=txtCellNo.ClientID%>').value) == "") {
                document.getElementById('<%=txtCellNo.ClientID%>').focus();
                alert("Enter a valid  Cell number");
                return false;
            }
            if (Trim(document.getElementById('<%=txtCellNo1.ClientID%>').value) == "") {
                document.getElementById('<%=txtCellNo1.ClientID%>').focus();
                alert("Enter a valid  Cell number");
                return false;
            }
            if (Trim(document.getElementById('<%=txtCellNo2.ClientID%>').value) == "") {
                document.getElementById('<%=txtCellNo2.ClientID%>').focus();
                alert("Enter a valid  Cell number");
                return false;
            }
            var mailid = Trim(document.getElementById('<%=txtEmail.ClientID%>').value);
            var confirmEmail = Trim(document.getElementById('<%=txtConfirmEmail.ClientID%>').value);
            document.getElementById('<%=txtEmail.ClientID%>').value = mailid.replace(/["'"]/g, "\'\'");
            mailid = document.getElementById('<%=txtEmail.ClientID%>').value;
            var chkEmail = mailid.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);

            if (chkEmail == -1) {
                alert("Enter a valid email id");
                document.getElementById('<%=txtEmail.ClientID%>').value = "";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }
            if (mailid != confirmEmail) {
                alert("Email id and confirm email id should be same");
                document.getElementById('<%=txtConfirmEmail.ClientID%>').value = "";
                document.getElementById('<%=txtConfirmEmail.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=txtpickUp.ClientID%>').value == "") {
                alert("Select Pick-Up Location");
                document.getElementById('<%=txtpickUp.ClientID%>').focus();
                return false;
            }
            if (document.getElementById('<%=ddlFrom.ClientID%>').selectedIndex == 0) {

                alert("Select Pick-Up Location From");
                return false;
            }
            if (document.getElementById('<%=ddlTo.ClientID%>').selectedIndex == 0) {
                alert("Select Drop Location To");
                return false;
            }
            if (document.getElementById('<%=ddlShare.ClientID%>').selectedIndex == 0) {
                alert("Select Share Type");
                return false;
            }
            if (document.getElementById('<%=txtPickupDate.ClientID%>').value == "") {
                document.getElementById('<%=txtPickupDate.ClientID%>').focus();
                alert("Select Pick-Up date");
                return false;
            }
            if (document.getElementById('<%=ddlHours.ClientID%>').selectedIndex == 0) {
                alert("Select Hour");
                return false;
            }
            if (document.getElementById('<%=ddlMin.ClientID%>').selectedIndex == 0) {
                alert("Select Minute");
                return false;
            }
            if (document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex == 0) {
                alert("Select AM/PM");
                return false;
            }
        }

        function fncInputNumericValuesOnly() {
            if (!(event.keyCode >= 48 && event.keyCode <= 57)) {
                event.returnValue = false;
            }
        }
        function CheckNumber(id) {
            if (Trim(document.getElementById(id).value) != "") {
                var retVal = IsNumeric(document.getElementById(id).value);
                if (retVal == false) {
                    alert("Enter only digit");
                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();
                }
            }
        }
        function IsNumeric(data) {
            return parseFloat(data) == data;
        }
        function FocusNextHomePhone1(id, args) {
            if (document.getElementById(id).value.length == 3) {
                if (args == 0) {
                    document.getElementById('<%=txtHomePhone1.ClientID%>').focus();
                }
                if (args == 1) {
                    document.getElementById('<%=txtCellNo1.ClientID%>').focus();
                }
                if (args == 2) {
                    document.getElementById('<%=txtWorkNo1.ClientID%>').focus();
                }
            }
        }
        function FocusNextHomePhone2(id, args) {
            if (document.getElementById(id).value.length == 3) {
                if (args == 0) {
                    document.getElementById('<%=txtHomePhone2.ClientID%>').focus();
                }
                if (args == 1) {
                    document.getElementById('<%=txtCellNo2.ClientID%>').focus();
                }
                if (args == 2) {
                    document.getElementById('<%=txtWorkNo2.ClientID%>').focus();
                }
            }
            if (args == 3 && document.getElementById(id).value.length == 4) {
                document.getElementById('<%=txtWorkExt.ClientID%>').focus();
            }
        }
        function FocusNextCellNo(id, args) {
            if (document.getElementById(id).value.length == 4) {
                if (args == 0) {
                    document.getElementById('<%=txtCellNo.ClientID%>').focus();
                }
                if (args == 1) {
                    document.getElementById('<%=txtWorkNo.ClientID%>').focus();
                }
                if (args == 2) {
                    document.getElementById('<%=txtEmail.ClientID%>').focus();
                }
            }
        }
        function ValidatePress() {//you can't type anything
            event.returnValue = false;
        }
        function CheckDate() {
            document.getElementById('<%=ddlHours.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlMin.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
            document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex = 0;

            var dateString = document.getElementById('<%=txtPickupDate.ClientID%>').value;
            var arrDate = dateString.split('/');
            var year = arrDate[2];
            var date = arrDate[1];
            var month = arrDate[0]-1 ;
            

            var dateCurrent = new Date();
            var compareDate = false;

            if (year < dateCurrent.getFullYear()) {
                alert("Date can't less than current date");
                document.getElementById('<%=txtPickupDate.ClientID%>').value = "";
                 document.getElementById('<%=txtPickupDate.ClientID%>').focus();
             }
             else {
                 if (year > dateCurrent.getFullYear()) {
                     return true;
                 }
                 else {
                     if (month < dateCurrent.getMonth() && year == dateCurrent.getFullYear()) {
                         alert("Date can't less than current date");
                         document.getElementById('<%=txtPickupDate.ClientID%>').value = "";
                        document.getElementById('<%=txtPickupDate.ClientID%>').focus();

                    }
                    else {
                        if (date < dateCurrent.getDate() && month == dateCurrent.getMonth() && year == dateCurrent.getFullYear()) {
                            alert("Date can't less than current date");
                            document.getElementById('<%=txtPickupDate.ClientID%>').value = "";
                            document.getElementById('<%=txtPickupDate.ClientID%>').focus();
                        }
                    }
                }
            }
        }
        function CheckReservation() {
            if (document.getElementById('<%=txtPickupDate.ClientID%>').value == "") {
                alert("Select Pickup Date First");
                document.getElementById('<%=ddlHours.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlMin.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=txtPickupDate.ClientID%>').focus();

            }
            else if (document.getElementById('<%=txtPickupDate.ClientID%>').value != "" && document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex > 0
             && document.getElementById('<%=ddlMin.ClientID%>').selectedIndex > 0 && document.getElementById('<%=ddlHours.ClientID%>').selectedIndex > 0) {
                use_time_difference();
                document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex = 0;
            }
    }

    function use_time_difference() {
        var dateString = document.getElementById('<%=txtPickupDate.ClientID%>').value;
            var arrDate = dateString.split('/');
            var year = arrDate[2];
            var date = arrDate[1] ;
            var month = arrDate[0] - 1;
            var hour = document.getElementById('<%=ddlHours.ClientID%>').value;
           var min = document.getElementById('<%=ddlMin.ClientID%>').value;
            if (document.getElementById('<%=ddlAmPm.ClientID%>').value == "PM") {
                hour = parseInt(hour) + 12;
            }
            //days, hours, minutes and seconds 
            datediff = new Date(year, month, date, hour, min, 0);
            var dateCurrent = new Date();
            oDiff = get_time_difference(dateCurrent, datediff);
            if (oDiff.hours < 6) {
                alert("For advance booking please select hours minimum 6 hrs before");
                document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex = 0;
           }
       }
       // Simple function to calculate time difference between 2 Javascript date objects
       function get_time_difference(earlierDate, laterDate) {
           var nTotalDiff = laterDate.getTime() - earlierDate.getTime();
           var oDiff = new Object();

           oDiff.hours = Math.floor(nTotalDiff / 1000 / 60 / 60);
           nTotalDiff -= oDiff.days * 1000 * 60 * 60 * 24;
           return oDiff;
       }

       function ShowRoundInfo(id, args) {
           if (args == 0) {
               if (document.getElementById(id).checked == true) {
                   document.getElementById("tblRound").style.display = 'inline';
               }
           }
           else {
               document.getElementById("tblRound").style.display = 'none';
           }
       }

       function CheckMyDate() {
           document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex = 0;
                if (document.getElementById('<%=txtPickupDate.ClientID%>').value == "" || document.getElementById('<%=ddlHours.ClientID%>').selectedIndex == 0
              || document.getElementById('<%=ddlMin.ClientID%>').selectedIndex == 0 || document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex == 0) {
                    alert("Select pickup date,hour,time first");
                    document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
                    document.getElementById('<%=txtPickupDate.ClientID%>').focus();
                    return false;
                }
                var dateString = document.getElementById('<%=txtPickupDate.ClientID%>').value;
                var arrDate = dateString.split('/');
                var year = arrDate[2];
                var date = arrDate[1];
                var month = arrDate[0] - 1;


                var dateStringRound = document.getElementById('<%=txtRoundPickUp.ClientID%>').value;
                var arrDateRound = dateStringRound.split('/');
                var yearRound = arrDateRound[2];
                var dateRound = arrDateRound[1];
                var monthRound = arrDateRound[0] - 1;


                var compareDate = false;
                if (yearRound < year) {
                    alert("Return Date can't less than Pick up date");
                    document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
                document.getElementById('<%=txtRoundPickUp.ClientID%>').focus();
            }
            else {
                if (yearRound > year) {
                    return true;
                }
                else {
                    if (monthRound < month && year == yearRound) {
                        alert("Return Date can't less than Pick up date");
                        document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
                        document.getElementById('<%=txtRoundPickUp.ClientID%>').focus();

                    }
                    else {
                        if (parseInt(dateRound) < parseInt(date) && month == monthRound && year == yearRound) {
                            alert("Return Date can't less than Pick up date");
                            document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
                            document.getElementById('<%=txtRoundPickUp.ClientID%>').focus();
                        }
                    }
                }
            }
        }

        function ValidateDate(id) {
            document.getElementById(id).value = "";
        }

        function ValidateReturnDate() {
            if (document.getElementById('<%=txtPickupDate.ClientID%>').value == "" || document.getElementById('<%=ddlHours.ClientID%>').selectedIndex == 0
              || document.getElementById('<%=ddlMin.ClientID%>').selectedIndex == 0 || document.getElementById('<%=ddlAmPm.ClientID%>').selectedIndex == 0) {
                alert("Select pickup date,hour,time first");
                document.getElementById('<%=txtRoundPickUp.ClientID%>').value = "";
                document.getElementById('<%=txtPickupDate.ClientID%>').focus();
                return false;
            }
            //check time for roundtrip
            if (document.getElementById('<%=txtRoundPickUp.ClientID%>').value == "") {
                alert("Select Round Pickup Date");
                document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=txtRoundPickUp.ClientID%>').focus();

            }
            if (document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex == 0
                || document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex == 0
                || document.getElementById('<%=ddlRoundAmPm.ClientID%>').selectedIndex == 0) {
                return false;
            }
            var dateString = document.getElementById('<%=txtPickupDate.ClientID%>').value;
            var arrDate = dateString.split('/');
            var year = arrDate[2];
            var date = arrDate[1];
            var month = arrDate[0] - 1;


            var varHour = document.getElementById('<%=ddlHours.ClientID%>').options[document.getElementById("<%=ddlHours.ClientID%>").selectedIndex].text;
            var varMin = document.getElementById('<%=ddlMin.ClientID%>').options[document.getElementById("<%=ddlMin.ClientID%>").selectedIndex].text;
            var varAmPm = document.getElementById('<%=ddlAmPm.ClientID%>').options[document.getElementById("<%=ddlAmPm.ClientID%>").selectedIndex].text;


            var varHourReturn = document.getElementById('<%=ddlRoundHour.ClientID%>').options[document.getElementById("<%=ddlRoundHour.ClientID%>").selectedIndex].text;
            var varMinReturn = document.getElementById('<%=ddlRoundMin.ClientID%>').options[document.getElementById("<%=ddlRoundMin.ClientID%>").selectedIndex].text;
            var varAmPmReturn = document.getElementById('<%=ddlRoundAmPm.ClientID%>').options[document.getElementById("<%=ddlRoundAmPm.ClientID%>").selectedIndex].text;

            if (varAmPm == "AM" && varHour == 12) {
                varHour = 00;
            }
            else if (varAmPm == "PM" && varHour != 12) {
                varHour = parseInt(varHour) + 12;
            }
            if (varAmPmReturn == "AM" && varHourReturn == 12) {
                varHourReturn = 00;
            }
            else if (varAmPmReturn == "PM" && varHourReturn != 12) {
                varHourReturn = parseInt(varHourReturn) + 12;
            }

            var dateStringRound = document.getElementById('<%=txtRoundPickUp.ClientID%>').value;
            var arrDateRound = dateStringRound.split('/');
            var yearRound = arrDateRound[2];
            var dateRound = arrDateRound[1];
            var monthRound = arrDateRound[0] - 1;

            var pickUpDate = new Date(year, month, date, varHour, varMin, 0, 0);
            var roundPickUpDate = new Date(yearRound, monthRound, dateRound, varHourReturn, varMinReturn, 0, 0);
            var isoPickUpDate = pickUpDate.toISOString();
            var isoRoundPickUpDate = roundPickUpDate.toISOString();
            if (isoPickUpDate > isoRoundPickUpDate) {
                alert("Return date shouldnot be less than Pick up date ");
                document.getElementById('<%=ddlRoundHour.ClientID%>').selectedIndex = 0;
                document.getElementById('<%=ddlRoundMin.ClientID%>').selectedIndex = 0;
            }

        }
        function Trim(objValue) {
            // Trims the blank space from the start and end of string

            var lRegExp = /^\s*/;
            var rRegExp = /\s*$/;
            objValue = objValue.replace(lRegExp, ""); //Perform LTRim
            objValue = objValue.replace(rRegExp, ""); //perform RTrim
            return objValue;
        }
    </script>

    <div id="reservationBodyDiv" style="width: auto; background-color: #4682B4;">
        <table style="width: 1000px; margin-left:50px" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td>
                    <b>Currently online reservation are available for passengers selecting locations from dropdownlist
                    , for all other reservations please contact dispatch@<asp:Label ID="lblPhoneNumber" runat="server"></asp:Label></b>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="border-color: Black; border-width: 1px; width: 100%;">
                        <legend><b>Taxi Reservation:</b></legend>
                        <table style="width: 100%">
                            <tr>
                                <td align="right">First Name :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFirstName" runat="server" Width="150" MaxLength="50"></asp:TextBox><label
                                        style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Last Name :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLastname" runat="server" Width="150" MaxLength="50"></asp:TextBox><label
                                        style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Home Phone No :
                                </td>
                                <td align="left">

                                    <asp:TextBox ID="txtHomePhone" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextHomePhone1(this.id,0);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtHomePhone1" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextHomePhone2(this.id,0);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtHomePhone2" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="4" onkeyup="FocusNextCellNo(this.id,0);"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Cell Phone No :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtCellNo" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextHomePhone1(this.id,1);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtCellNo1" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextHomePhone2(this.id,1);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtCellNo2" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="4" onkeyup="FocusNextCellNo(this.id,1);"></asp:TextBox>
                                    <label style="color: Red;">
                                        *</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Work Phone No :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtWorkNo" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();FocusNextHomePhone1(this.id,2);" onkeyup="FocusNextHomePhone1(this.id,2);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtWorkNo1" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextHomePhone2(this.id,2);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="3"></asp:TextBox>
                                    <asp:TextBox ID="txtWorkNo2" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();" onkeyup="FocusNextCellNo(this.id,2);CheckNumber(this.id);"
                                        onpaste="return false" MaxLength="4"></asp:TextBox>
                                    Ext<asp:TextBox ID="txtWorkExt" runat="server" Width="50" onkeypress="fncInputNumericValuesOnly();CheckNumber(this.id);"
                                        MaxLength="4" onpaste="return false" TabIndex="59"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Email Id :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEmail" runat="server" Width="250"></asp:TextBox><label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Confirm Email Id :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtConfirmEmail" runat="server" Width="250"></asp:TextBox><label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Pick Location :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtpickUp" runat="server" Width="150" TextMode="MultiLine"></asp:TextBox><label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">From :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlFrom" runat="server" Width="300"></asp:DropDownList><label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">To :
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlTo" runat="server" Width="300"></asp:DropDownList><label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Share Type:
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlShare" runat="server" Width="300">
                                        <asp:ListItem>--Select--</asp:ListItem>
                                        <asp:ListItem>Exclusive</asp:ListItem>
                                    </asp:DropDownList>
                                    <label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Pick Up Date:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtPickupDate" runat="server" Width="100" onkeypress="ValidatePress();"
                                        onkeyup="ValidateDate(this.id);" autocomplete="off" onpaste="return false;"></asp:TextBox>
                                    <label style="color: Red;">*</label>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtPickupDate"
                                        EnableViewState="true" OnClientDateSelectionChanged="CheckDate" Format="MM/dd/yyyy">
                                    </ajaxToolkit:CalendarExtender>


                                </td>
                            </tr>
                            <tr>
                                <td align="right">Pick Up Time:
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlHours" runat="server" Width="100" onchange="CheckReservation();">
                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                        <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                        <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                        <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                        <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                    </asp:DropDownList>
                                    Hours
                                <asp:DropDownList ID="ddlMin" runat="server" Width="100" onchange="CheckReservation();">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="00"></asp:ListItem>
                                    <asp:ListItem Text="15"></asp:ListItem>
                                    <asp:ListItem Text="30"></asp:ListItem>
                                    <asp:ListItem Text="45"></asp:ListItem>
                                </asp:DropDownList>
                                    Minutes
                                <asp:DropDownList ID="ddlAmPm" runat="server" Width="100" onchange="CheckReservation();">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="AM"></asp:ListItem>
                                    <asp:ListItem Text="PM"></asp:ListItem>
                                </asp:DropDownList>
                                    AM/PM<label style="color: Red;">*</label>
                                </td>
                            </tr>
                            <tr>
                                <td></td>

                                <td align="left">
                                    <table>
                                        <tr>


                                            <td style="text-decoration-style: solid">Schedule a round trip
                                            </td>
                                            <td>
                                                <asp:RadioButton ID="rdYesRound" runat="server" GroupName="roundPass" AutoPostBack="false" onclick="ShowRoundInfo(this.id,0)" />Yes
                                                <asp:RadioButton ID="rdNoRound" runat="server" GroupName="roundPass" AutoPostBack="false" Checked="true" onclick="ShowRoundInfo(this.id,1)" />No
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:CheckBox ID="chkSms" runat="server" Checked="true" AutoPostBack="false" />
                                </td>
                                <td align="left">Need Text message(Reservation SMS)
                                </td>
                            </tr>
                            <tr>
                                <td align="right">No of Passengers:
                                </td>
                                <td align="left">
                                    <table align="left">
                                        <tr>
                                            <td align="left">
                                                <asp:RadioButtonList ID="rdPass" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Text="1" Value="1" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td>
                                                <label style="color: Red;">
                                                    *</label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"></td>
                                <td align="left">
                                    <table id="trToll">
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkFuel" runat="server" Checked="true" />Fuel Surcharge
                                <asp:CheckBox ID="chkTolls" runat="server" Checked="true" />Tolls                                    
                                <asp:CheckBox ID="chkAirportTax" runat="server" Checked="true" />
                                                Airport Tax
                               
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Pay By Cash/Credit Card:

                                </td>
                                <td align="left">
                                    <asp:RadioButton ID="rdCredit" runat="server" GroupName="Pay" />Credit Card &nbsp;<asp:RadioButton ID="rdCash" runat="server" GroupName="Pay" Checked="true" />
                                    Cash

                                </td>

                            </tr>
                            <tr>
                                <td align="right">Special Instruction:
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtInst" runat="server" Width="300" TextMode="MultiLine" Height="80"></asp:TextBox>
                                </td>
                            </tr>


                        </table>
                        <table style="width: 100%;" align="center">
                            <tr id="tblRound" style="display: none">
                                <td colspan="2">

                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <fieldset style="border-color: Black; border-width: 1px; width: 99%;">
                                                    <legend><b>Round Trip Information:</b></legend>
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td align="right">From:
                                                            </td>
                                                            <td align="left">
                                                                <asp:DropDownList ID="ddlRoundFrom" runat="server" Width="400" onchange="ValidateRoundTripPlace(this.id,0);">
                                                                </asp:DropDownList>
                                                                <label style="color: Red;">
                                                                    *</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">To:
                                                            </td>
                                                            <td align="left">
                                                                <asp:DropDownList ID="ddlRoundTo" runat="server" Width="400" onchange="ValidateRoundTripPlace(this.id,1);">
                                                                </asp:DropDownList>
                                                                <label style="color: Red;">
                                                                    *</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">Pick-up Location:
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtRoundPickupLocation" runat="server" Width="200" TextMode="MultiLine"></asp:TextBox><%--<label style="color: Red;">*</label>--%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">Pick Up Date:
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtRoundPickUp" runat="server" Width="100" onkeypress="ValidatePress();"
                                                                    onkeyup="ValidateDate(this.id);" autocomplete="off" onpaste="return false;"></asp:TextBox><label
                                                                        style="color: Red;">*</label>
                                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtRoundPickUp"
                                                                    EnableViewState="true" OnClientDateSelectionChanged="CheckMyDate" Format="MM/dd/yyyy">
                                                                </ajaxToolkit:CalendarExtender>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">Pick Up Time:
                                                            </td>
                                                            <td align="left">
                                                                <asp:DropDownList ID="ddlRoundHour" runat="server" Width="100" onchange="ValidateReturnDate();">
                                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                    <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                                    <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                Hours
                                                            <asp:DropDownList ID="ddlRoundMin" runat="server" Width="100" onchange="ValidateReturnDate();">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="00"></asp:ListItem>
                                                                <asp:ListItem Text="15"></asp:ListItem>
                                                                <asp:ListItem Text="30"></asp:ListItem>
                                                                <asp:ListItem Text="45"></asp:ListItem>
                                                            </asp:DropDownList>
                                                                Minutes
                                                            <asp:DropDownList ID="ddlRoundAmPm" runat="server" Width="100" onchange="ValidateReturnDate();">
                                                                <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="AM"></asp:ListItem>
                                                                <asp:ListItem Text="PM"></asp:ListItem>
                                                            </asp:DropDownList>
                                                                AM/PM<label style="color: Red;">*</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">No of Passenger:
                                                            </td>
                                                            <td align="left">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButtonList ID="rdRoundPass" runat="server" RepeatDirection="Horizontal">
                                                                                <asp:ListItem Text="1" Value="1" Selected="True"></asp:ListItem>
                                                                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </td>
                                                                        <td>
                                                                            <label style="color: Red;">
                                                                                *</label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="button" OnClientClick="return Validate();" OnClick="btnSubmit_Click" />
                                    <input type="button" value="Reset" onclick="return Reset();" id="btnreset" class="button" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <br />
                </td>
            </tr>

        </table>

    </div>
</asp:Content>

