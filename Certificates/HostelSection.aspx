<%@ Page Title="View Certificate(s)" Language="C#" MasterPageFile="~/ModuleSite.Master" AutoEventWireup="true" CodeBehind="HostelSection.aspx.cs"
    Inherits="Certificates.HostelSection" EnableViewState="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
    <div id="dvverifyStudentDetails" runat="server" visible="false">
        <br />
        <h4>Update Application/Certificate details</h4>
        <hr />
        <p style="font-size: 18px; background-color: lightpink; color: black;">
            <strong style="font-size: 20px;">Disclamer: </strong><i>While verifying 
        the student details, you need to
        check <b>Name</b>, <b>Roll No</b>, <b>Session</b>.....<br />
                Then you can go and verify true.</i>
        </p>
        <div class="mb-4 row">
            <label for="lblName" class="col-sm-2" style="text-align: right;">Name:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblName" runat="server"></asp:Label>
            </div>
            <label for="lblParentage" class="col-sm-2" style="text-align: right;">Parentage:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblParentage" runat="server"></asp:Label>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="lblDOB" class="col-sm-2" style="text-align: right;">DOB:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblDOB" runat="server"></asp:Label>
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
            <label for="lblVerifiedOn" class="col-sm-2 " style="text-align: right;">Verified On:</label>
            <div class="col-sm-4">
                <asp:Label ID="lblVerifiedOn" runat="server"></asp:Label>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="drpStatus" class="col-sm-2 " style="text-align: right;"><span class="RequiredField">* </span>Status:</label>
            <div class="col-sm-4">
                <asp:DropDownList ID="drpStatus" runat="server" CssClass="form-control drp" AutoPostBack="true" OnSelectedIndexChanged="drpStatus_SelectedIndexChanged">
                    <asp:ListItem Text="Select Status" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Verified" Value="True"></asp:ListItem>
                    <asp:ListItem Text="Not Verified" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvdrpStatus" runat="server" CssClass="lbl" ErrorMessage="Select Status" InitialValue="-1"
                    ControlToValidate="drpStatus" Display="Dynamic" ValidationGroup="VerifyCertificate"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="txtRemarks" class="col-sm-2 " style="text-align: right;"><span id="spRemarks" runat="server" class="RequiredField">* </span>Remarks:</label>
            <div class="col-sm-7">
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" Columns="6"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRemarks" runat="server" CssClass="lbl" ErrorMessage="Enter Remarks"
                    ControlToValidate="txtRemarks" Display="Dynamic" ValidationGroup="VerifyCertificate"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="mb-4 row">
            <label class="col-sm-3 "></label>
            <div class="col-sm-6 ">
                <asp:Button ID="btnVerifyCertificate" runat="server" CssClass="btn" Text="Submit Details" ValidationGroup="VerifyCertificate" OnClick="btnVerifyCertificate_Click" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClick="btnCancel_Click" />
            </div>
        </div>
    </div>
    <div id="dvViewCertificate" runat="server" visible="false">
        <br />
        <h4>View Application/Certificate details</h4>
        <hr />
        <asp:GridView ID="grdHostelSectionCertificatesView" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
            DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false">
            <HeaderStyle />
            <EmptyDataTemplate>
                <label class="lbl">No Application found in the system !</label>
            </EmptyDataTemplate>
            <AlternatingRowStyle CssClass="alt" />
            <Columns>
                <%--   <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 + "." %>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:BoundField DataField="RollNo" HeaderText="Roll No">
                    <HeaderStyle />
                </asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name">
                    <HeaderStyle />
                </asp:BoundField>
                <asp:BoundField DataField="CertificateType" HeaderText="Certificate">
                    <HeaderStyle />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Payment">
                    <ItemTemplate>
                        <asp:Label ID="lblPayment" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}">
                    <HeaderStyle />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Is Verified" HeaderStyle-CssClass="headerWidth">
                    <ItemTemplate>
                        <asp:Label ID="lblVerified" runat="server" Text='<%# Boolean.Parse(Eval("IsHostelSectionVerified").ToString()) ? "Yes" : "No" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="HostelSectionRemarks" HeaderText="Remarks">
                    <HeaderStyle />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
        <div class="mb-4 row">
            <label class="col-sm-3"></label>
            <div class="col-sm-9" style="text-align: right;">
                <asp:Button ID="btnBack" runat="server" Text="Back to Student Application Details" OnClick="btnBack_Click" />
            </div>
        </div>
    </div>
    <div id="dvAcdGrid" runat="server">
        <ajaxToolkit:Accordion ID="Accordion1" runat="server" HeaderCssClass="headerCssClass" ContentCssClass="contentCssClass" HeaderSelectedCssClass="headerSelectedCss"
            FadeTransitions="true" TransitionDuration="700" AutoSize="None" SelectedIndex="0">
            <Panes>
                <ajaxToolkit:AccordionPane ID="AccordionPane1" runat="server">
                    <Header>Fresh Applications <strong>(<span id="countFreshApplication" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Fresh Applications</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdHostelFreshApplicationDetails" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
                                        DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false" OnRowCommand="grdHostelApplicationDetails_RowCommand"
                                        OnRowDataBound="grdHostelApplicationDetails_RowDataBound" AllowPaging="true" AllowSorting="true"
                                        OnSorting="grdHostelFreshApplicationDetails_Sorting" OnPageIndexChanging="grdHostelFreshApplicationDetails_PageIndexChanging" PageSize="10">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Fresh Application found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No" SortExpression="RollNo">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate" SortExpression="CertificateType">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Payment" SortExpression="PaymentStatus">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}" SortExpression="AppliedOn">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Is Verified" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVerified" runat="server" Text='<%# Boolean.Parse(Eval("IsHostelSectionVerified").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExamSectionRemarks" runat="server" Text='<%# Eval("TruncatedHostelRemarks")%>' ToolTip='<%# Eval("HostelSectionRemarks")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("Id") + ";" + Eval("Name") + ";" + Eval("CertificateType") + ";" + 
                                Eval("IsAdminSectionVerified") + ";" + Eval("IsExamSectionVerified") + ";" + Eval("Parentage") + ";" +   Eval("dob", "{0:dd/MMM/yyyy}")+ ";" + 
                      Eval("HostelSectionVerifiedOn", "{0:dd/MMM/yyyy}")    + ";" + Eval("HostelSectionRemarks")+ ";" + Eval("AppliedOn", "{0:dd/MMM/yyyy}")
                      + ";" + Eval("IsLibrarySectionVerified") + ";" + Eval("IsPhysicalEduSectionVerified") + ";" + Eval("IsHostelSectionVerified")%>'
                                                        CommandName="EditRecord" Text="Edit" ToolTip="Click to update the details"></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%#Eval("Id")%>' CommandName="ViewRecord" Text="View" ToolTip="Click to view the details"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="AccordionPane2" runat="server">
                    <Header>Overdue Applications <strong>(<span id="countOverdueApplications" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Overdue Applications</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdHostelOverdueApplicationDetails" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
                                        DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false" OnRowCommand="grdHostelApplicationDetails_RowCommand"
                                        OnRowDataBound="grdHostelApplicationDetails_RowDataBound" AllowPaging="true" AllowSorting="true"
                                        OnSorting="grdHostelOverdueApplicationDetails_Sorting" OnPageIndexChanging="grdHostelOverdueApplicationDetails_PageIndexChanging" PageSize="10">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Overdue Application found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No" SortExpression="RollNo">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate" SortExpression="CertificateType">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Payment" SortExpression="PaymentStatus">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}" SortExpression="AppliedOn">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Is Verified" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVerified" runat="server" Text='<%# Boolean.Parse(Eval("IsHostelSectionVerified").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExamSectionRemarks" runat="server" Text='<%# Eval("TruncatedHostelRemarks")%>' ToolTip='<%# Eval("HostelSectionRemarks")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("Id") + ";" + Eval("Name") + ";" + Eval("CertificateType") + ";" +
                                Eval("IsAdminSectionVerified") + ";" + Eval("IsExamSectionVerified") + ";" + Eval("Parentage") + ";" + Eval("dob", "{0:dd/MMM/yyyy}") + ";" +
                                Eval("HostelSectionVerifiedOn", "{0:dd/MMM/yyyy}")+ ";" + Eval("HostelSectionRemarks") + ";" + Eval("AppliedOn", "{0:dd/MMM/yyyy}")
                                + ";" + Eval("IsLibrarySectionVerified") + ";" + Eval("IsPhysicalEduSectionVerified") + ";" + Eval("IsHostelSectionVerified")%>'
                                                        CommandName="EditRecord" Text="Edit" ToolTip="Click to update the details"></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%#Eval("Id")%>' CommandName="ViewRecord" Text="View" ToolTip="Click to view the details"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="AccordionPane3" runat="server">
                    <Header>Verified Applications <strong>(<span id="countVerifiedApplications" runat="server">0</span>)</strong></Header>
                    <Content>
                        <strong><u>Details of Verified Applications</u></strong>
                        <table class="tblcss">
                            <tr>
                                <td>
                                    <asp:GridView ID="grdHostelVerifiedApplicationDetails" CellPadding="0" CellSpacing="0" CssClass="table table-bordered table-striped"
                                        DataKeyNames="Id" GridLines="None" runat="server" AutoGenerateColumns="false" OnRowCommand="grdHostelApplicationDetails_RowCommand"
                                        OnRowDataBound="grdHostelApplicationDetails_RowDataBound" AllowPaging="true" AllowSorting="true"
                                        OnSorting="grdHostelVerifiedApplicationDetails_Sorting" OnPageIndexChanging="grdHostelVerifiedApplicationDetails_PageIndexChanging" PageSize="50">
                                        <HeaderStyle />
                                        <EmptyDataTemplate>
                                            <label class="lbl">No Verified Application found in the system !</label>
                                        </EmptyDataTemplate>
                                        <AlternatingRowStyle CssClass="alt" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="S No." HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 + "." %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="RollNo" HeaderText="Roll No" SortExpression="RollNo">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CertificateType" HeaderText="Certificate" SortExpression="CertificateType">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Payment" SortExpression="PaymentStatus">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Boolean.Parse(Eval("PaymentStatus").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="AppliedOn" HeaderText="Applied On" DataFormatString="{0:dd-MMM-yyyy}" SortExpression="AppliedOn">
                                                <HeaderStyle />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Is Verified" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVerified" runat="server" Text='<%# Boolean.Parse(Eval("IsHostelSectionVerified").ToString()) ? "Yes" : "No" %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExamSectionRemarks" runat="server" Text='<%# Eval("TruncatedHostelRemarks")%>' ToolTip='<%# Eval("HostelSectionRemarks")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="headerWidth">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%#Eval("Id") + ";" + Eval("Name") + ";" + Eval("CertificateType") + ";" + 
                                Eval("IsAdminSectionVerified") + ";" + Eval("IsExamSectionVerified") + ";" + Eval("Parentage") + ";" + Eval("dob", "{0:dd/MMM/yyyy}") + ";" + 
                                Eval("HostelSectionVerifiedOn", "{0:dd/MMM/yyyy}")+ ";" + Eval("HostelSectionRemarks")+ ";" + Eval("AppliedOn", "{0:dd/MMM/yyyy}")
                                + ";" + Eval("IsLibrarySectionVerified") + ";" + Eval("IsPhysicalEduSectionVerified") + ";" + Eval("IsHostelSectionVerified")%>'
                                                        CommandName="EditRecord" Text="Edit" ToolTip="Click to update the details"></asp:LinkButton>
                                                    <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%#Eval("Id")%>' CommandName="ViewRecord" Text="View" ToolTip="Click to view the details"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Right" CssClass="GridPager" />
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

