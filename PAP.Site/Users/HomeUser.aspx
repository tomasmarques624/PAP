<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeUser.aspx.cs" Inherits="PAP.Site.Admins.HomeUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/styles.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />

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
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div style="text-align: center">
            <h2>G.E.T - Gestor de Equipamento Informatico</h2>
            <h4>Menu - Bem vindo(a) <%= Session["username"].ToString() %></h4>
        </div>
        <div class="menu">
            <a href="../Users/EquipGrid.aspx" class="yellow">Inventario</a>
            <a href="../Users/ResDenu.aspx" class="green">Reservas     &    Denuncias</a>
        </div>
    </form>
</body>
</html>
