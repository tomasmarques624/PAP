<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="PAP.Site.ContactUs.ContactUs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
</head>
<body>
    <div class="sidenav" runat="server">
         <div class="login-main-text">
            <h2>G.E.T</h2>
             <br />
             <h3> Gestor de equipamento informatico</h3>
            <p>Contacte-nos para resolver algum problema ou sugerir algo.</p>
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
                   <div class="form-group">
                     <label>Nome</label>
                     <asp:TextBox ID="tbxNome" CssClass="form-control" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um nome" Text="*" ControlToValidate="tbxNome" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                   <div class="form-group">
                     <label>Assunto</label>
                     <asp:TextBox ID="tbxAssunto" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um assunto" Text="*" ControlToValidate="tbxAssunto" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                   <div class="form-group">
                     <label>Mensagem</label>
                     <asp:TextBox ID="tbxMensagem" CssClass="form-control" runat="server" Height="145px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma mensagem" Text="*" ControlToValidate="tbxMensagem" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                   <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
                   <asp:Label Text="" ID="lbMensagem"  runat="server" ForeColor="Red" />
                   <br />
                   <br />
                  <asp:Button id="btEnviar" Text="Enviar" runat="server" CssClass="btn btn-primary" onclick="btEnviar_Click" />
                  <asp:HyperLink ID="hlLogin" runat="server" text="Cancelar" CssClass="btn btn-secondary" NavigateUrl="~/Authentication/Login.aspx"/>
                  <asp:HyperLink ID="hlVoltar" runat="server" Visible="false" NavigateUrl="~/Authentication/Login.aspx">Clique aqui para voltar à página de login.</asp:HyperLink>
               </form>
            </div>
         </div>
      </div>
</body>
<script src="../Scripts/jquery-3.4.1.min.js"></script>
<script src="../Scripts/bootstrap.min.js"></script>
</html>
