<%@ Page Title="Apply Certificate(s)" Language="C#" MasterPageFile="~/ModuleSite.Master" AutoEventWireup="true" CodeBehind="ApplyCertificates.aspx.cs"
    Inherits="Certificates.ApplyCertificates" EnableViewState="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
    
    <div id="chkDetails" runat="server">
        <div class="mb-4 row">
            <label for="txtRollNo" class="col-sm-4 txt"><span class="RequiredField">* </span>Roll No.</label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtRollNo" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRollNo" runat="server" CssClass="lbl" ErrorMessage="Enter Roll No"
                    ControlToValidate="txtRollNo" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revRollNo" ControlToValidate="txtRollNo" CssClass="lbl" runat="server" Display="Dynamic"
                    ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="mb-4 row">
            <label for="txtPhoneNo" class="col-sm-4 txt"><span class="RequiredField">* </span>Phone No.</label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtPhoneNo" runat="server" CssClass="form-control" placeholder="Mobile No. (10-digits only)" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhoneNo" runat="server" CssClass="lbl" ErrorMessage="Enter Phone No"
                    ControlToValidate="txtPhoneNo" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtPhoneNo" CssClass="lbl" runat="server" Display="Dynamic"
                    ErrorMessage="Enter valid Mobile No." ValidationExpression="^[6-9]\d{9}$"></asp:RegularExpressionValidator>
            </div>
            <div class="col-sm-3">
                <asp:Button ID="btnGetOTP" runat="server" Text="Get OTP" ToolTip="Click here to get OTP"
                    OnClick="btnGetOTP_Click" />
            </div>
        </div>
        <div class="mb-4 row" id="dvCheckDetails" runat="server" visible="false">
            <label for="btnCheckDetails" class="col-sm-4 txt"></label>
            <div class="col-sm-3">
                <asp:TextBox ID="txtValidateOTP" runat="server" CssClass="form-control" placeholder="Enter Received OTP  (1234)" MaxLength="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv_OTP" runat="server" CssClass="lbl" ErrorMessage="Enter OTP"
                    ControlToValidate="txtValidateOTP" Display="Dynamic" Visible="false"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="rfv_OTP2" ControlToValidate="txtValidateOTP" CssClass="lbl" runat="server" Display="Dynamic"
                    ErrorMessage="Enter valid OTP" ValidationExpression="^[0-9]\d{3}$"></asp:RegularExpressionValidator>
                <asp:Label ID="lblInvalidOTP" runat="server" CssClass="lbl" Font-Size="12"></asp:Label>
                <asp:Button ID="btnCheckDetails" runat="server" Text="Check your details" ToolTip="Click here to get your details"
                    OnClick="btnCheckDetails_Click" CssClass="btn"></asp:Button>
            </div>
        </div>
    </div>
    <div id="dvNOPref" runat="server">
    </div>
    
        <h4>Check your details</h4>
        <hr />
    <asp:GridView ID="grdStudentsDetail" CellPadding="0" CellSpacing="0" CssClass="table"
        DataKeyNames="classrollno" GridLines="None" runat="server" AutoGenerateColumns="false">
        <HeaderStyle />
        <EmptyDataTemplate>
            <label class="lbl">No such Roll No. found in our system !</label>
        </EmptyDataTemplate>
        <AlternatingRowStyle CssClass="alt" />
        <Columns>
            <asp:BoundField DataField="classrollno" HeaderText="Roll No">
                <HeaderStyle />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Name" HeaderStyle-CssClass="headerWidth">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "name")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="email" HeaderText="Email">
                <HeaderStyle />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Programme" ItemStyle-Width="20%">
                <ItemTemplate>
                    <asp:Label ID="lblCourseapplied" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Courseapplied")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div id="dvCertificates" runat="server" visible="false">
        <br />
        <h4>Select your Certificate</h4>
        <hr />
        <div class="mb-4 row">
            <label for="drpCertificates" class="col-sm-3 txt"><span class="RequiredField">* </span>Select Certificate</label>
            <div class="col-sm-8">
                <asp:DropDownList ID="drpCertificates" runat="server" CssClass="form-control drp">
                    <asp:ListItem Text="Select Certificate" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="Provisional cum Character Certificate" Value="ProvCharCert"></asp:ListItem>
                  <%--   <asp:ListItem Text="Character Certificate" Value="2"></asp:ListItem>--%>
                    <asp:ListItem Text="Discharge/Transfer Certificate" Value="DischargeCert"></asp:ListItem>
                    <asp:ListItem Text="Migration Certificate" Value="MigrationCert"></asp:ListItem>                  
                    <asp:ListItem Text="Bonafide/Studentship Certificate" Value="BonaStudCert"></asp:ListItem>
                      <asp:ListItem Text="Marks Certificate" Value="MarksCert"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvdrpCertificates" runat="server" CssClass="lbl" ErrorMessage="Select Certificate" InitialValue="-1"
                    ControlToValidate="drpCertificates" Display="Dynamic" ValidationGroup="ApplyCertificate"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div>
            <div class="col-sm-3">
                <asp:Button ID="btnApplyCertificate" runat="server" CssClass="btn" Text="Apply for Certificate" ValidationGroup="ApplyCertificate" OnClick="btnApplyCertificate_Click" />
            </div>
        </div>
         <asp:Label ID="lblError1" runat="server" CssClass="lbl" Font-Size="14" ForeColor="Red"></asp:Label>
    </div>
    <div>


        <asp:Table ID="AllocationSummary" runat="server" CssClass="table" Style="display: none;">
            <asp:TableHeaderRow>
                <%--      <asp:TableHeaderCell>Subject</asp:TableHeaderCell>--%>
                <asp:TableHeaderCell>Department</asp:TableHeaderCell>
                <asp:TableHeaderCell>Seats</asp:TableHeaderCell>
                <asp:TableHeaderCell>Allocated</asp:TableHeaderCell>
            </asp:TableHeaderRow>
        </asp:Table>


        <asp:GridView ID="GridView1" CellPadding="0" CellSpacing="0" CssClass="table" Style="display: none;"
            GridLines="None" runat="server" AutoGenerateColumns="true">
            <HeaderStyle />
        </asp:GridView>

    </div>
</asp:Content>

