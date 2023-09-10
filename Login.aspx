<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" MasterPageFile="~/ModuleSiteOut.Master" Inherits="Certificates.Login" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript" src='https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
    <script type="text/javascript" src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
    <link rel="stylesheet" href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css'
        media="screen" />

    <div style="max-width: 700px;" id="dvLogin" runat="server">
        <h2 style="text-align:center !important">
        
     <asp:Label ID="lblError" runat="server" CssClass="lbl" Font-Size="14" ></asp:Label>
            </h2>
        <h3 class="form-signin-heading" style="text-align:center">Login Details</h3>
        <hr style="border: 2px solid green;  border-radius: 5px;" />
        <br />
        <asp:Label Text="UserName" ID="lblUserName" runat="server" AssociatedControlID="txtUserName" />
        <asp:TextBox ID="txtUserName" runat="server" TextMode="Email" CssClass="form-control" placeholder="Enter UserName" required="required" />
        <br />
        <asp:Label Text="Password" ID="lblPassword" runat="server" AssociatedControlID="txtPassword" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
            CssClass="form-control" placeholder="Enter Password" required="required" />
        <br />
        <div class="text-center">
            <asp:Button ID="btnLogin" runat="server" Text="LogIn" OnClick="btnLogin_Click" CssClass="btn btn-primary" />
            <br />
            <br />
            <a href="Registration/Registration.aspx">Click here to Sign Up</a>
        </div>
        <br />
       
    </div>
</asp:Content>
