<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfileUser.aspx.cs" Inherits="PAP.Site.Users.ProfileUser" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Perfil</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/alertifyjs/alertify.css" rel="stylesheet" />
    <script src="../Scripts/alertify.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <a class="navbar-brand" href="HomeUser.aspx">G.E.T</a>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item " id="navLinkHome" runat="server">
                        <a class="nav-link" href="#">Equipamentos<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item" id="navLinkDenuncias" runat="server">
                        <a class="nav-link" href="ResDenu.aspx">Reservas & Denuncias</a>
                    </li>

                </ul>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown" id="Li2" runat="server">
                            <a class="nav-link dropdown-toggle" href="#" id="navbardrop4" data-toggle="dropdown"><%= Session["username"].ToString() %>
                            </a>
                            <div class="dropdown-menu">
                                <a class="nav-link" href="ProfileUser.aspx" style="color: dimgrey;">Perfil</a>
                                <asp:Button ID="buttonLogout" Text="Logout" CssClass="btn btn-link" runat="server" ForeColor="DimGray" OnClick="buttonLogout_Click" CausesValidation="False" />
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="content-page" style="margin-left: 20px">
            <div class="container bootstrap snippet">
                <div class="row">
                    <div class="col-sm-10" style="height: 80px">
                        <asp:Label Text="" runat="server" CssClass="titulo" ID="lbTitulo" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3">
                        <!--left col-->

                        <div class="text-center">
                            <asp:Image ID="avatar" CssClass="avatar img-circle img-thumbnail" runat="server" />
                        </div>
                        <br>
                    </div>
                    <!--/col-3-->

                    <div class="col-sm-9">

                        <div class="tab-content">
                            <div class="tab-pane active" id="home">
                                <hr>
                                    <div class="form-group">

                                        <div class="col-xs-6">
                                            <label for="first_name">
                                                <h4>Username</h4>
                                            </label>
                                            <br />
                                            <asp:Label ID="lbUsername" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <div class="col-xs-6">
                                            <label for="last_name">
                                                <h4>Nome</h4>
                                            </label>
                                            <br />
                                            <asp:Label ID="lbNome" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <div class="col-xs-6">
                                            <label for="last_name">
                                                <h4>Email</h4>
                                            </label>
                                            <br />
                                            <asp:Label ID="lbEmail" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <div class="col-xs-6">
                                            <label for="last_name">
                                                <h4>Password</h4>
                                            </label>
                                            <br />
                                            <asp:Label ID="lbPassword" runat="server" Text="**********"></asp:Label>
                                            <asp:Button Text="Alterar" Style="float: right;" runat="server" CssClass="btn btn-outline-dark" ID="btAltPass" OnClick="btAltPass_Click" />
                                        </div>
                                    </div>
                                <br />
                                <hr>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Alterar Pass -->
        <asp:Button ID="btPass" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Pass" runat="server" BehaviorID="MPE_Pass"
            DynamicServicePath="" TargetControlID="btPass" PopupControlID="pnlPass"
            CancelControlID="btNao" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlPass" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <h3>Alterar Password</h3>
            <br />
            <table>
                <tr>
                    <td>Password Atual:</td>
                    <td>
                        <asp:TextBox ID="tbxPassAtual" CssClass="form-control" TextMode="Password" runat="server" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ErrorMessage="É necessário a password atual!" Enabled="false" Text="*" ControlToValidate="tbxPassAtual" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Nova Password:</td>
                    <td>
                        <asp:TextBox ID="tbxPassNova" CssClass="form-control" TextMode="Password" runat="server" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ErrorMessage="É necessário a password nova!" Enabled="false" Text="*" ControlToValidate="tbxPassNova" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Confirmar Nova Password:</td>
                    <td>
                        <asp:TextBox ID="tbxPassConfirmar" CssClass="form-control" TextMode="Password" runat="server" Width="100%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPass" runat="server" Enabled="false" ErrorMessage="É necessário confirmar a password nova." Text="*" ControlToValidate="tbxPassConfirmar" ForeColor="Red"></asp:RequiredFieldValidator>

                        <asp:CompareValidator ErrorMessage="As passwords novas não são iguais!" ControlToValidate="tbxPassConfirmar"
                            ControlToCompare="tbxPassNova" Operator="Equal" Text="*" runat="server" ForeColor="Red" ID="cvPass" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" DisplayMode="BulletList" CssClass="validationsummary" ID="ValSum" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btSim" Text="Alterar" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSim_Click"  />
                        <asp:Button ID="btNao" Text="Cancelar" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNao_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
</body>
</html>