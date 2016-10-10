<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="City.aspx.cs" Inherits="CabForce.City" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

         <div id="legend" style="height: 100px; width: 350px">
            <fieldset>
                <legend>ADD Cities</legend>
                <div>
                    <asp:Label ID="lblCity" runat="server" Text="City :"></asp:Label>
                    <asp:TextBox ID="txtCity" runat="server" Width="150px" Height="20px"></asp:TextBox>

                    <asp:Button ID="Button1" runat="server" Text="AddCities" Width="70px"  CssClass="myButton" OnClick="Button1_Click" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorFstName" runat="server"
                        ControlToValidate="txtCity" ErrorMessage="Enter State Name"
                        ForeColor="#009900"></asp:RequiredFieldValidator>
                </div>
            </fieldset>
        </div>
    
    
    </form>
</body>
</html>
