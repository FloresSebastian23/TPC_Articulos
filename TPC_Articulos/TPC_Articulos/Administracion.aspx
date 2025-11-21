<%@ Page Title="Administración" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Administracion.aspx.cs" Inherits="TPC_Articulos.Administracion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2>Panel de Administración</h2>

        <div class="list-group mt-4">
            <a href="AgregarArticulo.aspx" class="list-group-item list-group-item-action">➕ Agregar Artículo</a>
            <a href="EditarArticulo.aspx" class="list-group-item list-group-item-action">✏ Editar Artículo</a>
            <a href="EliminarArticulo.aspx" class="list-group-item list-group-item-action">🗑 Eliminar Artículo</a>
        </div>
    </div>

</asp:Content>