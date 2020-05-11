<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Admins.Home1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/styles.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div style="text-align: center">
            <h2>G.E.T - Gestor de Equipamento Informatico</h2>
            <h4>Admin Menu - Bem vindo(a) <%= Session["username"].ToString() %></h4>
        </div>
        <div class="menu">
            <a href="../Admins/Equips/Home.aspx" class="yellow">Inventario</a>
            <a href="../Admins/Denuncias/Denuncias.aspx" class="green">Denuncias</a>
            <a href="../Admins/Requisicoes/RequisicoesGrid.aspx" class="pink">Reservas</a>
            <a href="../Admins/Cat/EquipCat.aspx" class="purple">Categorias</a>
            <a href="../Admins/Salas/SalasGrid.aspx" class="blue">Salas</a>
            <a href="../Admins/Users/Users.aspx" class="orange">Utilizadores</a>
        </div>
    </form>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.menu a').hover(function () {
                $(this).stop().animate({
                    opacity: 1
                }, 300);
            }, function () {
                $(this).stop().animate({
                    opacity: 0.3
                }, 300);
            });
        });
    </script>
</body>
</html>
