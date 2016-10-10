<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestSettings.aspx.cs" Inherits="CabForce.TestSettings" MasterPageFile="~/Cab.Master" %>
<asp:Content ID="settings" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody"> 
   
    <script src="jquery/jquery-1.10.2.min.js"></script>
     <script type="text/javascript">
         function checkStateAvailability() {
                $.ajax({
                 type: "POST",
                 url: "TestSettings.aspx/checkLocationName",
                 data: "{IDVal: '" + $("#<% =txtCity.ClientID %>").val() + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: onSuccess,
                failure: function (AjaxResponse) {
                    document.getElementById("<% = Label1.ClientID %>").innerHTML = "Dfgdfg";
                }
            });
             return false;
         }
         
         function onSuccess(AjaxResponse) {
            
             document.getElementById("<% = Label1.ClientID %>").innerHTML = AjaxResponse.d;
         }
    </script>
  
      <div id="divTestSettings" style="width: auto; background-color: #4682B4;">

        <table style="width:1000px;margin-left:100px">
            <tr>
                <td colspan="2" align="left">
                    <fieldset style="height:150px;width:550px;border:1px solid black">
                        <legend>Phone Update</legend>
                        <table>
                            <tr>
                                <td>
                                    PhoneNo:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPhoneNo" runat="server" Width="200"></asp:TextBox>
                                    <asp:Button ID="btnPhoneUpdate" runat="server" Text="Update" CssClass="myButton" OnClick="btnPhoneUpdate_Click" ValidationGroup="SettingsPhone" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="EnterPhoneNumber" ControlToValidate="txtPhoneNo" ForeColor="#FF3300" ValidationGroup="SettingsPhone"></asp:RequiredFieldValidator>
                                    <input type="hidden" id="hidPhone" runat="server"  />
                                </td>
                                
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="left">
                    <fieldset style="height:100px;width:550px;border:1px solid black">
                        <legend>
                            ADD Cities
                        </legend>
                         <table>
                        <tr>
                            <td>
                                Cities:
                            </td>
                            <td>
                                <asp:TextBox ID="txtCity" runat="server"  Width="150px" Height="20px" ></asp:TextBox>&nbsp
                                <asp:Button ID="btnCheck" runat="server" Text="ShowAvailability" OnClientClick="return checkStateAvailability();" ValidationGroup="SettingsState" />
                               <%-- <input type="button" id="btnCheck" value="ShowAvailability" onclick="checkIDAvailability();" ValidationGroup="SettingsState" />&nbsp--%>
                                <asp:Button ID="btnCityUpdate" runat="server" Text="AddCity" OnClick="btnCityUpdate_Click" ValidationGroup="SettingsState" CssClass="myButton" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCity" ErrorMessage="Add City" ForeColor="#FF3300"  ValidationGroup="SettingsState"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                    </fieldset>                  

                </td>
            </tr>
            <tr>
                <td colspan="2" align="cenetr">
                    <fieldset style="height:150px;width:900px;border:1px solid black">
                        <legend>Change User Name/Password:</legend>
                        <table>
                            <tr>
                                <td align="right">
                                    UserName :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtUserName" runat="server" ValidationGroup="SettingsUnamePwd"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter UserName" ControlToValidate="txtUserName" ForeColor="#FF3300" ValidationGroup="SettingsUnamePwd" ></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Password :
                                </td>
                                <td align="left">
                                     <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ValidationGroup="SettingsUnamePwd"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                      ErrorMessage="Password must be between 4 and 10 digits long and include at least one numeric digit." ValidationExpression="^(?=.*\d).{4,10}$" ControlToValidate="txtPassword" ForeColor="#FF3300" ValidationGroup="SettingsUnamePwd"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ReTypePassword:
                                </td>
                               
                                
                                <td>
                                     <asp:TextBox ID="txtRePassword" runat="server" TextMode="Password" ValidationGroup="SettingsUnamePwd"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password is not  Matching" ControlToCompare="txtPassword" ControlToValidate="txtRePassword" ForeColor="#FF3300" ValidationGroup="SettingsUnamePwd"></asp:CompareValidator>
                          
                                </td>
                            </tr>
                            <tr>
                                <td>

                                </td>
                                <td align="left" >
                                    <asp:Button ID="btnUnamePwd" runat="server" Text="UpdateUnamePwd" CssClass="myButton" ValidationGroup="SettingsUnamePwd" OnClick="btnUnamePwd_Click"  />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>

        </table>


    </div>
</asp:Content>


