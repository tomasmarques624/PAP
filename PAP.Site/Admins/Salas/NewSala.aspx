<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewSala.aspx.cs" Inherits="PAP.Site.Admins.Salas.NewSala" MasterPageFile="~/Admins/AdminSite.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="content-page" style="margin-left: 20px">
        <h2>Nova Sala</h2>
    </div>
    <div style="margin-left: 50px">
        <table>
            <tr>
                <td>Nome</td>
                <td>
                    <asp:TextBox CssClass="form-control" ID="tbxNome" runat="server" />
                    <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um nome para uma sala!" Text="*" ControlToValidate="tbxNome" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" DisplayMode="BulletList" CssClass="validationsummary" />
                </td>
            </tr>
            <tr>
                <td>
                    <p></p>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btInserir" CssClass="btn btn-primary" Text="Inserir" runat="server" OnClick="btInserir_Click" />
                    <asp:Button ID="btCancelar" CssClass="btn btn-secondary" Text="Cancelar" CausesValidation="false" runat="server" OnClick="btCancelar_Click" />
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
        <br />
        <asp:Button ID="btOkErro" Text="Ok" runat="server" CssClass="btn btn-info" CausesValidation="False" />
    </asp:Panel>
</asp:Content>
