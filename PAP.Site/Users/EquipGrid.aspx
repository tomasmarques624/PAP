<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipGrid.aspx.cs" Inherits="PAP.Site.Users.EquipGrid" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">G.E.T</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText"
                aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Equipamentos<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Users/ResDenu.aspx">Reservas & Denuncias</a>
                    </li>
                </ul>
                <span class="navbar-text">Bem vindo(a) <%= Session["username"].ToString() %>
                </span>
            </div>
            <div style="padding-left: 1rem">
                <asp:Button ID="buttonLogout" Text="Logout" CssClass="btn btn-secondary" runat="server" OnClick="buttonLogout_Click" CausesValidation="False" />
            </div>
        </nav>
        <div class="jumbotron">
            <h2>G.E.T - Gestor de Equipamento Informatico</h2>
        </div>
        <asp:HiddenField ID="id_equip" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <div id="content-page">
                <h3>Inventario</h3>
                <h5>Filtros</h5>
            </div>
            <br />
            <div style="margin-left: 20px">
                <asp:GridView ID="gvEquipList" AutoGenerateColumns="False" DataKeyNames="id_equip" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="170px" OnRowDataBound="gvEquipList_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="id_equip" ReadOnly="true" HeaderText="ID" />
                        <asp:BoundField DataField="descri" HeaderText="Descricao" />

                        <asp:TemplateField HeaderText="Categoria">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbCategoria" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sala">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbSala" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Reservar">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkReservar" runat="server" Text="Reservar" OnClick="lkReservar_Click" CausesValidation="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
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
                        <asp:DropDownList ID="ddlNDias" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlNDias_SelectedIndexChanged">
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
                        <asp:Button ID="btSimReq" Text="Inserir" runat="server" OnClick="btSimReq_Click" CssClass="btn btn-success" CausesValidation="False" />
                        <asp:Button ID="btNaoReq" Text="Cancelar" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoReq_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-3.4.1.min.js"></script>
    <script src="../Scripts/popper.min.js"></script>
</body>
</html>
