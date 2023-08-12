<%@ Page Title="View Certificate(s)" Language="C#" MasterPageFile="~/ModuleSite.Master" AutoEventWireup="true"
    CodeBehind="ViewCertificates.aspx.cs" Inherits="Certificates.ViewCertificates" EnableViewState="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .hide {
            display: none;
        }
    </style>
    <h2><%: Title %></h2>
    <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
    <div id="dvNOPref" runat="server">
    </div>

    <div id="dvAcdGrid" runat="server">
        <ajaxToolkit:Accordion ID="Accordion1" runat="server" HeaderCssClass="headerCssClass" ContentCssClass="contentCssClass" HeaderSelectedCssClass="headerSelectedCss"
            FadeTransitions="true" TransitionDuration="700" AutoSize="None" SelectedIndex="0">
            <Panes>
                <ajaxToolkit:AccordionPane ID="AccordionPane1" runat="server">
                    <Header>Applied/Approved Applications <strong>(<span id="countAppliedApplication" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Applied/Approved Applications</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdCertificatesDetail" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
                                        DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false" OnRowDataBound="grdCertificatesDetail_RowDataBound">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Certificate found in our system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Payment">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPayment" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                    <asp:Label ID="lblIsCertificateVerified" runat="server" Text='<%#Eval("IsCertificateVerified")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblIsCertificateReady" runat="server" Text='<%#Eval("IsCertificateReady")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblAdminSectionRemarks" runat="server" Text='<%#Eval("AdminSectionRemarks")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblExamSectionRemarks" runat="server" Text='<%#Eval("ExamSectionRemarks")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Status/Progress" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnGrievance" runat="server" Text="Grievance" OnClick="btnGrievance_Click" Enabled="false" ToolTip="Click here to register your grievance" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <%--        <asp:BoundField DataField="IsCertificateVerified">
                <HeaderStyle />
                   <ItemStyle CssClass="hide" />
            </asp:BoundField>
              <asp:BoundField DataField="IsCertificateReady">
                <HeaderStyle />
                  <ItemStyle CssClass="hide" />
            </asp:BoundField>  --%>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="AccordionPane2" runat="server">
                    <Header>Rejected Applications <strong>(<span id="countRejectedApplications" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Rejected Applications</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdRejectedApplications" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
                                        DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false" OnRowDataBound="grdRejectedApplications_RowDataBound">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Certificate found in our system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                                 <asp:BoundField DataField="AdminSectionRemarks" HeaderText="Admin Remarks">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                                 <asp:BoundField DataField="ExamSectionRemarks" HeaderText="Exam Remarks">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-CssClass="headerWidth" Visible="false">
                                                <ItemTemplate>
                                                       <asp:Label ID="lblPayment" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                    <asp:Label ID="lblIsCertificateVerified" runat="server" Text='<%#Eval("IsCertificateVerified")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblcertificateType" runat="server" Text='<%#Eval("CertificateTyPE")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblAdminSectionRemarks" runat="server" Text='<%#Eval("AdminSectionRemarks")%>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblExamSectionRemarks" runat="server" Text='<%#Eval("ExamSectionRemarks")%>' Visible="false"></asp:Label>
                                     
                                                       </ItemTemplate>
                                            </asp:TemplateField>

                                            <%--        <asp:BoundField DataField="IsCertificateVerified">
                <HeaderStyle />
                   <ItemStyle CssClass="hide" />
            </asp:BoundField>
              <asp:BoundField DataField="IsCertificateReady">
                <HeaderStyle />
                  <ItemStyle CssClass="hide" />
            </asp:BoundField>  --%>
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
