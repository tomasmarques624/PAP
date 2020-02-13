<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Requisicoes.aspx.cs" Inherits="PAP.Site.Admins.Requisicoes" MasterPageFile="~/Admins/AdminSite.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="content-page">
            <h3>Requisicoes</h3>
            <h5>Filtros</h5>
    </div>
    <div>&nbsp&nbsp&nbsp
        <asp:Button ID="btNovaReq" Text="Adicionar Requisicao" runat="server" CssClass="btn btn-primary" />
    </div>
    <br />
        <div style="margin-left: 20px">
             <asp:GridView ID="gvReqList" AutoGenerateColumns="false" EmptyDataText="Sem registos" runat="server" ViewStateMode="Enabled"
                    CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" >

                <Columns>
                    <asp:BoundField DataField ="id_requisicao" ReadOnly="true" HeaderText="ID" />
                </Columns>

                 <Columns>
                    <asp:BoundField DataField ="data_requisicao" HeaderText="Data da Requisicao" />
                </Columns>  

                 <Columns>
                     <asp:TemplateField HeaderText="Estado da Requisicao">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlEditor" runat="server" CssClass="form-control">
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
                    <asp:TemplateField HeaderText="Cancelar Requisicao">
                        <ItemTemplate>
                            <asp:CheckBox runat="server" id="chbxCancelar" Text=" Cancelar"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
    <br />&nbsp&nbsp&nbsp
    <asp:Button ID="btCancelar" Text="Cancelar as requisicoes selecionadas" runat="server" CssClass="btn btn-danger" />

</asp:Content>