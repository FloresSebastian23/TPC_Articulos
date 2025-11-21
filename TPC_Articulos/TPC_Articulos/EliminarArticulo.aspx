<%@ Page Title="🗑 Eliminar Artículo" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="EliminarArticulo.aspx.cs"
    Inherits="TPC_Articulos.EliminarArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">
    <h2 class="mb-4 text-danger">🗑 Eliminar Artículo</h2>

    <asp:Label ID="lblId" runat="server" Visible="false"></asp:Label>

    <div class="alert alert-danger">
        <h5>¿Seguro que deseas eliminar este artículo?</h5>
        <p>Esta acción marcará el artículo como inactivo.</p>
    </div>

    <asp:Button ID="btnEliminar" Text="Eliminar" CssClass="btn btn-danger" runat="server" OnClick="btnEliminar_Click" />
    <a href="Administracion.aspx" class="btn btn-secondary">Cancelar</a>

</div>

</asp:Content>