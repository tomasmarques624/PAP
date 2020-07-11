<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeUser.aspx.cs" Inherits="PAP.Site.Admins.HomeUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Página Inicial</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Custom2Styles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/styles.css" rel="stylesheet" />
    <link href="../Content/alertifyjs/alertify.css" rel="stylesheet" />
    <script src="../Scripts/alertify.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div style="text-align: center">
            <h2>G.E.T - Gestor de Equipamento Tecnológico</h2>
            <h4>Menu - Bem vindo(a) <%= Session["username"].ToString() %></h4>
        </div>
        <div class="menu">
            <a href="EquipGrid.aspx" class="yellow" style="height: 246px;line-height:123px;">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Equips.png"/>
                Equipamentos
            </a>
            <a href="ResDenu.aspx" class="green">
                <img style="width: 94px; height: 86px" src="../Content/Imagens/Reservas.png"/>
                Denuncias & Reservas
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
