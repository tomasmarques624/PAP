<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="PAP.Site.ContactUs.ContactUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/alertifyjs/alertify.css" rel="stylesheet" />
    <script src="../../Scripts/alertify.js"></script>
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
                    <li class="nav-item active">
                        <a class="nav-link" href="ContactUs.aspx">Contacte-nos</a>
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
            <p>Contacte-nos para resolver algum problema ou sugerir algo.</p>
            <p></p>
            <img src="../Content/Imagens/teste.png" />
        </div>
    </div>
    <div class="main" runat="server">
        <div class="col-md-2 col-sm-4">
            <div class="login-form">
                <form runat="server">
                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="tbxEmail" CssClass="form-control" runat="server" Width="600"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o email" Text="*" ControlToValidate="tbxEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Nome</label>
                        <asp:TextBox ID="tbxNome" CssClass="form-control" runat="server" Width="600"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um nome" Text="*" ControlToValidate="tbxNome" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Assunto</label>
                        <asp:TextBox ID="tbxAssunto" CssClass="form-control" runat="server" Width="600"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um assunto" Text="*" ControlToValidate="tbxAssunto" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label>Mensagem</label>
                        <asp:TextBox ID="tbxMensagem" CssClass="form-control" runat="server" Height="145px" Width="600" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma mensagem" Text="*" ControlToValidate="tbxMensagem" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" Font-Size="12pt" />
                    <br />
                    <asp:Button ID="btEnviar" Text="Enviar" runat="server" CssClass="btn btn-primary" OnClick="btEnviar_Click" />
                </form>
            </div>
        </div>
    </div>
</body>
<script src="../../Scripts/jquery-3.5.1.min.js"></script>
<script src="../../Scripts/popper.min.js"></script>
<script src="../../Scripts/bootstrap.min.js"></script>

</html>