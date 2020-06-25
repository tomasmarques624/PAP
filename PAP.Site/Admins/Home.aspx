<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Admins.Home1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Custom2Styles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/styles.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div style="text-align: center">
            <h2>G.E.T - Gestor de Equipamento Informático</h2>
            <h4>Admin Menu - Bem vindo(a) <%= Session["username"].ToString() %></h4>
        </div>
        <div class="menu">
            <a href="Equips/Home.aspx" class="yellow">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Equips.png"/>
                Inventário
            </a>
            <a href="Denuncias/Denuncias.aspx" class="green">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Denuncias.png"/>
                Denuncias
            </a>
            <a href="Requisicoes/RequisicoesGrid.aspx" class="pink">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Reservas.png"/>
                Reservas
            </a>
            <a href="Cat/EquipCat.aspx" class="purple">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Cat.png"/>
                Categorias
            </a>
            <a href="Salas/SalasGrid.aspx" class="blue"><img style="width: 94px; height: 86px" src="../Content/Imagens/Salas.png"/>
                <br />
                Salas
            </a>
            <a href="Users/Users.aspx" class="orange">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Users.png"/>
                Utilizadores
            </a>
        </div>
    </form>
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    
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
