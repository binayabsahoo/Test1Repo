<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Notification.ascx.cs"
    Inherits="CabForce.Notification" %>
<asp:Panel ID="panNotification" runat="server" Style="display: none" EnableViewState=false >
    <p>
        <strong>
            <asp:Literal ID="litNotificationHeader" runat="server"></asp:Literal>&nbsp;</strong><asp:Literal
                ID="litMessage" runat="server"></asp:Literal></p>
</asp:Panel>
