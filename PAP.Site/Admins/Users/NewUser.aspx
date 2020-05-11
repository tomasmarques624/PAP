<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewUser.aspx.cs" Inherits="PAP.Site.Admins.NewUser" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content-page">
            <h3>Adicionar Utilizador</h3>
    </div>
                  <div class="form-group">
                     <label>Username</label>
                     <asp:TextBox ID="tbxUsername" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o username" Text="*" ControlToValidate="tbxUsername" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                   <div class="form-group">
                     <label>Email</label>
                     <asp:TextBox ID="tbxEmail" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário o email" Text="*" ControlToValidate="tbxEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                  <div class="form-group">
                     <label>Password</label>
                     <asp:TextBox ID="tbxPassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário a password" Text="*" ControlToValidate="tbxPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
                   <div class="form-group">
                       <label>Confirme a password</label>
                     <asp:TextBox ID="tbxConfirmPassword" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário confirmar a password" Text="*" ControlToValidate="tbxConfirmPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ErrorMessage="As passwords não são iguais!" ControlToValidate="tbxConfirmPassword" 
                         ControlToCompare="tbxPassword" operator="Equal" text="*" runat="server" ForeColor="Red"/>
                  </div>
                   <asp:ValidationSummary HeaderText="Erros" ForeColor="Red" runat="server" />
                    &nbsp&nbsp&nbsp
                   <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
                   <br />&nbsp&nbsp&nbsp
                   <asp:Button Text="Adicionar" ID="btRegistar" CssClass="btn btn-primary" runat="server"  OnClick="btRegistar_Click"/>&nbsp
                   <asp:Button Text="Cancelar" ID="btCancelar" CssClass="btn btn-secondary" runat="server" CausesValidation="false" OnClick="btCancelar_Click" />
</asp:Content>