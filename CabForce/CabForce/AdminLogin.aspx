<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="CabForce.AdminLogin" MasterPageFile="~/Cab.Master" %>

<asp:Content ID="AdminLogin" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">
    <script type="text/javascript">
        function Reset() {
            document.getElementById('<%=txtUserName.ClientID%>').value = "";
             document.getElementById('<%=txtPassword.ClientID%>').value = "";
         }

    </script>
    <div style="width: auto; background-color: #4682B4;">
        <table>
            <tr style="height: 100px">
                <td></td>

            </tr>
            <tr>
                <td>
                    <fieldset style="width:400px;height:250px;border:1px solid black;margin-left:450px;background-color:#0094ff">
                        <legend><b>Login Form</b></legend>
                        <table>
                            <tr>
                                <td colspan="2" align="center">
                                    Please Login
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    UserName:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtUserName" runat="server" Width="150px" Height="25px"></asp:TextBox><label style="color:red">*</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="Please Enter UserName" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPassword" runat="server" Width="150px" Height="25px" TextMode="Password"></asp:TextBox><label style="color:red">*</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please Enter Password" ForeColor="#CC3300"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr style="height:20px">
                                <td colspan="2">

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="myButton" OnClick="btnLogin_Click" />&nbsp;&nbsp
                                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="myButton" OnClientClick="Reset()" />
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
