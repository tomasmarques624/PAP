<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Denuncias.aspx.cs" Inherits="PAP.Site.Admins.Denuncias" MasterPageFile="~/Admins/AdminSite.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content-page">
            <h3>Denuncias</h3>
            <h5>Filtros</h5>
    </div>
    <div>&nbsp&nbsp&nbsp
        <asp:Button ID="btNovaDenuncia" Text="Adicionar Denuncia" runat="server" CssClass="btn btn-primary" />
    </div>
    <br />
        <div style="margin-left: 20px">
             <asp:GridView ID="gvDenuList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" >

                <Columns>
                    <asp:BoundField DataField ="id_denuncia" ReadOnly="true" HeaderText="ID" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="problema" HeaderText="Problema" />
                </Columns>  

                 <Columns>
                    <asp:BoundField DataField ="data_denuncia" HeaderText="Data da Denuncia" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="prioridade" HeaderText="Prioridade" />
                </Columns>

                 <Columns>
                    <asp:TemplateField HeaderText="Estado da Denuncia">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                        </ItemTemplate>    
                    </asp:TemplateField>
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="username" HeaderText="Nome do Utilizador" />
                </Columns>

                  <Columns>
                    <asp:BoundField DataField ="id_equip" HeaderText="ID do Equipamento" />
                </Columns>

                 <Columns>
                    <asp:TemplateField HeaderText="Remover Denuncia">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxEliminar" Text=" Eliminar"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <Columns>
                    <asp:CommandField ButtonType="Link" EditText="Editar" ShowEditButton="True" />
                    <asp:TemplateField HeaderText="QR Code">
                        <ItemTemplate>
                            <asp:LinkButton ID="lkQrCode" runat="server" Text="Ver QR Code" OnClick="lkQrCode_Click"/>
                        </ItemTemplate>    
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
    <br />&nbsp&nbsp&nbsp
    <asp:Button ID="btRemover" Text="Remover as denuncias selecionadas" runat="server"  CssClass="btn btn-danger" />

</asp:Content>