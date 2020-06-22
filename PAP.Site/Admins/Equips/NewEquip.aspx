<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewEquip.aspx.cs" Inherits="PAP.Site.Admins.Equips.NewEquip" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:content id="Content1"  ContentPlaceHolderID="head" runat="server"></asp:content>

<asp:content id="Content2"  ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="content-page">
                <h4>Novo Equipamento</h4>
            </div>
            <div>
            <table>
                <tr>
                    <td>Descricao :</td>
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
