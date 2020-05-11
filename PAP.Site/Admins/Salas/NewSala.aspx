<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewSala.aspx.cs" Inherits="PAP.Site.Admins.Salas.NewSala" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:content id="Content1"  ContentPlaceHolderID="head" runat="server"></asp:content>

<asp:content id="Content2"  ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="content-page">
                <h4>Nova Sala</h4>
            </div>
            <div>
            <table>
                <tr>
                    <td>Nome :</td>
                    <td> 
                        <asp:TextBox CssClass="form-control" id="tbxNome" runat="server" />
                        <asp:RequiredFieldValidator runat="server" ErrorMessage="É necessário um nome para uma sala" Text="*" ControlToValidate="tbxNome" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ValidationSummary HeaderText="<div class='validationheader'>&nbsp;Erros: </div>" ForeColor="Red" runat="server" displaymode="BulletList" CssClass="validationsummary"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label Text="" ID="lbMensagem" runat="server" ForeColor="Red" />
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
</asp:content>