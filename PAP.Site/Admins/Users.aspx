<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="PAP.Site.Users.Users" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div id="content-page">
            <h3>Requisicoes</h3>
            <h5>Filtros</h5>
        </div>
        <div>&nbsp&nbsp&nbsp
            <asp:Button ID="btNovoUser" Text="Adicionar Utilizador" runat="server" CssClass="btn btn-primary" OnClick="btNovoUser_Click"/>
        </div>
         <br />
        <div style="margin-left: 20px">
        <asp:GridView ID="gvUsers" DataKeyNames="id_user" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" 
                    ViewStateMode="Enabled" 
                    OnRowDataBound="gvUsers_RowDataBound" CssClass="mydatagrid" HeaderStyle-CssClass="header"  RowStyle-CssClass="rows" >
                <Columns>
                    <asp:BoundField DataField ="id_user" ReadOnly="true" HeaderText="ID" />
                </Columns>

                <Columns>
                    <asp:BoundField DataField ="username" HeaderText="Nome do Utilizador" />
                </Columns>

                <Columns>
                    <asp:BoundField DataField ="email" HeaderText="Email" />
                </Columns>

                <Columns>      
                    <asp:TemplateField HeaderText="Privilégios de Administrador">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxAdmin" Text=" Administrador"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <Columns>
                    <asp:TemplateField HeaderText="Eliminar Utilizador">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxEliminar" Text=" Eliminar"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <Columns>
                    <asp:TemplateField HeaderText="Desbloquear Utilizador">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxDesbloquear" Text=" Bloqueado"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <Columns>
                    <asp:CommandField ButtonType="Link" EditText="Editar" ShowEditButton="True" />
                </Columns>

            </asp:GridView>
        </div>
        <br />&nbsp&nbsp&nbsp
        <asp:Button ID="btSalvar" Text="Salvar as alterações" runat="server" OnClick="btSalvar_Click" CssClass="btn btn-primary" />

</asp:Content>