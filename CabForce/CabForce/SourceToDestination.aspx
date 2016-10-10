<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SourceToDestination.aspx.cs" Inherits="CabForce.SourceToDestination" MasterPageFile="~/Cab.Master" %>

<asp:Content ID="SourceToDestination" runat="server" ContentPlaceHolderID="ContentPlaceHolderbody">

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
   
    <%@ Register TagPrefix="uc" TagName="Notification" Src="~/UserControl/Notification.ascx" %>
    <link href="css/Notification/styles.css" rel="stylesheet" />
   
    <script lang="Javascript" type="text/javascript">
        function Reset() {
            document.getElementById('<%=ddlSource.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlDestination.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=ddlsharetype.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=txtCharge.ClientID%>').value = " ";
            document.getElementById('<%=txtLoop.ClientID%>').value = " ";
            document.getElementById('<%=txtRoundcharge.ClientID%>').value = " ";
            document.getElementById('<%=txtJourney.ClientID%>').value = " ";
         }

         function Validate() {
            var source = document.getElementById('<%=ddlSource.ClientID%>').value;
            var destination = document.getElementById('<%=ddlDestination.ClientID%>').value;
            var share = document.getElementById('<%=ddlsharetype.ClientID%>').value;
            var charges = document.getElementById('<%=txtCharge.ClientID%>').value;
            var rdlst = document.getElementById('<%=radioPayment.ClientID%>');
            var radio = rdlst.getElementsByTagName("input");
            var loop = document.getElementById('<%=txtLoop.ClientID%>').value;
            var journey = document.getElementById('<%=txtJourney.ClientID%>').value;


            if (source == "" || Trim(source) == "") {
                alert("Source shouldn't be blank");
                document.getElementById('<%=ddlSource.ClientID%>').focus();
                return false;
            }

            if (destination == "" || Trim(destination) == "") {
                alert("City shouldn't be blank");
                document.getElementById('<%=ddlDestination.ClientID%>').focus();
                return false;
            }

            if (share == "--SelectItem--" || Trim(share) == "") {
                alert("please select Share type");
                document.getElementById('<%=ddlsharetype.ClientID%>').focus();
                return false;
            }

            if (charges == "" || Trim(charges) == "") {
                alert("Charge shouldn't be blank");
                document.getElementById('<%=txtCharge.ClientID%>').focus();
                return false;
            }
            if (radio[0].checked == false && radio[1].checked == false) {
                alert("Select price type");
                return false;
            }


            if (loop == "" || Trim(loop) == "") {
                alert("Mention Loop");
                document.getElementById('<%=txtLoop.ClientID%>').focus();
                return false;
            }

            if (journey == "" || Trim(journey) == "") {
                alert("Mention Loop");
                document.getElementById('<%=txtJourney.ClientID%>').focus();
                return false;
            }
        }
        function Trim(objValue) {
            // Trims the blank space from the start and end of string

            var lRegExp = /^\s*/;
            var rRegExp = /\s*$/;
            objValue = objValue.replace(lRegExp, ""); //Perform LTRim
            objValue = objValue.replace(rRegExp, ""); //perform RTrim
            return objValue;
        }
    </script>
    

   
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pnlUpdate">
        <ContentTemplate>
    <div id="bodyDiv" style="width: auto; height: 650px; background-color: #4682B4">

        <div id="addRatediv" style="width: auto; height: auto">
            <br />

            <input type="button" id="btnAdd" value="AddRate" runat="server" onclick="Reset();" />
            <br />
            <asp:Panel ID="panel1" runat="server" Style="display: none; background-color: #B2D6EA; height: 420px; width: 525px">
                <fieldset style="border-color: Black; border-width: 1px; height: 400px; width: 500px;">
                    <legend><b>Add/Edit Rate Information:</b></legend>
                    <table style="width: 100%; height: 100%">
                        <tr>

                            <td>Source :

                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSource" runat="server" Height="25px" Width="145px"></asp:DropDownList>
                                

                            </td>

                        </tr>

                        <tr>
                            <td>Destination :</td>

                            <td>
                                <asp:DropDownList ID="ddlDestination" runat="server" Height="25px" Width="145px"></asp:DropDownList>

                            </td>
                        </tr>

                        <tr>
                            <td>Sharetype :</td>
                            <td>
                                <asp:DropDownList ID="ddlsharetype" runat="server" Height="30px" Width="150px">
                                    <asp:ListItem>--SelectItem--</asp:ListItem>
                                    <asp:ListItem> Exclusive </asp:ListItem>
                                    <asp:ListItem> Shared</asp:ListItem>
                                </asp:DropDownList>

                            </td>

                        </tr>
                        <tr>
                            <td>Charges :
                            </td>
                            <td>
                                <asp:TextBox ID="txtCharge" runat="server" Height="25px" Width="145px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>PaymentType:
                            </td>


                            <td>
                                <asp:RadioButtonList ID="radioPayment" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="payment">CreditCard &nbsp;&nbsp;</asp:ListItem>
                                    <asp:ListItem Text="payment" Selected="True">Cash</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>

                        <tr>

                            <td>Loop :</td>
                            <td>
                                <asp:TextBox ID="txtLoop" runat="server" Height="25px" Width="145px"></asp:TextBox>

                            </td>

                        </tr>
                        <tr>

                            <td>RoundtripCharges :</td>
                            <td>
                                <asp:TextBox ID="txtRoundcharge" runat="server" Height="25px" Width="145px"></asp:TextBox>

                            </td>

                        </tr>
                        <tr>

                            <td>Journeytime :</td>
                            <td>
                                <asp:TextBox ID="txtJourney" runat="server" Height="25px" Width="145px"></asp:TextBox>

                            </td>

                        </tr>

                        <tr>


                            <td align="center" colspan="2">
                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="return Validate();" OnClick="btnSave_Click" />&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />

                            </td>

                        </tr>

                    </table>
                </fieldset>

            </asp:Panel>
            <ajaxToolkit:ModalPopupExtender BackgroundCssClass="modalBackground" DropShadow="false"
                runat="server" PopupControlID="Panel1" ID="ModalPopupExtender1" CancelControlID="btnCancel"
                TargetControlID="btnAdd" />

        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblError" runat="server" Text="" Visible="false" ForeColor="Red"></asp:Label>
                        <uc:notification id="ucNotification" runat="server" />
                    </td>

                </tr>
            </table>
        </div>
        <div align="center">
            <table>
                <tr>
                    <td>
                        <asp:GridView ID="gridRate" runat="server" AutoGenerateColumns="false" DataKeyNames="AddPk_ID" ShowHeader="true" OnRowEditing="gridRate_RowEditing"
                             OnRowUpdating="gridRate_RowUpdating" OnRowCancelingEdit="gridRate_RowCancelingEdit" AllowPaging="true" PageSize="3" AllowSorting="true" 
                            OnPageIndexChanging="gridRate_PageIndexChanging" OnSorting="gridRate_Sorting" OnRowDeleting="gridRate_RowDeleting" HorizontalAlign="Center" Width="900px" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" >
                            <HeaderStyle HorizontalAlign="Center"  ForeColor="White" />
                           
                            <Columns>
                                
                                 <asp:TemplateField HeaderText="RateId" Visible="false" >
                                     
                                    <ItemTemplate>
                                        <asp:Label ID="lblRateIndex" runat="server" Text='<%# Eval("AddPk_ID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--  <asp:TemplateField HeaderText="JourneyFrom">
                                    <ItemTemplate>
                                        <asp:Label ID="lbljourneyryFrom" runat="server" Text='<%# Eval("Source") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField> --%>

                               <asp:BoundField DataField="Source" HeaderText="JourneyFrom" SortExpression="Source" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="true"  />
                                
                                <%-- <asp:TemplateField HeaderText="JourneyTo" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblJourneyTo" runat="server" Text='<%# Eval("Destination") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                  <asp:BoundField DataField="Destination" HeaderText="JourneyTo"  ItemStyle-Font-Bold="true" SortExpression="Destination" ItemStyle-HorizontalAlign="Center"  />

                                 <%--<asp:TemplateField HeaderText="SingleOrShared" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblSingleOrShared" runat="server" Text='<%# Eval("Sharetype") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="Sharetype" HeaderText="SingleOrShared" SortExpression="Sharetype" ItemStyle-HorizontalAlign="Center"  ItemStyle-Font-Bold="true" />
                                 <%--<asp:TemplateField HeaderText="Tariff" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblTariff" runat="server" Text='<%# Eval("Charges") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="Charges" HeaderText="Tariff" SortExpression="Charges" ItemStyle-HorizontalAlign="Center"  ItemStyle-Font-Bold="true" />
                                 <%--<asp:TemplateField HeaderText="PaymentMode" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblPaymentMode" runat="server" Text='<%# Eval("PaymentType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                 <asp:BoundField DataField="PaymentType" HeaderText="PaymentMode" SortExpression="PaymentType" ItemStyle-HorizontalAlign="Center"  ItemStyle-Font-Bold="true" />
                                <%--<asp:TemplateField HeaderText="TripMode" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblTripMode" runat="server" Text='<%# Eval("Loop") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                 <asp:BoundField DataField="Loop" HeaderText="TripMode" SortExpression="Loop" ItemStyle-HorizontalAlign="Center"  ItemStyle-Font-Bold="true" />
                                <%--<asp:TemplateField HeaderText="Duration" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Journeytime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:BoundField DataField="Journeytime" HeaderText="Duration" SortExpression="Journeytime" ItemStyle-HorizontalAlign="Center"  ItemStyle-Font-Bold="true"/>
                                <%--<asp:TemplateField HeaderText="Edit"  >
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" />
                                      
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <%--<asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" />
                                    </ItemTemplate>

                                </asp:TemplateField>--%>                                
                                
                                <asp:CommandField ShowEditButton="true" HeaderText="Edit" ItemStyle-HorizontalAlign="Center"  />
                                <%--<asp:TemplateField HeaderText="Delete" >
                                    <ItemTemplate>
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete"  />
                                       
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:CommandField ShowDeleteButton="true" HeaderText="Delete" ItemStyle-HorizontalAlign="Center"  />
                            </Columns>

                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>

    </div>
            </ContentTemplate>
        </asp:UpdatePanel>

</asp:Content>
