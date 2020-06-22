<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AcessoNegado.aspx.cs" Inherits="PAP.Site.Admins.AcessoNegado" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Acesso Negado</title>
	<link href="https://fonts.googleapis.com/css?family=Quicksand:700" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/font_403.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/style_403.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="notfound">
		<div class="notfound">
			<div class="notfound-bg">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<h1>oops!</h1>
			<h2>Erro 403 : Acesso Negado</h2>
			<a href='javascript:history.go(-1)'>Voltar</a>
		</div>
	</div>
    </form>
</body>
</html>
