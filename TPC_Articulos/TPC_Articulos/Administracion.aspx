<%@ Page Title="Administración" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Administracion.aspx.cs" Inherits="TPC_Articulos.Administracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2>Panel de Administración</h2>

        <h3 runat="server" id="lblBienvenido" class="mt-3 text-primary"></h3>

        <div class="list-group mt-4">

           
            <a href="Articulos.aspx" class="list-group-item list-group-item-action">
                📦 Gestionar Artículos
            </a>

            
            <a href="ArticuloFormulario.aspx" class="list-group-item list-group-item-action">
                ➕ Agregar Nuevo Artículo
            </a>

           
            <a href="Categorias.aspx" class="list-group-item list-group-item-action">
                🏷 Gestionar Categorías
            </a>

            
            <a href="Marcas.aspx" class="list-group-item list-group-item-action">
                🖋 Gestionar Marcas
            </a>

            
            <a href="Proveedores.aspx" class="list-group-item list-group-item-action">
                🏭 Gestionar Proveedores
            </a>

        </div>
    </div>

</asp:Content>