<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Admins.Home" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $("#btSimDisp").click(function () {
                alertify.success('Success message');
                return true;
            });
        })
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="id_equip" runat="server" />
    <asp:HiddenField ID="disp" runat="server" />
    <asp:HiddenField ID="id_cat" runat="server" />
    <asp:HiddenField ID="id_sala" runat="server" />
    <asp:HiddenField ID="ordcat" runat="server" Value="1" />
    <asp:HiddenField ID="ordsala" runat="server" Value="1" />
    <asp:HiddenField ID="orddisp" runat="server" Value="1" />
    <asp:HiddenField ID="alerta" runat="server" Value="0" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="content-page">
        <h2>Inventario</h2>
        <h5>Filtros</h5>
        <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
        <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged">
            <asp:ListItem Text="Descricao" Value="1" Selected="True" />
            <asp:ListItem Text="Categoria" Value="2" />
            <asp:ListItem Text="Sala" Value="3" />
        </asp:RadioButtonList>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
        <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
    </div>
    <div>
        &nbsp&nbsp&nbsp
        <asp:Button ID="btNovoEquip" Text="Adicionar Equipamento" runat="server" CssClass="btn btn-primary" OnClick="btNovoEquip_Click" CausesValidation="False" />
    </div>
    <br />
    <div style="margin-left: 20px">
        <asp:GridView ID="gvEquipList" AutoGenerateColumns="False" DataKeyNames="id_equip" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
            CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" OnRowDataBound="gvEquipList_RowDataBound" OnRowCancelingEdit="gvEquipList_RowCancelingEdit" OnRowEditing="gvEquipList_RowEditing"
            OnRowUpdating="gvEquipList_RowUpdating" Height="170px">
            <Columns>
                <asp:BoundField DataField="id_equip" ReadOnly="true" HeaderText="ID" />
                <asp:BoundField DataField="descri" HeaderText="Descricao" />

                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Categoria" runat="server" />
                        &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdCat" OnClick="OrdCat_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlCat" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCat_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Sala" runat="server" />
                        &nbsp;
                        <asp:ImageButton Text="Sala" runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdSala" OnClick="OrdSala_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlSala_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Disponivel" runat="server" />
                        &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdDisp" OnClick="OrdDisp_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxDisponivel" Text=" Disponivel" OnCheckedChanged="chbxDisponivel_CheckedChanged" AutoPostBack="true" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Remover Equipamentos">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" Text=" Eliminar" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ButtonType="Link" EditText="Editar" ShowEditButton="True" CancelText="Cancelar" UpdateText="Confirmar" CausesValidation="False" />

                <asp:TemplateField HeaderText="Reservar">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkReservar" runat="server" Text="Reservar" OnClick="lkReservar_Click" CausesValidation="False" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Denunciar">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkDenuncias" runat="server" Text="Denunciar" OnClick="lkDenuncias_Click" CausesValidation="False" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp

    <!-- Modal Remover -->
    <asp:Button ID="btRemover" Text="Remover os equipamentos" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btRemover_Click" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende remover estes equipamentos"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click" />
    </asp:Panel>

    <!-- Modal Categoria -->
    <asp:Button ID="btCat" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_CAT" runat="server" BehaviorID="MPE_CAT"
        DynamicServicePath="" TargetControlID="btCat" PopupControlID="pnlCat"
        CancelControlID="btteste" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlCat" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbCat" runat="server" Text="Tem a certeza que pretende alterar a categoria deste equipamento?"></asp:Label>
        <br />
        <asp:Button ID="btteste" runat="server" Style="display: none;" />
        <asp:Button ID="btSimCat" Text="Sim" runat="server" OnClick="btSimCat_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoCat" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoCat_Click" />
    </asp:Panel>

    <!-- Modal Disponivel -->
    <asp:Button ID="btDisp" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Disp" runat="server" BehaviorID="MPE_Disp"
        DynamicServicePath="" TargetControlID="btDisp" PopupControlID="pnlDisp"
        CancelControlID="btnao2" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlDisp" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="Label1" runat="server" Text="Tem a certeza que pretende alterar a disponibilidade deste equipamento?"></asp:Label>
        <br />
        <asp:Button ID="btnao2" runat="server" Style="display: none;" />
        <asp:Button ID="btSimDisp" Text="Sim" runat="server" OnClick="btSimDisp_Click" CssClass="btn btn-success" CausesValidation="False" ClientIDMode="Static" />
        <asp:Button ID="Button4" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="Button4_Click" />
    </asp:Panel>

    <!-- Modal Salas -->
    <asp:Button ID="btSala" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Sala" runat="server" BehaviorID="MPE_Sala"
        DynamicServicePath="" TargetControlID="btSala" PopupControlID="pnlSala"
        CancelControlID="btTeste1" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlSala" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbSala" runat="server" Text="Tem a certeza que pretende alterar a sala deste equipamento?"></asp:Label>
        <br />
        <asp:Button ID="btTeste1" runat="server" Style="display: none;" />
        <asp:Button ID="btSimSala" Text="Sim" runat="server" OnClick="btSimSala_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoSala" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoSala_Click" />
    </asp:Panel>

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
                    <asp:Button ID="btSimReq" Text="Inserir" runat="server" OnClick="btSimReq_Click" CssClass="btn btn-success" CausesValidation="False" />
                    <asp:Button ID="btNaoReq" Text="Cancelar" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoReq_Click" />
                </td>
            </tr>
        </table>
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
</asp:Content>

