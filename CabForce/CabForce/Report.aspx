<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="CabForce.Report" MasterPageFile="~/Cab.Master" %>


<asp:Content ID="Report" ContentPlaceHolderID="ContentPlaceHolderbody" runat="server">

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<link href="jquery-ui-1.11.1/jquery-ui.css" rel="stylesheet" />
<script src="jquery-ui-1.11.1/jquery-1.10.2.js"></script>
<script src="jquery-ui-1.11.1/jquery-ui.js"></script>
<link href="jquery-ui-1.11.1/css/style.css" rel="stylesheet" />

    <script type="text/javascript">
        function Validate() {
            
             var dateString = document.getElementById('<%=txtFromDate.ClientID%>').value;
             var dateStringTo = document.getElementById('<%=txtToDate.ClientID%>').value;
            if (dateString != "" && dateStringTo == "" || dateString == "" && dateStringTo != "" || dateString == "" && dateStringTo == "") {
                 alert("Both date must be filled");
                 return false;
             }
             return true;
        }
        function CheckDate() {
           
            var dateString = document.getElementById('<%=txtFromDate.ClientID%>').value;
            //if (dateString == "") {
            //    alert("Select From Date");
            //}
           // else {
                var arrDate = dateString.split('/');
                var year = arrDate[2];
                var date = arrDate[1];
                var month = arrDate[0];
                var dateStringTo = document.getElementById('<%=txtToDate.ClientID%>').value;
                var arrdateStringTo = dateStringTo.split('/');
                var yearTo = arrdateStringTo[2];
                var dateTo = arrdateStringTo[1];
                var monthTo = arrdateStringTo[0];
                if (parseInt(yearTo) < parseInt(year)) {
                    alert("To date must greater than from date");
                    document.getElementById('<%=txtToDate.ClientID%>').value = "";
                }
                else {
                    if (yearTo == year && parseInt(monthTo) < parseInt(month)) {
                        alert("To date must greater than from date");
                        document.getElementById('<%=txtToDate.ClientID%>').value = "";
                    }
                    else {
                        if (yearTo == year && monthTo == month && parseInt(dateTo) <= parseInt(date)) {
                            alert("To date must greater than from date");
                            document.getElementById('<%=txtToDate.ClientID%>').value = "";
                        }
                    }
                }
            //}
        }
       
    </script>
    <script type="text/javascript">
        function ValidatePress() {
            event.returnValue = false;
        }
        $(function () {           
            $("#"+"<%=txtFromDate.ClientID%>").datepicker({
                dateFormat: 'mm/dd/yy',
                changeMonth: true,
                changeYear: true,
                yearRange: "1950:"

            });
        });
        $(function () {            
            $("#" + "<%=txtToDate.ClientID%>").datepicker({
                dateFormat: 'mm/dd/yy',
                changeMonth: true,
                changeYear: true,
                yearRange: "1950:",
                onSelect:CheckDate()
            });
        });

    </script>
    <div id="divReport" style="width: auto; background-color: #4682B4;">
        <table style="width:1200px;margin-left:10px;overflow:auto">
            <tr>
                <td>

                    
                Pick-Up Date From :
                <asp:TextBox ID="txtFromDate" runat="server" Width="100" ></asp:TextBox>
                
                To :
                <asp:TextBox ID="txtToDate" runat="server" Width="100" ></asp:TextBox>
                
                &nbsp;
                <asp:Button ID="btnShow" runat="server" Text="Show" CssClass="myButton" 
                    OnClientClick="return Validate();" OnClick="btnShow_Click" />&nbsp;
                <asp:Button ID="btnDownloadCsv" runat="server" Text="Export To CSV" 
                    CssClass="myButton" OnClick="btnDownloadCsv_Click" />&nbsp;
                <asp:Button ID="btnDownLoadPdf" runat="server" Text="Export to PDF" CssClass="myButton" OnClick="btnDownLoadPdf_Click" />
                
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdateProgress ID="UpdateProgress" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="Image1" ImageUrl="~/Images/loading.gif" AlternateText="Processing"
                            runat="server" Width="100%" Height="100%" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                    <ajaxtoolkit:modalpopupextender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
                    PopupControlID="UpdateProgress" BackgroundCssClass="modalPopup" />

                      <asp:UpdatePanel ID="pnlData" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <fieldset style="border-color: Black; border-width: 1px;">
                            <legend><b>Reservation Report :</b></legend>
                            <asp:GridView ID="GridReport" runat="server" AutoGenerateColumns="false" ShowHeader="true" 
                                AllowPaging="true" AllowSorting="true" PageSize="5"  HorizontalAlign="Center" Width="900px" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"
                                HeaderStyle-Wrap="true" OnPageIndexChanging="GridReport_PageIndexChanging" OnSorting="GridReport_Sorting">

                                <Columns>

                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true" />                                                                   
                                                                      
                                    <asp:BoundField DataField="Cell_Phone" HeaderText="Cell PhoneNO" SortExpression="Cell_Phone" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>                                   
                                   
                                    <asp:BoundField DataField="Email_ID" HeaderText="EmailID" SortExpression="Email_ID" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>                                    

                                    <asp:BoundField DataField="Source" HeaderText="Source" SortExpression="Source" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Pick_Location" HeaderText="PickUP Location" SortExpression="Pick_Location" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="DateAndTime" HeaderText="Pickup Date" SortExpression="Date And Time" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                                                                            
                                                       
                                    <asp:BoundField DataField="No_of_Passengers" HeaderText="Passenger(S)" SortExpression="No_of_Passengers" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Payment_Mode" HeaderText="PayType" SortExpression="Payment_Mode" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Special_Instruction" HeaderText="Special Instruction" SortExpression="Special_Instruction" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="RoundTrip" HeaderText="RoundTrip" SortExpression="RoundTrip" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Round_Source" HeaderText="Return Source" SortExpression="Round_Source" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="Round_Destination" HeaderText="Return Destination" SortExpression="Round_Destination" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>                                    

                                    <asp:BoundField DataField="Round_Pickup_Location" HeaderText="Return Pickup Location" SortExpression="Round_Pickup_Location" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>

                                    <asp:BoundField DataField="RoundDateTime" HeaderText="Return Date Time" SortExpression="RoundDateTime" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>
                                                                                                 

                                    <asp:BoundField DataField="Round_No_of_Passengers" HeaderText="Return Passenger(S)" SortExpression="Round_No_of_Passengers" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"/>
                                </Columns>
                            </asp:GridView>
                            </fieldset>
                        </ContentTemplate>
                            </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>


