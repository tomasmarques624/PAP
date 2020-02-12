﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Denuncias.aspx.cs" Inherits="PAP.Site.Admins.Denuncias" MasterPageFile="~/Admins/AdminSite.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="jumbotron">
         <h2>Denuncias</h2>
    </div>
    <br />
    <div>
        <h5>Filtros</h5>
    </div>
    <br />
        <div>
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
                    <asp:BoundField DataField ="estado" HeaderText="estado" />
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
    <br />
    <asp:Button ID="btRemover" Text="Remover as denuncias" runat="server" OnClick="btRemover_Click" CssClass="btn btn-danger" />

</asp:Content>