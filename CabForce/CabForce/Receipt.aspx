
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receipt.aspx.cs" Inherits="CabForce.Receipt" MasterPageFile="~/Cab.Master" ValidateRequest = "false" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">
    
    <script src="jquery/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">      
        $(document).ready(function () {
            $('#<%=hidden.ClientID %>').val(document.getElementById('<%=divAvgRate.ClientID%>').innerHTML);
            alert($('#<%=hidden.ClientID%>').val());
        });
    </script>
    <asp:HiddenField ID="hidden" runat="server" />

    <div id="divAvgRate" runat="server" style="width: auto; background-color: #4682B4;">
        <fieldset style="border-color: black; border-width: 1px; width: 800px;margin-left:200px">
            <legend><b>Reservation Information</b></legend>
            <table border="1" style="width:80%;margin-left:50px">
                <tr>
                    <td align="center"> Rate
                    </td>
                    <td id="rate" align="left" runat="server">
                      
                    </td>
                </tr>
                
                <tr>
                    <td align="center"> ReturnRate<br />
                        If Taxi has been detained more than 3hours
                    </td>
                    <td id="ReturnRate" align="left" runat="server">
                      
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        Total(Approx.)
                    </td>
                    <td id="totalcost" runat="server"  align="left">
                      
                    </td>
                </tr>
                <tr>
                    <td  align="center">Fuel Surcharge(PerKm)<br />
                        If Source or destination is not matching as per given 
                    </td>
                    <td id="fuelcharge" runat="server" align="left">
                        15
                    </td>
                </tr>
                <tr align="center">
                    <td>Tolls(Each tollgate)
                    </td>
                    <td id="tollcharge" runat="server" align="left">
                       100
                    </td>
                </tr>
                <tr>
                    <td align="center">Airport Tax(Optional) 
                    </td>
                    <td id="AirportCharge" runat="server" align="left">
                       100
                    </td>
                </tr>
                
            </table>
            
            <table style="width:80%">
             
                <tr>
                    <td align="center">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" OnClick="BtnSubmit_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>

        </fieldset>
       <br />
    </div>

</asp:Content>

