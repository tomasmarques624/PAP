<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Denuncias.aspx.cs" Inherits="PAP.Site.Admins.Denuncias" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="id_denu" runat="server" />
    <asp:HiddenField ID="prio" runat="server" />
    <asp:HiddenField ID="estado" runat="server" />
    <asp:HiddenField ID="ordprio" runat="server" Value="1" />
    <asp:HiddenField ID="ordestado" runat="server" Value="1" />
    <asp:HiddenField ID="orduti" runat="server" Value="1" />
    <asp:HiddenField ID="ordquip" runat="server" Value="1" />
    <div id="content-page" style="margin-left: 20px">
        <h2>Denuncias</h2>
        <h5>Filtros</h5>
        <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
        <asp:RadioButtonList ID="rblPesq" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="rblPesq_SelectedIndexChanged" AutoPostBack="true" Width="350px">
            <asp:ListItem Text="Problema" Value="1" Selected="True" />
            <asp:ListItem Text="Data" Value="2" />
            <asp:ListItem Text="Utilizador" Value="3" />
            <asp:ListItem Text="Equipamento" Value="4" />
        </asp:RadioButtonList>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
        <p></p>
        <asp:Button ID="btLimparFiltros" Text="Limpar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btLimparFiltros_Click" />
    </div>
    <br />
    <div style="margin-left: 50px">
        <asp:GridView ID="gvDenuList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled" DataKeyNames="id_denuncia"
            CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" OnRowDataBound="gvDenuList_RowDataBound" Height="170px">

            <Columns>
                <asp:BoundField DataField="id_denuncia" ReadOnly="true" HeaderText="ID" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="problema" HeaderText="Problema" HeaderStyle-Width="150px" />
            </Columns>

            <Columns>
                <asp:BoundField DataField="data_denuncia" HeaderText="Data da Denuncia" DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-Width="200px" />
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Prioridade" runat="server" Width="125px"/>
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdPrio" OnClick="OrdPrio_Click" />
                        &nbsp;
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlPrioridade" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPrioridade_SelectedIndexChanged">
                            <asp:ListItem Value="1">Alta</asp:ListItem>
                            <asp:ListItem Value="2">Media</asp:ListItem>
                            <asp:ListItem Value="3">Baixa</asp:ListItem>
                            <asp:ListItem Value="4">Nao Atribuida</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Estado" runat="server" Width="125px"/>
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEstado" OnClick="OrdEstado_Click" />
                        &nbsp;
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged">
                            <asp:ListItem Value="1">Por ver</asp:ListItem>
                            <asp:ListItem Value="2">Por resolver</asp:ListItem>
                            <asp:ListItem Value="3">Resolvida</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Utilizador" runat="server" Width="125px"/>
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdUti" OnClick="OrdUti_Click" />
                        &nbsp;
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button runat="server" CssClass="btn btn-link" ID="btUser" ForeColor="Black" OnClick="btUser_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label Text="Equipamento" runat="server" Width="125px"/>
                        <asp:ImageButton runat="server" ImageUrl="../../Content/Imagens/Setas.png" Width="15" Height="15" ID="OrdEquip" OnClick="OrdEquip_Click" />
                        &nbsp;
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button runat="server" CssClass="btn btn-link" ID="btEquip" ForeColor="Black" OnClick="btEquip_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Remover Denuncia" HeaderStyle-Width="200px">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" />
                        <label> Remover</label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="QR Code">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkQrCode" runat="server" Text="Ver QR Code" OnClick="lkQrCode_Click" CausesValidation="false"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Foto & Comentários">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkFoto" runat="server" Text="Ver Foto/Comentários" OnClick="lkFoto_Click"  CausesValidation="false"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
     <!-- Modal Remover -->
    <asp:Button ID="btRemover" Text="Remover as denuncias selecionadas" runat="server" CssClass="btn btn-danger" OnClick="btRemover_Click" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende remover estas denuncias?"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click" />
    </asp:Panel>

    <!-- Modal Estado -->
    <asp:Button ID="btEstado" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Estado" runat="server" BehaviorID="MPE_Estado"
        DynamicServicePath="" TargetControlID="btEstado" PopupControlID="pnlEstado"
        CancelControlID="btnao1" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlEstado" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbEstado" runat="server" Text="Tem a certeza que pretende alterar o estado desta denuncia?"></asp:Label>
        <br />
        <asp:Button ID="btnao1" runat="server" Style="display: none;" />
        <asp:Button ID="btSimEstado" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimEstado_Click" />
        <asp:Button ID="btNaoEstado" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoEstado_Click" />
    </asp:Panel>

    <!-- Modal Prioridade -->
    <asp:Button ID="btPrio" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Prio" runat="server" BehaviorID="MPE_Prio"
        DynamicServicePath="" TargetControlID="btPrio" PopupControlID="pnlPrio"
        CancelControlID="btnao2" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlPrio" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="Label1" runat="server" Text="Tem a certeza que pretende alterar a prioridade desta denuncia?"></asp:Label>
        <br />
        <asp:Button ID="btnao2" runat="server" Style="display: none;" />
        <asp:Button ID="btSimPrio" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimPrio_Click" />
        <asp:Button ID="btNaoPrio" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoPrio_Click" />
    </asp:Panel>

    <!-- Modal QR Code -->
    <asp:Button ID="btQrCode" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_QrCode" runat="server" BehaviorID="MPE_QrCode"
        DynamicServicePath="" TargetControlID="btQrCode" PopupControlID="pnlQrCode"
        CancelControlID="btNaoQrCode" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlQrCode" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        <asp:Button ID="btSimQrCode" Text="Imprimir" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btSimQrCode_Click" />
        <asp:Button ID="btNaoQrCode" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
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
        <asp:Label ID="lbUsername" Text="" runat="server" />
        <br />
        <asp:Label ID="lbEmail" Text="" runat="server" />
        <br />
        <asp:Label ID="lbNomeUser" Text="" runat="server" />
        <p></p>

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
            <p></p>
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

     <!-- Modal Foto -->
    <asp:Button ID="btFoto" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Foto" runat="server" BehaviorID="MPE_Foto"
        DynamicServicePath="" TargetControlID="btFoto" PopupControlID="pnlFoto"
        CancelControlID="btNaoQrCode" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlFoto" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Image ImageUrl="../../Content/Imagens/ImgNotFound.png" runat="server" ID="imgFoto" CssClass="img-fluid"/>
        <p></p>
        <h3>Comentários </h3>
        <asp:TextBox ID="tbxComentarios" CssClass="form-control" runat="server" Height="145px" Width="100%" TextMode="MultiLine" AutoPostBack="true" OnTextChanged="tbxComentarios_TextChanged"></asp:TextBox>
        <p></p>
        <asp:Button ID="btSalvarComentarios" Text="Salvar" runat="server" CssClass="btn btn-primary" CausesValidation="False" OnClick="btSalvarComentarios_Click" Visible="false"/>
        <asp:Button ID="btFechar" Text="Fechar" runat="server" CssClass="btn btn-secondary" CausesValidation="False" />
    </asp:Panel>
</asp:Content>
