<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Certificates.Registration" MasterPageFile="/ModuleSiteOut.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css'
        media="screen" />
    <div style="max-width: 500px;">
        <h2 class="form-signin-heading">Registration</h2>
        <asp:Label Text="Name" runat="server" AssociatedControlID="txtName" />
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Name" required="required" />
        <br />
        <asp:Label Text="Email" runat="server" AssociatedControlID="txtEmail" />
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="Enter Email" required="required" />
        <br />
        <asp:Label Text="Password" runat="server" AssociatedControlID="txtPassword" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ToolTip="Password must contain: Minimum 8 characters at-least 1 Alphabet and 1 Number"
            CssClass="form-control" placeholder="Enter Password" required="required" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" />
        <br />
        <asp:Label Text="Confirm Password" runat="server" AssociatedControlID="txtConfirmPassword" />
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm Password" required="required" />
        <br />
        <asp:Label Text="PhoneNo" runat="server" AssociatedControlID="txtPhoneNo" />
        <asp:TextBox ID="txtPhoneNo" runat="server" CssClass="form-control" placeholder="Mobile No. (10-digits only)" MaxLength="10"/>
        <asp:RegularExpressionValidator ID="revPhoneNo" ControlToValidate="txtPhoneNo" CssClass="lbl" runat="server" Display="Dynamic"
            ErrorMessage="Enter valid Mobile No." ValidationExpression="^[6-9]\d{9}$"></asp:RegularExpressionValidator>
        <br />
        <div style="display:none;">
        <asp:Label Text="UserType" runat="server" AssociatedControlID="ddlUserType" />

        <asp:DropDownList ID="ddlUserType" runat="server" AutoPostBack="true" CssClass="form-control"
            OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged">
            <asp:ListItem Text="Candidate" Value="CandidateX"></asp:ListItem>
            <asp:ListItem Text="Department" Value="DepartmentX" Selected="True"></asp:ListItem>
        </asp:DropDownList>

        <br />
        <div id="dvRollNo" runat="server" visible="true">
            <asp:Label Text="Roll No" runat="server" AssociatedControlID="txtRollNo" />
            <asp:TextBox ID="txtRollNo" runat="server" CssClass="form-control" placeholder="Enter Roll No." Text="" onkeydown="return (!(event.keyCode>=65) && event.keyCode!=32);" />

            <br />
        </div>
            </div>
        <div id="dvDepartmentType" runat="server">
            <asp:Label Text="Department Type" runat="server" AssociatedControlID="ddlDepartmentType" />
            <asp:DropDownList ID="ddlDepartmentType" runat="server" CssClass="form-control">
                <asp:ListItem Text="Super Admin" Value="SAdmin" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Admission Department" Value="ADept"></asp:ListItem>
                <asp:ListItem Text="Examination Department" Value="EDept"></asp:ListItem>
                <asp:ListItem Text="Library Department" Value="LDept"></asp:ListItem>
                <asp:ListItem Text="Hostel Department" Value="HDept"></asp:ListItem>
                <asp:ListItem Text="Physical Education Department" Value="PEDept"></asp:ListItem>
                <asp:ListItem Text="Certificate Department" Value="CDept"></asp:ListItem>
            </asp:DropDownList>
            <br />
        </div>
        <div class="text-center">
            <asp:Button ID="btnSignup" runat="server" Text="Sign up" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
            <br />
            <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
        </div>

    </div>
    <script type="text/javascript">
    window.onload = function () {
        var txtPassword = document.getElementById("<%=txtPassword.ClientID%>");
        var txtConfirmPassword = document.getElementById("<%=txtConfirmPassword.ClientID%>");
        txtPassword.onchange = ConfirmPassword;
        txtConfirmPassword.onkeyup = ConfirmPassword;
        function ConfirmPassword() {
            txtConfirmPassword.setCustomValidity("");
            if (txtPassword.value != txtConfirmPassword.value) {
                txtConfirmPassword.setCustomValidity("Passwords do not match.");
            }
        }
    }
    </script>

</asp:Content>
