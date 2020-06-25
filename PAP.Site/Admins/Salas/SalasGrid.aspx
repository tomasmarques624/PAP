<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalasGrid.aspx.cs" Inherits="PAP.Site.Admins.SalasGrid" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="content-page">
        <h2>Salas</h2>
        <h5>Filtros</h5>
        <asp:TextBox ID="tbxPesq" runat="server" ForeColor="Silver" Text="Pesquisar..." CssClass="form-control" Width="351px" />
    </div>
    <div>
        &nbsp&nbsp&nbsp
       
        <asp:Button ID="btNovaSala" Text="Adicionar Sala" runat="server" CssClass="btn btn-primary" OnClick="btNovaSala_Click" />
    </div>
    <br />
    <div style="margin-left: 20px">
        <asp:GridView ID="gvSalaList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
            CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" OnRowCancelingEdit="gvSalaList_RowCancelingEdit"
            OnRowEditing="gvSalaList_RowEditing" OnRowUpdating="gvSalaList_RowUpdating" Width="832px">

            <Columns>
                <asp:BoundField DataField="id_sala" ReadOnly="true" HeaderText="ID" />

                <asp:BoundField DataField="nome_sala" HeaderText="Sala" />

                <asp:TemplateField HeaderText="Remover Salas">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chbxEliminar" Text=" Eliminar" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:CommandField EditText="Editar" ShowEditButton="True" CancelText="Cancelar" UpdateText="Confirmar"></asp:CommandField>
            </Columns>

        </asp:GridView>
    </div>
    <br />
    &nbsp&nbsp&nbsp
   
    <asp:Button ID="btRemover" Text="Remover as salas selecionadas" runat="server" CssClass="btn btn-danger" CausesValidation="false" OnClick="btRemover_Click" />
     <!-- Modal Remover -->
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
        <asp:Button ID="btNaoRe" Text="Não" runat="server" CssClass="btn btn-danger" CausesValidation="False"/>
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
