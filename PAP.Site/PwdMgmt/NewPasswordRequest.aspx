<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPasswordRequest.aspx.cs" Inherits="PAP.Site.PwdMgmt.NewPasswordRequest" %>

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
                    <li class="nav-item">
                        <a class="nav-link" href="../Authentication/Home.aspx">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Authentication/Login.aspx">Login</a>
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
            <h1>G.E.T</h1>
            <br />
            <h3>Gestor de Equipamento Tecnológico</h3>
            <p>Coloque o seu email para pedir uma reposição de password.</p>
            <p></p>
            <img src="../Content/Imagens/teste.png" />
        </div>
    </div>
    <div class="main" runat="server">
        <div class="col-md-6 col-sm-12">
            <div class="login-form">
                <form runat="server">
                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="tbxEmail" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o email" Text="*" ControlToValidate="tbxEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
                    <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
                    <br />
                    <br />
                    <asp:Button ID="btPedir" Text="Pedir" runat="server" CssClass="btn btn-primary" OnClick="btPedir_Click" />
                </form>
            </div>
        </div>
    </div>
</body>
<script src="../Scripts/jquery-3.5.1.min.js"></script>
<script src="../Scripts/bootstrap.bundle.min.js"></script>
<script src="../Scripts/bootstrap.min.js"></script>
</html>
