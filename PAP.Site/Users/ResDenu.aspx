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
        <asp:HiddenField ID="id_denu" runat="server" />
        <asp:HiddenField ID="ordest" runat="server" Value="1" />
        <asp:HiddenField ID="ordestado" runat="server" Value="1" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
            <a class="navbar-brand" href="HomeUser.aspx">G.E.T</a>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown" id="navLinkHome" runat="server">
                        <a class="nav-link" href="#">Equipamentos<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active" id="navLinkDenuncias" runat="server">
                        <a class="nav-link" href="ResDenu.aspx">Reservas & Denuncias</a>
                    </li>
                </ul>
                <span class="navbar-text">Bem vindo(a) <%= Session["username"].ToString() %>
                </span>
            </div>
            <div style="padding-left: 1rem">
                <asp:Button ID="button1" Text="Logout" CssClass="btn btn-secondary" runat="server" OnClick="buttonLogout_Click" CausesValidation="False" />
            </div>
        </nav>
        <div>
            <div id="content-page">
                <h2>Reservas</h2>
                <h5>Filtros</h5>
                <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
                <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="Data Inicial" Value="1" Selected="True" />
                    <asp:ListItem Text="Data Final" Value="2" />
                    <asp:ListItem Text="Equipamento" Value="3" />
                </asp:RadioButtonList>
                <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
                <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
            </div>
            <br />
            <div style="margin-left: 20px">
                <asp:GridView ID="gvReqList" DataKeyNames="id_requisicao" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    OnRowDataBound="gvReqList_RowDataBound"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="150px">

                    <Columns>
                        <asp:BoundField DataField="id_requisicao" ReadOnly="true" HeaderText="ID" />
                    </Columns>

                    <Columns>
                        <asp:BoundField DataField="data_requisicao" HeaderText="Data Inicial da Reserva" DataFormatString="{0:MM/dd/yyyy}" />
                    </Columns>

                    <Columns>
                        <asp:BoundField DataField="data_requisicao_final" HeaderText="Data Final da Reserva" DataFormatString="{0:MM/dd/yyyy}" />
                    </Columns>

                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label Text="Estado" runat="server" />
                                &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEstado" OnClick="OrdEstado_Click" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEstado" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <Columns>
                        <asp:TemplateField HeaderText="Equipamento">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEquip" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <Columns>
                        <asp:TemplateField HeaderText="Denunciar Equipamento">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkDenu" runat="server" Text="Denunciar" OnClick="lkDenu_Click" CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <Columns>
                        <asp:TemplateField HeaderText="Cancelar Requisicao">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btCancelar" Text="X" CssClass="btn btn-danger" CausesValidation="false" OnClick="btCancelar_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div>
            <div id="content-page">
                <h2>Denuncias</h2>
                <h5>Filtros</h5>
                <asp:Label ID="Label1" runat="server" Text="Pesquisar por:"></asp:Label>
                <asp:RadioButtonList ID="rblPesqDenu" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
                    <asp:ListItem Text="Problema" Value="1" Selected="True" />
                    <asp:ListItem Text="Data" Value="2" />
                    <asp:ListItem Text="Equipamento" Value="3" />
                </asp:RadioButtonList>
                <asp:TextBox ID="tbxPesqDenu" runat="server" Text="" CssClass="form-control" Width="351px" AutoPostBack="true" OnTextChanged="tbxPesqDenu_TextChanged" />
                <asp:Button ID="btLimparFiltrosDenu" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltrosDenu_Click" />
            </div>
            <br />
            <div style="margin-left: 20px">
                <asp:GridView ID="gvDenuList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" OnRowDataBound="gvDenuList_RowDataBound" Height="170px">

                    <Columns>
                        <asp:BoundField DataField="id_denuncia" ReadOnly="true" HeaderText="ID" />
                    </Columns>
                    <Columns>
                        <asp:BoundField DataField="problema" HeaderText="Problema" />
                    </Columns>
                    <Columns>
                        <asp:BoundField DataField="data_denuncia" HeaderText="Data da Denuncia" DataFormatString="{0:MM/dd/yyyy}" />
                    </Columns>
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label Text="Estado" runat="server" />
                                &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEstadoDenu" OnClick="OrdEstadoDenu_Click" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEstadoD" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <Columns>
                        <asp:TemplateField HeaderText="Equipamento">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lbEquipD" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <Columns>
                        <asp:TemplateField HeaderText="QR Code">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkQrCode" runat="server" Text="Ver QR Code" OnClick="lkQrCode_Click" CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <Columns>
                        <asp:TemplateField HeaderText="Foto">
                            <ItemTemplate>
                                <asp:LinkButton ID="lkFoto" runat="server" Text="Ver Foto" OnClick="lkFoto_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <!-- Modal Remover -->
        <asp:Button ID="btRemover" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
            DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
            CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <br />
        <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende cancelar esta reserva?"></asp:Label>
            <br />
            <asp:Button ID="btSimRe" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimRe_Click" />
            <asp:Button ID="btNaoRe" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click" />
        </asp:Panel>

        <!-- Modal Nova Denuncia -->
        <asp:Button ID="btNewDenu" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Denu" runat="server" BehaviorID="MPE_Denu"
            DynamicServicePath="" TargetControlID="btNewDenu" PopupControlID="pnlDenu"
            CancelControlID="btNaoDenu" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlDenu" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <h3>Reservar Equipamento</h3>
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
                    <td>Foto</td>
                    <td>
                        <asp:FileUpload CssClass="form-control-file" runat="server" ID="fluFoto" />
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

        <!-- Modal Erro -->
        <asp:Button ID="btErro" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Erro" runat="server" BehaviorID="MPE_Erro"
            DynamicServicePath="" TargetControlID="btErro" PopupControlID="pnlErro"
            CancelControlID="btOkErro" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlErro" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Label ID="lbErro" Text="" runat="server" ForeColor="Red" />
            <br />
            <asp:Button ID="btOkErro" Text="Ok" runat="server" CssClass="btn btn-info" CausesValidation="False" />
        </asp:Panel>

        <!-- Modal Foto -->
        <asp:Button ID="btFoto" runat="server" Style="display: none;" />
        <cc1:ModalPopupExtender ID="MPE_Foto" runat="server" BehaviorID="MPE_Foto"
            DynamicServicePath="" TargetControlID="btFoto" PopupControlID="pnlFoto"
            CancelControlID="btFechar" BackgroundCssClass="popupbg">
        </cc1:ModalPopupExtender>
        <asp:Panel ID="pnlFoto" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
            <asp:Image ImageUrl="../Content/Imagens/ImgNotFound.png" runat="server" ID="imgFoto" CssClass="img-fluid" />
            <br />
            <asp:Button ID="btFechar" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
        </asp:Panel>
    </form>
</body>
</html>
