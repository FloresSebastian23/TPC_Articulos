<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detalle.aspx.cs" Inherits="TPC_Articulos.Detalle" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card mb-4">
        <asp:Image runat="server" ID="imgProducto" CssClass="card-img-top" AlternateText="Imagen del producto" />

        <div class="card-body">

            <h5 class="card-title"><asp:Label ID="lblNombre" runat="server" /></h5>

            <p class="card-text"><asp:Label ID="lblDescripcion" runat="server" /></p>

            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <b>Marca:</b> <asp:Label ID="lblMarca" runat="server" />
                </li>
                <li class="list-group-item">
                    <b>Categoría:</b> <asp:Label ID="lblCategoria" runat="server" />
                </li>
                <li class="list-group-item">
                    <b>Precio de compra:</b> <asp:Label ID="lblPrecioCompra" runat="server" />
                </li>
                <li class="list-group-item">
                    <b>Porcentaje de ganancia:</b> <asp:Label ID="lblPorcentajeGanancia" runat="server" />
                </li>
                <li class="list-group-item">
                    <b>Stock actual:</b> <asp:Label ID="lblStockActual" runat="server" />
                </li>
                <li class="list-group-item">
                    <b>Stock mínimo:</b> <asp:Label ID="lblStockMinimo" runat="server" />
                </li>
            </ul>

            <a runat="server" id="btnVolver" class="btn btn-secondary mt-3" href="Catalogo.aspx">Volver al Catálogo</a>
        </div>
    </div>
</asp:Content>