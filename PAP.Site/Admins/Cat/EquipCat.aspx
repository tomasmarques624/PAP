<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EquipCat.aspx.cs" Inherits="PAP.Site.Admins.EquipCat" MasterPageFile="~/Admins/AdminSite.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="content-page">
        <h3>Categorias </h3>
        <h5>Filtros</h5>
        <asp:Label ID="lbPesq" runat="server" Text="Pesquisar :"></asp:Label>
        <asp:TextBox ID="tbxPesq" runat="server" Text="" CssClass="form-control" Width="351px" OnTextChanged="tbxPesq_TextChanged" AutoPostBack="true" />
    </div>
    <div>
        &nbsp&nbsp&nbsp
        <asp:Button ID="btNovaCat" Text="Adicionar Categoria" runat="server" CssClass="btn btn-primary" OnClick="btNovaCat_Click" />
    </div>
    <br />
    <div style="margin-left: 20px">
        <asp:GridView ID="gvCatList" DataKeyNames="id_cat"  AutoGenerateColumns="False" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
            CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" Height="206px" OnRowCancelingEdit="gvCatList_RowCancelingEdit" OnRowEditing="gvCatList_RowEditing" OnRowUpdating="gvCatList_RowUpdating" Width="832px">
            <Columns>
                <asp:BoundField DataField="id_cat" ReadOnly="true" HeaderText="ID" />
            </Columns>
            <Columns>
                <asp:BoundField DataField="Nome" HeaderText="Categoria" />
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="Remover Categorias">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" Text=" Eliminar" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <Columns>
                <asp:CommandField EditText="Editar" ShowEditButton="True" CancelText="Cancelar" UpdateText="Confirmar"></asp:CommandField>
            </Columns>

        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
    <!-- Modal Remover -->
    <asp:Button ID="btRemover" Text="Remover os equipamentos" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btRemover_Click"/>
    <asp:Button ID="btRem" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRem" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende remover estes equipamentos"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False"/>
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

</asp:Content>