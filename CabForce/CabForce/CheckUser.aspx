<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckUser.aspx.cs" Inherits="CabForce.CheckUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        function checkIDAvailability() {
            $.ajax({
                type: "POST",
                url: "CheckUser.aspx/checkUserName",
                data: "{IDVal: '" + $("#<% =txtID.ClientID %>").val() + "' }",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: onSuccess,
                failure: function (AjaxResponse) {
                    document.getElementById("Label1").innerHTML = "Dfgdfg";
                }
            });
            function onSuccess(AjaxResponse) {
                document.getElementById("Label1").innerHTML = AjaxResponse.d;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     Enter your ID here
        <asp:TextBox ID="txtID" runat="server" ></asp:TextBox>
        <input type="button" id="btnCheck" value="ShowAvailability" onclick="checkIDAvailability();" />
        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
        <br />
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
    </form>
</body>
</html>
