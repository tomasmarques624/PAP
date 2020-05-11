<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResDenu.aspx.cs" Inherits="PAP.Site.Users.ResDenu" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LoginRegisterStyles/loginregister.css" rel="stylesheet" />
    <link href="../Content/CustomStyles/LibraryStyles/custom_style.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <asp:HiddenField ID="id_equip" runat="server" />
        <asp:HiddenField ID="id_req" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">G.E.T</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText"
                aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="../Users/EquipGrid.aspx">Equipamentos<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Reservas & Denuncias</a>
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
        <div>
            <div id="content-page">
                <h3>Reservas</h3>
                <h5>Filtros</h5>
            </div>
            <br />
            <div style="margin-left: 20px">
                <asp:GridView ID="gvReqList" DataKeyNames="id_requisicao" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    OnRowDataBound="gvReqList_RowDataBound"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="150px">

                    <Columns>
                        <asp:BoundField DataField="id_requisicao" ReadOnly="true" HeaderText="ID" />

                        <asp:BoundField DataField="data_requisicao" HeaderText="Data Inicial da Reserva" DataFormatString="{0:MM/dd/yyyy}" />

                        <asp:BoundField DataField="data_requisicao_final" HeaderText="Data Final da Reserva" DataFormatString="{0:MM/dd/yyyy}" />

                        <asp:TemplateField HeaderText="Estado da Requisicao">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEstado" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Equipamento">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEquip" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Denunciar Equipamento">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkDenu" runat="server" Text="Denunciar" OnClick="lkDenu_Click" CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cancelar Requisicao">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btCancelar" Text="X" CssClass="btn btn-danger" CausesValidation="false" OnClick="btCancelar_Click"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div>
            <div id="content-page">
                <h3>Denuncias</h3>
                <h5>Filtros</h5>
            </div>
            <br />
            <div style="margin-left: 20px">
                <asp:GridView ID="gvDenuList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" OnRowDataBound="gvDenuList_RowDataBound" Height="170px">

                    <Columns>
                        <asp:BoundField DataField="id_denuncia" ReadOnly="true" HeaderText="ID" />

                        <asp:BoundField DataField="problema" HeaderText="Problema" />

                        <asp:BoundField DataField="data_denuncia" HeaderText="Data da Denuncia" DataFormatString="{0:MM/dd/yyyy}" />

                        <asp:TemplateField HeaderText="Estado da Denuncia">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEstadoD" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Equipamento">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEquipD" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="QR Code">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkQrCode" runat="server" Text="Ver QR Code" OnClick="lkQrCode_Click" CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <!-- Modal Remover -->
    <asp:Button ID="btRemover" runat="server"  Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende cancelar esta reserva?"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server"  CssClass="btn btn-success" CausesValidation="False" OnClick="btSimRe_Click" />
        <asp:Button ID="btNaoRe" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click"/>
    </asp:Panel>

        <!-- Modal Nova Denuncia -->
        <asp:Button ID="btNewDenu" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Denu" runat="server" BehaviorID="MPE_Denu"
            DynamicServicePath="" TargetControlID="btNewDenu" PopupControlID="pnlDenu"
            CancelControlID="btNaoDenu" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlDenu" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Label ID="lbDenu" runat="server" Text="Denunciar Equipamento"></asp:Label>
            <br />
            <table>
                <tr>
                    <td>Problema :</td>
                    <td>
                        <asp:TextBox CssClass="form-control" ID="tbxProb" runat="server" Height="145px" Width="100%" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator ID="rfvProb" runat="server" ErrorMessage="É necessário um problema." Text="*" ControlToValidate="tbxProb" ForeColor="Red" Enabled="false"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" DisplayMode="BulletList" CssClass="validationsummary" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btSimDenu" Text="Inserir" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimDenu_Click" />
                        <asp:Button ID="btNaoDenu" Text="Cancelar" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoDenu_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <!-- Modal QR Code -->
        <asp:Button ID="btQrCode" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_QrCode" runat="server" BehaviorID="MPE_QrCode"
            DynamicServicePath="" TargetControlID="btQrCode" PopupControlID="pnlQrCode"
            CancelControlID="btNaoQrCode" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlQrCode" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
            <asp:Button ID="btSimQrCode" Text="Imprimir" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btSimQrCode_Click" Visible="false" />
            <asp:Button ID="btNaoQrCode" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
        </asp:Panel>

    </form>
</body>
</html>
