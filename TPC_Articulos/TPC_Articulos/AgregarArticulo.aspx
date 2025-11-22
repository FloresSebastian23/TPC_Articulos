<%@ Page Title="➕ Agregar Artículo" Language="C#" MasterPageFile="~/Site1.Master"AutoEventWireup="true" CodeBehind="AgregarArticulo.aspx.cs"Inherits="TPC_Articulos.AgregarArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">
    <h2 class="mb-4">➕ Agregar Artículo</h2>

    <div class="row g-3">

        
        <div class="col-md-6">
            <label class="form-label">Código</label>
            <asp:TextBox ID="txtCodigo" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Nombre</label>
            <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-12">
            <label class="form-label">Descripción</label>
            <asp:TextBox ID="txtDescripcion" TextMode="MultiLine" Rows="3" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Marca</label>
            <asp:DropDownList ID="ddlMarca" CssClass="form-select" runat="server"></asp:DropDownList>
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Categoría</label>
            <asp:DropDownList ID="ddlCategoria" CssClass="form-select" runat="server"></asp:DropDownList>
        </div>

        
        <div class="col-12">
            <label class="form-label">URL de Imagen</label>
            <asp:TextBox ID="txtImagenUrl" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Precio Compra</label>
            <asp:TextBox ID="txtPrecioCompra" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">% Ganancia</label>
            <asp:TextBox ID="txtPorcentajeGanancia" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Stock Actual</label>
            <asp:TextBox ID="txtStockActual" CssClass="form-control" runat="server" />
        </div>

        
        <div class="col-md-6">
            <label class="form-label">Stock Mínimo</label>
            <asp:TextBox ID="txtStockMinimo" CssClass="form-control" runat="server" />
        </div>

    </div>

    <div class="mt-4">
        <asp:Button ID="btnAgregar" Text="Guardar" CssClass="btn btn-success" runat="server" OnClick="btnAgregar_Click" />
        <a href="Administracion.aspx" class="btn btn-secondary">Cancelar</a>
    </div>

</div>

</asp:Content>