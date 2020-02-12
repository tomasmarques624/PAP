<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PAP.Site.Admins.Home" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="jumbotron">
         <h2>Inventario</h2>
    </div>
    <div>
        <asp:Button ID="btNovoEquip" Text="Adicionar Equipamento" runat="server" CssClass="btn btn-primary" />
    </div>
    <br />
    <div>
        <h5>Filtros</h5>
    </div>
    <br />
        <div>
             <asp:GridView ID="gvEquipList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" >

                <Columns>
                    <asp:BoundField DataField ="id_equip" ReadOnly="true" HeaderText="ID" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="desc" HeaderText="Descricao" />
                </Columns>
                 
                 <!--<Columns>
                    <asp:BoundField DataField ="Quant" HeaderText="Quantidade" />
                </Columns>-->

                 <Columns>
                    <asp:BoundField DataField ="disp" HeaderText="Disponivel" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="nome_cat" HeaderText="Categoria" />
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

</asp:Content>
