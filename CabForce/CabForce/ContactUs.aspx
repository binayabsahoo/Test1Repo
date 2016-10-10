<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="CabForce.ContactUs" MasterPageFile="~/Cab.Master" %>
<asp:Content ID="Contact" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">
    <script type="text/javascript">
        function Reset() {

             document.getElementById('<%=txtName.ClientID%>').value = "";
             document.getElementById('<%=txtPhone.ClientID%>').value = "";
             document.getElementById('<%=txtEmail.ClientID%>').value = "";
             document.getElementById('<%=txtComments.ClientID%>').value = "";
             document.getElementById('<%=drpFind.ClientID%>').selectedIndex = 0;
             document.getElementById('<%=txtName.ClientID%>').focus();
        }
        function Validate() {
            var userName = document.getElementById('<%=txtName.ClientID%>').value;
             var phoneNo = document.getElementById('<%=txtPhone.ClientID%>').value;
             var userEmail = document.getElementById('<%=txtEmail.ClientID%>').value;
             var userComment = document.getElementById('<%=txtComments.ClientID%>').value;

             if (userName == "" ) {
                 alert("Name shouldn't be blank");
                 document.getElementById('<%=txtName.ClientID%>').focus();
                return false;
            }
            if (phoneNo == "" ) {
                alert("Phone Number shouldn't be blank");
                document.getElementById('<%=txtPhone.ClientID%>').focus();
                return false;
            }
            if (userEmail == "" ) {
                alert("Email shouldn't be blank");
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }
            if (userComment == "" ) {
                alert("Comment shouldn't be blank");
                document.getElementById('<%=txtComments.ClientID%>').focus();
                return false;
            }
            var mailid = document.getElementById('<%=txtEmail.ClientID%>').value;
             document.getElementById('<%=txtEmail.ClientID%>').value = mailid.replace(/["'"]/g, "\'\'");
             mailid = document.getElementById('<%=txtEmail.ClientID%>').value;
             var chkEmail = mailid.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/);

             if (chkEmail == -1) {
                 alert("Enter a valid email id");
                 document.getElementById('<%=txtEmail.ClientID%>').value = "";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }

            return true;
        }
        function CheckNumber(id) {
            if (document.getElementById(id).value != "") {
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
    </script>
    <div id="divContact" style="width: auto; background-color: #4682B4;">
        <table style="width:1000px;margin-left:100px">
            <tr>
                <td>
                   <h3> Contact Us :</h3> 
                    <p>
                        CabForce Pvt Ltd<br />
                        Sector-7,E-311<br />
                        Cuttack,CDA<br />
                        Odisha-753014<br />
                        PHONE: <b><asp:Label ID="lblPhoneNo" runat="server" Text="Label"></asp:Label></b><br />
                          FAX: <b>111-111-1111</b><br />
                        Email: <b>testtaxiservices@gmail.com</b>
                        <br /><br />
                        <b>If you have any question or concern regarding our company or services, you can
                        contact us by filling out this form and we'll get back to you as soon as possible.
                        Please feel free to contact us,as feedback helps us in continuous improvement.</b>
                    </p>
                </td>
            </tr>
            <tr>

                <td>
                    <table style="height: 200px; width: 500px; border:1px solid black">
                        <tr>
                            <td class="loginbox" style="width: 100%;">
                                <table width="100%">
                                    <tr>
                                        <td class="login_td">
                                            <table width="100%">
                                                <tr>
                                                    <td align="right">Name:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtName"  runat="server" Width="200"></asp:TextBox><label
                                                            style="color: Red;">*</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Phone:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPhone"  runat="server" Width="200" MaxLength="13" onpaste="return false;" onkeyup="CheckNumber(this.id);"></asp:TextBox><label
                                                            style="color: Red;">*</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div align="right">
                                                            Email:
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmail" runat="server" Width="200"></asp:TextBox><label
                                                            style="color: Red;">*</label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">How did you find our website:
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="drpFind" runat="server" Width="210">
                                                            <asp:ListItem Text="--Select--"></asp:ListItem>
                                                            <asp:ListItem Text="AllTheWeb"></asp:ListItem>
                                                            <asp:ListItem Text="Google"></asp:ListItem>
                                                            <asp:ListItem Text="WebSite"></asp:ListItem>
                                                            <asp:ListItem Text="Friend"></asp:ListItem>
                                                            <asp:ListItem Text="News"></asp:ListItem>
                                                            <asp:ListItem Text="Banner Ad"></asp:ListItem>
                                                            <asp:ListItem Text="Other"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Comments/Questions:
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Height="60" Width="250"></asp:TextBox><label
                                                            style="color: Red;">*</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="myButton"  OnClientClick="return Validate();" OnClick="btnSubmit_Click" />
                                            <input type="button" id="btnreset" value="Reset" onclick="Reset();" class="myButton" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </td>
                        </tr>
                    </table>
                </td>

            </tr>
           
        </table>
        <br />
    </div>

</asp:Content>

