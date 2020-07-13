<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipGrid.aspx.cs" Inherits="PAP.Site.Users.EquipGrid" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventário</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/alertifyjs/alertify.css" rel="stylesheet" />
    <script src="../Scripts/alertify.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="id_equip" runat="server" />
        <asp:HiddenField ID="ordcat" runat="server" Value="1" />
        <asp:HiddenField ID="ordsala" runat="server" Value="1" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <a class="navbar-brand" href="HomeUser.aspx">G.E.T</a>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active" id="navLinkHome" runat="server">
                        <a class="nav-link " href="#">Equipamentos<span class="sr-only"></span></a>
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

        <div>
            <div id="content-page" style="margin-left: 20px">
                <h2>Inventário</h2>
                <h5>Filtros</h5>
                <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
                <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged" AutoPostBack="true" Width="230px">
                    <asp:ListItem Text="Descrição" Value="1" Selected="True" />
                    <asp:ListItem Text="Categoria" Value="2" />
                    <asp:ListItem Text="Sala" Value="3" />
                </asp:RadioButtonList>
                <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
                <p></p>
                <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
            </div>
            <br />
            <div style="margin-left: 50px">
                <asp:GridView ID="gvEquipList" AutoGenerateColumns="False" DataKeyNames="id_equip" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="170px" OnRowDataBound="gvEquipList_RowDataBound">

                    <Columns>
                        <asp:BoundField DataField="id_equip" ReadOnly="true" HeaderText="ID" />
                        <asp:BoundField DataField="descri" HeaderText="Descrição" HeaderStyle-Width="150px" />
                    </Columns>

                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label Text="Categoria" runat="server" Width="125px" />
                                <asp:ImageButton runat="server" ImageUrl="../Content/Imagens/Setas.png" Width="15" Height="15" ID="ImageButton1" OnClick="ImageButton1_Click" />
                                &nbsp;
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbCategoria" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label Text="Sala" runat="server" Width="125px" />
                                <asp:ImageButton Text="Sala" runat="server" ImageUrl="../Content/Imagens/Setas.png" Width="15" Height="15" ID="ImageButton2" OnClick="ImageButton2_Click" />
                                &nbsp;
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbSala" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <Columns>
                        <asp:TemplateField HeaderText="Reservar">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkReservar" runat="server" Text="Reservar" OnClick="lkReservar_Click" CausesValidation="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <Columns>
                        <asp:TemplateField HeaderText="Foto">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkFoto" runat="server" Text="Ver Foto" OnClick="lkFoto_Click" CausesValidation="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <p></p>
        <!-- Modal Nova Requisicao -->
        <asp:Button ID="btNewReq" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_NewReq" runat="server" BehaviorID="MPE_NewReq"
            DynamicServicePath="" TargetControlID="btNewReq" PopupControlID="pnlReq"
            CancelControlID="btNaoReq" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlReq" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Label ID="lbReq" runat="server" Text="Reservar Equipamento"></asp:Label>
            <br />
            <table>
                <tr>
                    <td>N Dias da Reserva :</td>
                    <td>
                        <asp:DropDownList ID="ddlNDias" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlNDias_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">Varios</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário escolher um numero de dias." Text="*" ControlToValidate="ddlNDias" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbTxtData" runat="server" Text="Data da Reserva"></asp:Label></td>
                    <td>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbxDataReserva" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvData" runat="server" ErrorMessage="É necessário escolher uma data." Text="*" Enabled="false" ControlToValidate="tbxDataReserva" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTxtDataIni" runat="server" Text="Data Inicial da Reserva" Visible="false"></asp:Label></td>
                    <td>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbxDataReqIni" TextMode="Date" Visible="false" />
                        <asp:RequiredFieldValidator ID="rfvDataIni" runat="server" ErrorMessage="É necessário escolher uma data inicial." Enabled="false" Text="*" ControlToValidate="tbxDataReserva" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTxtDataFin" runat="server" Text="Data Final da Reserva" Visible="false"></asp:Label></td>
                    <td>
                        <asp:TextBox CssClass="form-control" runat="server" ID="tbxDataReqFin" TextMode="Date" Visible="false" />
                        <asp:RequiredFieldValidator ID="rfvDataFin" runat="server" ErrorMessage="É necessário escolher uma data final." Text="*" ControlToValidate="tbxDataReserva" ForeColor="Red" Enabled="false"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" DisplayMode="BulletList" CssClass="validationsummary" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btSimReq" Text="Reservar" runat="server" OnClick="btSimReq_Click" CssClass="btn btn-success" CausesValidation="False" />
                        <asp:Button ID="btNaoReq" Text="Cancelar" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoReq_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <!-- Modal Foto -->
        <asp:Button ID="btFoto" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Foto" runat="server" BehaviorID="MPE_Foto"
            DynamicServicePath="" TargetControlID="btFoto" PopupControlID="pnlFoto"
            CancelControlID="btFechar" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlFoto" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Image ImageUrl="../Content/Imagens/ImgNotFound.png" runat="server" ID="imgFoto" CssClass="img-fluid" />
            <p></p>
            <asp:Button ID="btFechar" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
        </asp:Panel>

        <!-- Modal Erro -->
        <asp:Button ID="btErro" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Erro" runat="server" BehaviorID="MPE_Erro"
            DynamicServicePath="" TargetControlID="btErro" PopupControlID="pnlErro"
            CancelControlID="btOkErro" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlErro" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Label ID="lbErro" Text="" runat="server" ForeColor="Red" />
            <br />
            <asp:Button ID="btOkErro" Text="Ok" runat="server" CssClass="btn btn-info" CausesValidation="False"/>
        </asp:Panel>

    </form>
    <script src="../Scripts/jquery-3.5.1.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
</body>
</html>
