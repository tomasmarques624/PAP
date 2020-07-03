<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="PAP.Site.Users.Users" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="id_user" runat="server" />
    <div id="content-page" style="margin-left: 20px">
        <h2>Utilizadores</h2>
        <h5>Filtros</h5>
        <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem Text="Username" Value="1" Selected="True" />
            <asp:ListItem Text="Email" Value="2" />
        </asp:RadioButtonList>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
        <p></p>
        <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
    </div>
    <br />
    <div style="margin-left: 50px">
        <asp:GridView ID="gvUsers" DataKeyNames="id_user" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server"
            ViewStateMode="Enabled"
            OnRowDataBound="gvUsers_RowDataBound" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows"
            OnRowCancelingEdit="gvUsers_RowCancelingEdit" OnRowEditing="gvUsers_RowEditing" OnRowUpdating="gvUsers_RowUpdating">
            <Columns>
                <asp:BoundField DataField="id_user" ReadOnly="true" HeaderText="ID" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="username" HeaderText="Nome do Utilizador" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="email" HeaderText="Email" />
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Privilégios de Administrador">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxAdmin" Text=" Administrador" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Eliminar Utilizador">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" />
                        <label>Eliminar</label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Desbloquear Utilizador">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxDesbloquear" />
                        <label>Bloqueado</label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:CommandField ButtonType="Link" EditText="Editar" UpdateText="Confirmar" ShowEditButton="True" CausesValidation="false" />
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Contactar">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkContactar" runat="server" Text="Contactar" OnClick="lkContactar_Click" CausesValidation="false"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
       
    <asp:Button ID="btSalvar" Text="Salvar as alterações" runat="server" OnClick="btSalvar_Click" CssClass="btn btn-primary" CausesValidation="false" />
    <asp:Button ID="btCancelar" Text="Cancelar as alterações" runat="server" OnClick="btCancelar_Click" CssClass="btn btn-danger"  CausesValidation="false"/>

    <!-- Modal Remover -->
    <asp:Button ID="btRem" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRem" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbUpdate" runat="server" Text="Tem a certeza que pretende salvar estas alterações?"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" />
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

    <!-- Modal Detalhes User -->
    <asp:Button ID="btContactarsUser" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Contactar" runat="server" BehaviorID="MPE_Contactar"
        DynamicServicePath="" TargetControlID="btContactarsUser" PopupControlID="pnlContactar"
        CancelControlID="btCancelarContactar" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlContactar" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
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
        <asp:Button ID="btCancelarContactar" Text="Cancelar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" OnClick="btCancelarContactar_Click" />
    </asp:Panel>
</asp:Content>
