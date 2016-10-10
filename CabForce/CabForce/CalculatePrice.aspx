<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalculatePrice.aspx.cs" Inherits="CabForce.CalculatePrice" MasterPageFile="~/Cab.Master" %>

<asp:Content ID="PriceCAlculation" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAdTK8Vg2cAa6A0jLksL67VxSUA7qeLTZXYIsTzjtodH5xoDGdRRTiRN6HISq63qhcRfruUMB1FcCtwg"
        type="text/javascript"></script>
    <script type="text/javascript">
        function Reset() {
            document.getElementById('<%=txtFromAddress.ClientID%>').value = "";
            document.getElementById('<%=txtToAddress.ClientID%>').value = "";
        }

        function ResetText() {
            
            if (document.getElementById('<%=txtFromAddress.ClientID%>').value == "") {              
                alert("Starting address should be filled");
                return false;
            }
            if (document.getElementById('<%=txtToAddress.ClientID%>').value == "") {
                alert("End Point address should be filled");
                return false;
            }
        }
        function onGDirectionsLoad() {
            // Use this function to access information about the latest load()
            // results.

            // e.g.
            // document.getElementById("getStatus").innerHTML = gdir.getStatus().code;
            // and yada yada yada...
        }
        function setDirectionsForMap() {
            document.getElementById("directions").innerHTML = "";
            map = new GMap2(document.getElementById("map_canvas"));
            gdir = new GDirections(map, document.getElementById("directions"));
            GEvent.addListener(gdir, "load", onGDirectionsLoad);
            //GEvent.addListener(gdir, "error", handleErrors);
            var fromLocation =  document.getElementById('<%=txtFromAddress.ClientID%>').value;
            var toLocation =  document.getElementById('<%=txtToAddress.ClientID%>').value;
            // alert(fromLocation);
            // alert(toLocation);
            setDirections(fromLocation, toLocation, "en_US");
        }

        var map;
        var gdir;
        var geocoder = null;
        var addressMarker;
        var location1, location2;
        function initialize() {
            geocoder = new GClientGeocoder();
            gDir = new GDirections();
            GEvent.addListener(gDir, "load", function () {

                var drivingDistanceMiles = gDir.getDistance().meters / 1609.344;
                var drivingDistanceKilometers = gDir.getDistance().meters / 1000;
                document.getElementById('results').innerHTML = '<strong>Starting Address: </strong>' + location1.address + ' (' + location1.lat + ':' + location1.lon + ')<br />' +
                '<strong>Ending Address: </strong>' + location2.address + ' (' + location2.lat + ':' + location2.lon + ')<br />' +
                '<strong>Approximate Driving Distance: </strong>' + drivingDistanceMiles.toFixed(2) + 'Approximate miles (or ' + drivingDistanceKilometers + ' kilometers)' +
                '</br></br><strong style="color:Red"><b>Approximate Rate: Rs' + (drivingDistanceMiles.toFixed(2) * 10).toFixed(2) + '</b></strong>';
                fldTD.style.border = '1px solid black';
            });

        }
        function setDirections(fromAddress, toAddress, locale) {
            gdir.load("from: " + fromAddress + " to: " + toAddress,
                { "locale": locale });
        }

        function showLocation() {
            var fromLocation = document.getElementById('<%=txtFromAddress.ClientID%>').value;
             // alert(fromLocation);

             geocoder.getLocations(fromLocation, function (response) {
                 if (!response || response.Status.code != 200) {
                     document.getElementById("fldResults").style.display = 'none';
                     fldTD.style.border = 'none';
                     //alert("Sorry, we were unable to geocode the first address");
                     alert("Sorry, we were unable to find the starting street address");
                 }
                 else {
                     location1 = { lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address };
                     var toLocation =  document.getElementById('<%=txtToAddress.ClientID%>').value;
                    // alert(toLocation);
                    geocoder.getLocations(toLocation, function (response) {
                        if (!response || response.Status.code != 200) {
                            document.getElementById("fldResults").style.display = 'none';
                            fldTD.style.border = 'none';
                            //alert("Sorry, we were unable to geocode the second address");
                            alert("Sorry, we were unable to find the ending street address");
                        }
                        else {
                            location2 = { lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address };
                            gDir.load('from: ' + location1.address + ' to: ' + location2.address);
                        }
                    });
                }
            });
            document.getElementById("fldResults").style.display = 'inline'
        }
    </script>
    <div id="divCalculatePrice" style="width: auto; background-color: #4682B4;">
        <table  style="width:1000px;margin-left:100px">
            <tr>
                <td colspan="2">
                    <b>If your city is not part of the list displayed for starting address city or ending address city,call dispatch@<asp:Label ID="lblPhoneNumber" runat="server"></asp:Label>
                        for reservation.
                        Thanks for your co-operation</b>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="border-color: Black; border-width: 1px; width: 100%;">
                        <legend>PriceCalculation</legend>
                        <table style="border: 1px solid black; width: 500px">
                            <tr>
                                <td align="left" colspan="2">
                                    <h3><b>StartingAddress</b></h3>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <table>
                                        <tr>
                                            <td>Source Address:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFromAddress" runat="server" Height="35px" Width="180px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2">
                                    <h3><b>EndAddress</b></h3>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <table>
                                        <tr>
                                            <td>Destination Address:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtToAddress" runat="server" Height="35px" Width="180px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnMillege" runat="server" Text="CalculateMillage" CssClass="myButton" OnClientClick="return ResetText()"   />&nbsp;&nbsp
                                    <input type="button" id="btnReset" value="Reset" class="myButton" onclick="Reset()" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </fieldset>

                </td>
                <td id="fldTD">
                    <fieldset style="display: none; width: 400px; height: 100%; border-width: 0;" id="fldResults">
                        <p id="results">
                        </p>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table style="background-color:#EEE;margin-top:4px;font-family:Verdana,Arial,sans serif;font-size:12px;">
                        <tr>
                            <th>
                                Formatted Directions
                            </th>
                            <th>
                                Map
                            </th>
                        </tr>
                        <tr>
                            <td valign="top">
                                <div id="directions" style="width: 420px">
                                </div>
                            </td>
                            <td valign="top">
                                <div id="map_canvas" style="width: 600px; height: 500px">
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />

    </div>

</asp:Content>
