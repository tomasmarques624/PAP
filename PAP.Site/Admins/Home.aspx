<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Admins.Home" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content-page">
            <h3>Inventario</h3>
            <h5>Filtros</h5>
    </div>
    <div>&nbsp&nbsp&nbsp
        <asp:Button ID="btNovoEquip" Text="Adicionar Equipamento" runat="server" CssClass="btn btn-primary" />
    </div>
    <br />
        <div style="margin-left: 20px">
             <asp:GridView ID="gvEquipList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" >

                <Columns>
                    <asp:BoundField DataField ="id_equip" ReadOnly="true" HeaderText="ID" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="descri" HeaderText="Descricao" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="nome_cat" HeaderText="Categoria" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="nome_sala" HeaderText="Sala" />
                </Columns>

                  <Columns>
                    <asp:TemplateField HeaderText="Disponivel">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxDisponivel" Text=" Disponivel"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                 <Columns>
                    <asp:TemplateField HeaderText="Remover Equipamentos">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxEliminar" Text=" Eliminar"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <Columns>
                    <asp:CommandField ButtonType="Link" EditText="Editar" ShowEditButton="True" />
                </Columns>
            </asp:GridView>
            </div>
    <br />&nbsp&nbsp&nbsp
    <asp:Button ID="btRemover" Text="Remover os equipamentos" runat="server" CssClass="btn btn-danger" />
</asp:Content>
