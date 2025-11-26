<%@ Page Title="Administración" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Administracion.aspx.cs" Inherits="TPC_Articulos.Administracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2>Panel de Administración</h2>

        <h3 runat="server" id="lblBienvenido" class="mt-3 text-primary"></h3>

        <div class="list-group mt-4">

    <asp:LinkButton runat="server" CssClass="list-group-item list-group-item-action"
        PostBackUrl="~/Articulos.aspx">
        📦 Gestionar Artículos
    </asp:LinkButton>

    <asp:LinkButton runat="server" CssClass="list-group-item list-group-item-action"
        PostBackUrl="~/ArticuloFormulario.aspx">
        ➕ Agregar Nuevo Artículo
    </asp:LinkButton>

    <asp:LinkButton runat="server" CssClass="list-group-item list-group-item-action"
        PostBackUrl="~/Categorias.aspx">
        🏷 Gestionar Categorías
    </asp:LinkButton>

    <asp:LinkButton runat="server" CssClass="list-group-item list-group-item-action"
        PostBackUrl="~/Marcas.aspx">
        🖋 Gestionar Marcas
    </asp:LinkButton>

    <asp:LinkButton runat="server" CssClass="list-group-item list-group-item-action"
        PostBackUrl="~/Proveedores.aspx">
        🏭 Gestionar Proveedores
    </asp:LinkButton>

</div>
    </div>

</asp:Content>