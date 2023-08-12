<%@ Page Title="View Certificate(s)" Language="C#" MasterPageFile="~/ModuleSite.Master" AutoEventWireup="true" CodeBehind="CertificateSection.aspx.cs"
    Inherits="Certificates.CertificateSection" EnableViewState="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
    <br />
    <div id="dvReceiveCertificate" runat="server" visible="false">
        <h4>Update Certificate details</h4>
        <hr />
        <p style="font-size: 18px; background-color: forestgreen; color: black;">
            <strong style="font-size: 20px;">Disclamer: </strong><i>While issuing the certificate to applicant you can add <b>remarks</b> also for reference.</i>
        </p>
        <div class="mb-4 row">
            <label for="lblName" class="col-sm-2" style="text-align: right;">Name:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblName" runat="server"></asp:Label>
            </div>
            <label for="lblCertificateType" class="col-sm-2 " style="text-align: right;">Certificate:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblCertificateType" runat="server"></asp:Label>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="lblAppliedOn" class="col-sm-2 " style="text-align: right;">Applied On:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblAppliedOn" runat="server"></asp:Label>
            </div>
            <label for="lblCertificateVerified" class="col-sm-2 " style="text-align: right;">Verified:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblCertificateVerified" runat="server"></asp:Label>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="lblIssuedOn" class="col-sm-2 " style="text-align: right;">Issued On:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblIssuedOn" runat="server"></asp:Label>
            </div>
            <label for="lblCertificateReady" class="col-sm-2 " style="text-align: right;">Certificate Ready:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblCertificateReady" runat="server"></asp:Label>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="txtRemarks" class="col-sm-2 " style="text-align: right;">Remarks:</label>
            <div class="col-sm-7">
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" Columns="6"></asp:TextBox>
            </div>
        </div>
        <div class="mb-4 row">
            <label class="col-sm-3 "></label>
            <div class="col-sm-6 ">
                <asp:Button ID="btnReceiveCertificate" runat="server" CssClass="btn" Text="Certificate Received" OnClick="btnReceiveCertificate_Click" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClick="btnCancel_Click" />
            </div>
        </div>
    </div>
    <div>
        <ajaxToolkit:Accordion ID="Accordion1" runat="server" HeaderCssClass="headerCssClass" ContentCssClass="contentCssClass" HeaderSelectedCssClass="headerSelectedCss"
            FadeTransitions="true" TransitionDuration="700" AutoSize="None" SelectedIndex="0">
            <Panes>
                <ajaxToolkit:AccordionPane ID="AccordionPane1" runat="server">
                    <Header>Pending Certificates <strong>(<span id="countPendingCertificates" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Pending Certificates</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdPendingCertificatesDetail" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped" DataKeyNames="Id" GridLines="None" runat="server"
                                        AutoGenerateColumns="false" OnRowCommand="grdPendingCertificatesDetail_RowCommand" OnRowDataBound="grdPendingCertificatesDetail_RowDataBound">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Pending Certificate found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                    <asp:Label ID="lblIsCertificatePrinted" runat="server" Text='<%#Eval("IsCertificatePrinted")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCertificateType" runat="server" Text='<%#Eval("CertificateType")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <%--   <asp:BoundField DataField="Parentage" HeaderText="Parentage">
                                                <HeaderStyle />
                                            </asp:BoundField>--%>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkPrint" runat="server" CommandArgument='<%#Eval("Id")+ ";" + Eval("CertificateType")+ ";" + Eval("IsCertificatePrinted")+ ";" 
                                                            + Eval("CertificateSectionPrintedDate")+ ";" + Eval("CertificateNo")+ ";" + Eval("CertificateSectionIssuedNumber")%>'
                                                        OnClick="lnkPrint_Click"
                                                        CommandName="PrintCertificate" Text="Print" ToolTip="Click to Print the Certificate"></asp:LinkButton>
                                                    <%--                                                 <asp:LinkButton ID="lnkIssue1" runat="server" CommandArgument='<%#Eval("Id")+ ";" + Eval("CertificateType") + ";" + Eval("Name")+ ";" + Eval("AppliedOn")+ ";" + Eval("IsCertificateVerified")+ ";" + Eval("CertificateSectionIssuedOn")+ ";" + 
                                                             Eval("CertificateSectionIssuedNumber") + ";" + Eval("CertificateSectionReceivedRemarks")+ ";" + 
                                                            Eval("CertificateSectionReceivedOn")%>' CommandName="IssueCertificate" Text="Issue" ToolTip="Click to Issue the Certificate"></asp:LinkButton>--%>
                                                    <asp:LinkButton ID="lnkIssue" runat="server" Text="Certificate Ready" ToolTip="Click here to issue certificate" OnClick="lnkIssue_Click"
                                                        CommandArgument='<%#Eval("Id")+ ";" + Eval("CertificateType") + ";" +  Eval("IsCertificateVerified")%>' Visible="false"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="AccordionPane2" runat="server">
                    <Header>Issued Certificates <strong>(<span id="countIssuedCertificates" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Issued Certificates</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdIssuedCertificatesDetail" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped" DataKeyNames="Id" GridLines="None" runat="server"
                                        AutoGenerateColumns="false" OnRowDataBound="grdIssuedCertificatesDetail_RowDataBound" OnRowCommand="grdIssuedCertificatesDetail_RowCommand">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Issued Certificate found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                    <asp:Label ID="lblCertificateType" runat="server" Text='<%#Eval("CertificateType")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Parentage" HeaderText="Parentage">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Issued On" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReceivedOn" runat="server" Text='<%# Eval("CertificateSectionReceivedOn").ToString()  %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkPrint" runat="server" CommandArgument='<%#Eval("Id")+ ";" + Eval("CertificateType")%>'
                                                        CommandName="PrintCertificate" Text="Print" ToolTip="Click to Print the Certificate"></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkCollectCertificate" runat="server" CommandArgument='<%#Eval("Id")+ ";" + Eval("Name")+ ";" + Eval("CertificateType")+ ";"
                                                                  + Eval("AppliedOn") + ";" + Eval("IsCertificateVerified")+ ";" + Eval("CertificateSectionIssuedOn")+ ";" +
                                                                  Eval("IsCertificateReady")+ ";" + Eval("CertificateSectionReceivedRemarks")%>'
                                                        CommandName="ReceiveCertificate" Text="Collect/Receive" ToolTip="Click to update the received date"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
            </Panes>
        </ajaxToolkit:Accordion>
    </div>
</asp:Content>

