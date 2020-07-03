<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewEquip.aspx.cs" Inherits="PAP.Site.Admins.Equips.NewEquip" MasterPageFile="~/Admins/AdminSite.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:content id="Content1"  ContentPlaceHolderID="head" runat="server"></asp:content>

<asp:content id="Content2"  ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div id="content-page" style="margin-left: 20px">
                <h2>Novo Equipamento</h2>
            </div>
            <div style="margin-left: 50px">
            <table>
                <tr>
                    <td>Descrição</td>
                    <td> 
                        <asp:TextBox CssClass="form-control" id="tbxDesc" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma descricao." Text="*" ControlToValidate="tbxDesc" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Categoria</td>
                    <td>
                        <asp:DropDownList ID="ddlCat" runat="server" CssClass="form-control" AutoPostBack="true">
                        </asp:DropDownList>
                         <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma categoria." Text="*" ControlToValidate="ddlCat" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Salas</td>
                    <td>
                        <asp:DropDownList ID="ddlSala" runat="server" CssClass="form-control" AutoPostBack="true">
                        </asp:DropDownList>
                         <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário uma sala." Text="*" ControlToValidate="ddlSala" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr>
                    <td>Fotos</td>
                    <td>
                        <asp:FileUpload CssClass="form-control-file" runat="server" ID="fluFoto"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" displaymode="BulletList" CssClass="validationsummary"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button id="btInserir" CssClass="btn btn-primary" Text="Inserir" runat="server" OnClick="btInserir_Click" />
                        <asp:Button id="btCancelar" CssClass="btn btn-secondary" Text="Cancelar" CausesValidation="false" runat="server" OnClick="btCancelar_Click"/>
                    </td>
                </tr>
            </table>
        </div>

    <!-- Modal Erro -->
    <asp:Button ID="btErro" runat="server" Style="display: none;" />
    <cc1:ModalPopupExtender ID="MPE_Erro" runat="server" BehaviorID="MPE_Erro"
        DynamicServicePath="" TargetControlID="btErro" PopupControlID="pnlErro"
        CancelControlID="btOkErro" BackgroundCssClass="popupbg">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="pnlErro" runat="server" Width="600px" Style="background: white; border: 3px solid gray; border-radius: 7px; padding: 10px">
        <asp:Label ID="lbErro" Text="" runat="server" ForeColor="Red" />
        <asp:Button ID="btOkErro" Text="Ok" runat="server" CssClass="btn btn-info" CausesValidation="False"/>
    </asp:Panel>
</asp:content>
