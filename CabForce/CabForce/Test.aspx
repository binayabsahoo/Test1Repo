<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="CabForce.Test" MasterPageFile="~/Cab.Master" %>

<asp:Content ID="Test" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">
    <div id="bodydiv" style="width:auto;height:500px;background-color:aqua">
        Hello world
        <br />
        <table>
            <tr>
                <td>
                    <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="false" />
                </td>
                <td>
                   False:
                </td>
            </tr>
            <tr>
                <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="true" />
          
            <td>
                true:
            </td>
                </tr>
        </table>
    </div>
  
</asp:Content>


