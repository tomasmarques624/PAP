<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewUser.aspx.cs" Inherits="PAP.Site.Admins.NewUser" MasterPageFile="~/Admins/AdminSite.Master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="content-page" style="margin-left: 20px">
        <h2>Adicionar Utilizador</h2>
    </div>
    <div class="form-group" style="margin-left: 50px">
        <label>Username</label>
        <asp:TextBox ID="tbxUsername" CssClass="form-control" runat="server" Width="60%"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o username" Text="*" ControlToValidate="tbxUsername" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
    <div class="form-group" style="margin-left: 50px">
        <label>Email</label>
        <asp:TextBox ID="tbxEmail" CssClass="form-control" runat="server" Width="60%"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o email" Text="*" ControlToValidate="tbxEmail" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
    <div class="form-group" style="margin-left: 50px">
        <label>Password</label>
        <asp:TextBox ID="tbxPassword" CssClass="form-control" TextMode="Password" runat="server" Width="60%"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário a password" Text="*" ControlToValidate="tbxPassword" ForeColor="Red"></asp:RequiredFieldValidator>
    </div>
    <div class="form-group" style="margin-left: 50px">
        <label>Confirme a password</label>
        <asp:TextBox ID="tbxConfirmPassword" CssClass="form-control" TextMode="Password" runat="server" Width="60%"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário confirmar a password" Text="*" ControlToValidate="tbxConfirmPassword" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:CompareValidator ErrorMessage="As passwords não são iguais!" ControlToValidate="tbxConfirmPassword"
            ControlToCompare="tbxPassword" Operator="Equal" Text="*" runat="server" ForeColor="Red" />
    </div>
    <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
    &nbsp&nbsp&nbsp

    <br />
    &nbsp&nbsp&nbsp
    <div style="margin-left: 50px">
        <asp:Button Text="Adicionar" ID="btRegistar" CssClass="btn btn-primary" runat="server" OnClick="btRegistar_Click" />&nbsp
                  
        <asp:Button Text="Cancelar" ID="btCancelar" CssClass="btn btn-secondary" runat="server" CausesValidation="false" OnClick="btCancelar_Click" />
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
