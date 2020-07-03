<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/the-big-picture.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
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
                            <a class="nav-link" href="#">Home</a>
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

        <!-- Page Content -->
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <asp:Label Text="G.E.T" CssClass="mt-5 shadow" runat="server" Font-Size="60pt" Font-Bold="True" />
                        <br />
                        <asp:Label Text="Gestor de Equipamento Tecnológico" CssClass="mt-5 shadow" runat="server" Font-Size="20pt" Font-Bold="True" />
                        
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/bootstrap.bundle.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
</body>
</html>
