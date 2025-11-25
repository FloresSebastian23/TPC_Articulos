<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArticuloFormulario.aspx.cs" Inherits="TPC_Articulos.ArticuloFormulario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h2><asp:Label ID="lblTitulo" runat="server" Text="Nuevo Artículo"></asp:Label></h2>

    <asp:HiddenField ID="hfId" runat="server" />

    <div class="form-group">
        <label>Código</label>
        <asp:TextBox ID="txtCodigo" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Nombre</label>
        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Descripción</label>
        <asp:TextBox ID="txtDescripcion" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Marca</label>
        <asp:DropDownList ID="ddlMarca" CssClass="form-control" runat="server"></asp:DropDownList>
    </div>

    <div class="form-group">
        <label>Categoría</label>
        <asp:DropDownList ID="ddlCategoria" CssClass="form-control" runat="server"></asp:DropDownList>
    </div>

    <div class="form-group">
        <label>Imagen URL</label>
        <asp:TextBox ID="txtImagenUrl" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Precio Compra</label>
        <asp:TextBox ID="txtPrecioCompra" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Porcentaje Ganancia</label>
        <asp:TextBox ID="txtPorcentajeGanancia" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Stock Actual</label>
        <asp:TextBox ID="txtStockActual" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <div class="form-group">
        <label>Stock Mínimo</label>
        <asp:TextBox ID="txtStockMinimo" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <br />
    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
    <br />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
    &nbsp;
    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" PostBackUrl="~/Catalogo.aspx" />

</asp:Content>

