<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequisicoesGrid.aspx.cs" Inherits="PAP.Site.Admins.RequisicoesGrid" MasterPageFile="~/Admins/AdminSite.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="id_req" runat="server" />
    <asp:HiddenField ID="estado" runat="server" />
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
                </Columns>

                <Columns>
                    <asp:BoundField DataField="data_requisicao" HeaderText="Data Inicial da Reserva" DataFormatString="{0:MM/dd/yyyy}" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField="data_requisicao_final" HeaderText="Data Final da Reserva" DataFormatString="{0:MM/dd/yyyy}" />
                </Columns>

                <Columns>
                    <asp:TemplateField HeaderText="Estado da Requisicao">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEstado_SelectedIndexChanged">
                                <asp:ListItem Text="N/A" Value="1"/>
                                <asp:ListItem Text="Aprovada" Value="2" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>


                <Columns>
                    <asp:BoundField DataField="id_user" HeaderText="ID do Utilizador" />
                </Columns>

                <Columns>
                    <asp:BoundField DataField="id_equip" HeaderText="ID do Equipamento" />
                </Columns>

                <Columns>
                    <asp:TemplateField HeaderText="Cancelar Requisicao">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chbxCancelar" Text=" Cancelar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
    <br />&nbsp&nbsp&nbsp
     <!-- Modal Remover -->
    <asp:Button ID="btRemover" Text="Remover os equipamentos" runat="server" CssClass="btn btn-danger" />
    <cc1:ModalPopupExtender ID="MPE_Rem" runat="server" BehaviorID="btRemover_ModalPopupExtender"
        DynamicServicePath="" TargetControlID="btRemover" PopupControlID="pnlRemover"
        CancelControlID="btNaoRe" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <br />
    <asp:Panel ID="pnlRemover" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lblRemover" runat="server" Text="Tem a certeza que pretende remover estes equipamentos"></asp:Label>
        <br />
        <asp:Button ID="btSimRe" Text="Sim" runat="server" OnClick="btSimRe_Click" CssClass="btn btn-success" CausesValidation="False" />
        <asp:Button ID="btNaoRe" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoRe_Click"/>
    </asp:Panel>

    <!-- Modal Estado -->
    <asp:Button ID="btEstado" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Estado" runat="server" BehaviorID="MPE_Estado"
        DynamicServicePath="" TargetControlID="btEstado" PopupControlID="pnlEstado"
        CancelControlID="btNaoEstado" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlEstado" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbEstado" runat="server" Text="Tem a certeza que pretende alterar o estado desta reserva?"></asp:Label>
        <br />
        <asp:Button ID="btSimEstado" Text="Sim" runat="server" CssClass="btn btn-success" CausesValidation="False" OnClick="btSimEstado_Click"/>
        <asp:Button ID="btNaoEstado" Text="Nao" runat="server" CssClass="btn btn-danger" CausesValidation="False" OnClick="btNaoEstado_Click"/>
    </asp:Panel>

</asp:Content>