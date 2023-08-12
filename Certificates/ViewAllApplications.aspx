<%@ Page Title="View Certificate(s)" Language="C#" MasterPageFile="~/ModuleSite.Master" AutoEventWireup="true" CodeBehind="ViewAllApplications.aspx.cs"
    Inherits="Certificates.ViewAllApplications" EnableEventValidation="false" EnableViewState="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>    
    <div>
        <ajaxToolkit:Accordion ID="Accordion1" runat="server" HeaderCssClass="headerCssClass" ContentCssClass="contentCssClass" HeaderSelectedCssClass="headerSelectedCss"
            FadeTransitions="true" TransitionDuration="700" AutoSize="None" SelectedIndex="0">
            <Panes>
                <ajaxToolkit:AccordionPane ID="AccordionPane1" runat="server">
                    <Header>All Applcations <strong>(<span id="countAllApplications" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u><span id="spAppDetails" runat="server">Details of All Applcations</span></u></strong>
                        <div class="mb-4 row">
                            <label class="col-sm-4"></label>
                            <div class="col-sm-8" style="text-align: right">
                                <asp:Button ID="btnExport" runat="server" Text="Export to PDF" CssClass="btn" OnClick="btnExport_Click" />
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                            </div>
                        </div>
                        <div class="mb-4 row">
                        </div>
                        <div class="mb-4 row">
                            <label for="txtRollNo" class="col-sm-1" style="text-align: right;">Roll No</label>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtRollNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="txtName" class="col-sm-1" style="text-align: right;">Name</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="txtCertificateType" class="col-sm-2" style="text-align: right;">Certificate Type</label>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtCertificateType" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="mb-4 row">
                            <label for="txtCourse" class="col-sm-1" style="text-align: right;">Course</label>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtCourse" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <label for="txtFromDate" class="col-sm-2" style="text-align: right;">From Date</label>
                            <div class="col-sm-2">
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-sm-1">
                                    <asp:ImageButton ID="imgPopup" ImageUrl="~/assets/images/cal.png" Width="35px" Height="35px" ImageAlign="Bottom"
                                        runat="server" />
                                    <ajaxToolkit:CalendarExtender ID="Calendar1" PopupButtonID="imgPopup" runat="server" TargetControlID="txtFromDate"
                                        Format="dd-MMM-yyyy"></ajaxToolkit:CalendarExtender>
                                </div>
                            </div>
                            <label for="txtToDate" class="col-sm-2" style="text-align: right;">To Date</label>
                            <div class="col-sm-2">
                                <div class="col-sm-10">
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:ImageButton ID="imgPopup2" ImageUrl="~/assets/images/cal.png" Width="35px" Height="35px" ImageAlign="Bottom"
                                        runat="server" />
                                </div>
                                <div class="col-sm-1">
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" PopupButtonID="imgPopup2" runat="server"
                                        TargetControlID="txtToDate" Format="dd-MMM-yyyy"></ajaxToolkit:CalendarExtender>
                                </div>
                            </div>
                        </div>                   
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdAllApplications" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped" DataKeyNames="Id" GridLines="None" runat="server"
                                        AutoGenerateColumns="false" AllowPaging="true" AllowSorting="true" OnSorting="grdAllApplications_Sorting" OnPageIndexChanging="grdAllApplications_PageIndexChanging" PageSize="50">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Application found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SNo" HeaderStyle-Width="4%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                    <asp:Label ID="lblIsCertificatePrinted" runat="server" Text='<%#Eval("IsCertificatePrinted")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCertificateType" runat="server" Text='<%#Eval("CertificateType")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No" SortExpression="RollNo" HeaderStyle-Width="8%">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>                                      
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate" SortExpression="CertificateType">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                                    <asp:BoundField DataField="CourseApplied" HeaderText="Course" SortExpression="CourseApplied">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AppliedOn" HeaderStyle-Width="12%" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}"
                                                SortExpression="AppliedOn">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#808080" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#383838" />
                                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />

                                    

                                    </asp:GridView>
                                        <div style="display:none;"> PageSize:  
    <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">  
        <asp:ListItem Text="10" Value="10" />  
        <asp:ListItem Text="25" Value="25" />  
        <asp:ListItem Text="50" Value="50" /> </asp:DropDownList>  
    <hr /> 
                                            </div>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
            </Panes>
        </ajaxToolkit:Accordion>
    </div>
</asp:Content>

