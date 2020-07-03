<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequisicoesGrid.aspx.cs" Inherits="PAP.Site.Admins.RequisicoesGrid" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="id_req" runat="server" />
    <asp:HiddenField ID="estado" runat="server" />
    <asp:HiddenField ID="ordest" runat="server" Value="1" />
    <asp:HiddenField ID="ordequip" runat="server" Value="1" />
    <asp:HiddenField ID="orduti" runat="server" Value="1" />

    <div id="content-page" style="margin-left: 20px">
        <h2>Reservas</h2>
        <h5>Filtros</h5>
        <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
        <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Data Inicial" Value="1" Selected="True" />
            <asp:ListItem Text="Data Final" Value="2" />
            <asp:ListItem Text="Utilizador" Value="3" />
            <asp:ListItem Text="Equipamento" Value="4" />
        </asp:RadioButtonList>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" TextMode="Date" />
        <p></p>
        <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
    </div>
    <div style="margin-left: 50px">
        <asp:GridView ID="gvReqList" DataKeyNames="id_requisicao" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
            OnRowDataBound="gvReqList_RowDataBound"
            CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="150px">

            <Columns>
                <asp:BoundField DataField="id_requisicao" ReadOnly="true" HeaderText="ID" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="data_requisicao" HeaderText="Data Inicial da Reserva" DataFormatString="{0:dd/MM/yyyy}" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="data_requisicao_final" HeaderText="Data Final da Reserva" DataFormatString="{0:dd/MM/yyyy}" />
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Estado" runat="server" />
                        &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEstado" OnClick="OrdEstado_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged">
                            <asp:ListItem Text="N/A" Value="1" />
                            <asp:ListItem Text="Aprovada" Value="2" />
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>


            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Utilizador" runat="server" />
                        &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdUti" OnClick="OrdUti_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button runat="server" CssClass="btn btn-link" ID="btUser" ForeColor="Black" OnClick="btUser_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Equipamento" runat="server" />
                        &nbsp;
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEquip" OnClick="OrdEquip_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button runat="server" ForeColor="Black" CssClass="btn btn-link" ID="btEquip" OnClick="btEquip_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Cancelar Reserva">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxCancelar" />
                        <label>Cancelar</label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
    
    <asp:Button ID="btRemover" Text="Remover reservas selecionadas" runat="server" CssClass="btn btn-danger" />

    <!-- Modal Remover -->
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende remover estas reservas?"></asp:Label>
        <br />

        <div class="form-group">
            <label>Razão (Opcional)</label>
            <asp:TextBox ID="tbxRazao" CssClass="form-control" runat="server" Height="145px" Width="100%" TextMode="MultiLine"></asp:TextBox>
        </div>

        <p></p>
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click" />
    </asp:Panel>

    <!-- Modal Estado -->
    <asp:Button ID="btEstado" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Estado" runat="server" BehaviorID="MPE_Estado"
        DynamicServicePath="" TargetControlID="btEstado" PopupControlID="pnlEstado"
        CancelControlID="FecharEstado" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlEstado" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbEstado" runat="server" Text="Tem a certeza que pretende alterar o estado desta reserva?"></asp:Label>
        <br />
        <asp:Button ID="FecharEstado" runat="server" Style="display: none;" />
        <asp:Button ID="btSimEstado" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimEstado_Click" />
        <asp:Button ID="btNaoEstado" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoEstado_Click" />
    </asp:Panel>

    <!-- Modal Detalhes User -->
    <asp:Button ID="btDetalhesUser" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_User" runat="server" BehaviorID="MPE_User"
        DynamicServicePath="" TargetControlID="btDetalhesUser" PopupControlID="pnlUser"
        CancelControlID="btFecharUser" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlUser" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <h3>Detalhes do Utilizador</h3>
        <br />
        <asp:Label ID="lbNomeUser" Text="" runat="server" />
        <br />

        <asp:Label ID="lbEmail" Text="" runat="server" />

        <div id="divContactar" visible="false" runat="server" style="border: 3px solid">
            <div class="form-group">
                <label>Assunto</label>
                <asp:TextBox ID="tbxAssunto" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um assunto." Text="*" ControlToValidate="tbxAssunto" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <label>Mensagem</label>
                <asp:TextBox ID="tbxMensagem" CssClass="form-control" runat="server" Height="145px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma mensagem." Text="*" ControlToValidate="tbxMensagem" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <br />
            <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
            &nbsp&nbsp&nbsp
            <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
            <br />
            <asp:Button ID="btEnviar" CssClass="btn btn-primary" runat="server" Text="Enviar" OnClick="btEnviar_Click" />
            <asp:Button ID="btCancelar" Text="Cancelar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" OnClick="btCancelar_Click" />
        </div>
        <br />
        <asp:Button ID="btContactar" Text="Contactar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btContactar_Click" />
        <asp:Button ID="btFecharUser" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" OnClick="btFecharUser_Click" />
    </asp:Panel>

    <!-- Modal Detalhes Equips -->
    <asp:Button ID="btDetalhesEquip" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Equip" runat="server" BehaviorID="MPE_Equip"
        DynamicServicePath="" TargetControlID="btDetalhesEquip" PopupControlID="pnlEquip"
        CancelControlID="btFecharEquip" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlEquip" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <h3>Detalhes do Equipamento</h3>
        <br />
        <asp:Label ID="lbDescri" Text="" runat="server" />
        <br />
        <asp:Label ID="lbCategoria" Text="" runat="server" />
        <br />
        <asp:Label ID="lbSala" Text="" runat="server" />
        <br />
        <asp:Button ID="btFecharEquip" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
    </asp:Panel>
</asp:Content>
