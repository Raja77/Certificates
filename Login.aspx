<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" MasterPageFile="~/ModuleSiteOut.Master" Inherits="Certificates.Login" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css'
        media="screen" />
    <div style="max-width: 500px;">
        <h2 class="form-signin-heading">Login</h2>
        <asp:Label Text="UserName" runat="server" AssociatedControlID="txtUserName" />
        <asp:TextBox ID="txtUserName" runat="server" TextMode="Email" CssClass="form-control" placeholder="Enter UserName" required="required" />
        <br />
        <asp:Label Text="Password" runat="server" AssociatedControlID="txtPassword" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
            CssClass="form-control" placeholder="Enter Password" required="required" />
        <br />

        <div class="text-center">
            <asp:Button ID="btnLogin" runat="server" Text="LogIn" OnClick="btnLogin_Click" CssClass="btn btn-primary" />
            <br />
            <br />
            <asp:LinkButton ID="lnkRegistration" runat="server" PostBackUrl="~/Registration/Registration.aspx">Click here to Sign Up</asp:LinkButton>
        </div>
        <br />
        <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14"></asp:Label>
    </div>
</asp:Content>
