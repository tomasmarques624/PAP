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
    <div id="content-page">
        <h3>Denuncias</h3>
        <h5>Filtros</h5>
        <asp:Label ID="lbPesq" runat="server" Text="Pesquisar por:"></asp:Label>
        <asp:RadioButtonList ID="rblPesq" runat="server">
            <asp:ListItem Text="Problema" Value="1" Selected="True" />
            <asp:ListItem Text="Data" Value="2" />
            <asp:ListItem Text="Utilizador" Value="3" />
            <asp:ListItem Text="Equipamento" Value="4" />
        </asp:RadioButtonList>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
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
                <asp:TemplateField >
                    <HeaderTemplate>
                        <asp:Button Text="Prioridade" runat="server" ForeColor="White" CssClass="btn btn-link" ID="OrdPrio" OnClick="OrdPrio_Click" />
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
                        <asp:Button Text="Estado" runat="server" ForeColor="White" CssClass="btn btn-link" ID="OrdEstado" OnClick="OrdEstado_Click" />
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
                        <asp:Button Text="Utilizador" runat="server" ForeColor="White" CssClass="btn btn-link" ID="OrdUti" OnClick="OrdUti_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Button runat="server" CssClass="btn btn-link" ID="btUser" ForeColor="Black"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Button Text="Equipamento" runat="server" ForeColor="White" CssClass="btn btn-link" ID="OrdEquip" OnClick="OrdEquip_Click" />
                    </HeaderTemplate>
                    <ItemTemplate>
                         <asp:Button runat="server" CssClass="btn btn-link" ID="btEquip" ForeColor="Black"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="Remover Denuncia">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" Text=" Eliminar" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

            <Columns>
                <asp:TemplateField HeaderText="QR Code">
                    <ItemTemplate>
                        <asp:LinkButton ID="lkQrCode" runat="server" Text="Ver QR Code" OnClick="lkQrCode_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
     <!-- Modal Remover -->
    <asp:Button ID="btRemover" Text="Remover os equipamentos" runat="server" CssClass="btn btn-danger" OnClick="btRemover_Click" />
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
        <asp:Button ID="btNaoEstado" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoEstado_Click" />
    </asp:Panel>

    <!-- Modal Prioridade -->
    <asp:Button ID="btPrio" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Prio" runat="server" BehaviorID="MPE_Prio"
        DynamicServicePath="" TargetControlID="btPrio" PopupControlID="pnlPrio"
        CancelControlID="btNaoPrio" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlPrio" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="Label1" runat="server" Text="Tem a certeza que pretende alterar a prioridade desta denuncia?"></asp:Label>
        <br />
        <asp:Button ID="btSimPrio" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimPrio_Click" />
        <asp:Button ID="btNaoPrio" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoPrio_Click" />
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

</asp:Content>
