<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PAP.Site.Authentication.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-bottom">
        <div class="container">
            <a class="navbar-brand" href="#">G.E.T</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="Home.aspx">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Login.aspx">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../ContactUs/ContactUs.aspx">Contacte-nos</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="sidenav" runat="server">
        <div class="login-main-text">
            <h2>G.E.T</h2>
            <br />
            <h3>Gestor de equipamento informático</h3>
            <p>Faça Login para aceder à aplicação.</p>
        </div>
    </div>
    <div class="main" runat="server">
        <div class="col-md-6 col-sm-12">
            <div class="login-form">
                <form runat="server">
                    <div class="form-group">
                        <label>Username</label>
                        <asp:TextBox ID="tbxUsername" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o username" Text="*" ControlToValidate="tbxUsername" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <asp:TextBox ID="tbxPassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário a password" Text="*" ControlToValidate="tbxPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
                    <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
                    <br />
                    <br />
                    <asp:Button ID="btLogin" Text="Login" runat="server" CssClass="btn btn-primary" OnClick="btLogin_Click" />
                    <br />
                    <asp:HyperLink NavigateUrl="~/PwdMgmt/NewPasswordRequest.aspx" runat="server">Esqueceu-se da password?</asp:HyperLink>
                    <br />
                </form>
            </div>
        </div>
    </div>
</body>
<script src="../Scripts/jquery-3.4.1.min.js"></script>
<script src="../Scripts/bootstrap.min.js"></script>
</html>
