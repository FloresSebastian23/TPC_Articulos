<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="NuevaVenta.aspx.cs" Inherits="TPC_Articulos.NuevaVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">

        <h3>Nueva Venta </h3>
        <hr />

        <!-- CLIENTE -->
        <div class="row mb-3">
            <div class="col-md-4">
                <label>Cliente</label>
                <asp:DropDownList ID="ddlClientes" CssClass="form-control" runat="server"></asp:DropDownList>
            </div>
        </div>

        <!-- AGREGAR PRODUCTOS -->
        <div class="row mb-3">
            <div class="col-md-4">
                <label>Artículo</label>
                <asp:DropDownList ID="ddlArticulos" CssClass="form-control" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlArticulos_SelectedIndexChanged" runat="server"></asp:DropDownList>
            </div>

            <div class="col-md-2">
                <label>Cantidad</label>
                <asp:TextBox ID="txtCantidad" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
            </div>

            <div class="col-md-2">
                <label>Precio</label>
                <asp:Label ID="lblPrecio" CssClass="form-control" runat="server" />
            </div>

            <div class="col-md-2 d-flex align-items-end">
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-success w-100"
                    OnClick="btnAgregar_Click" />
            </div>
        </div>

        <!-- DETALLE -->
        <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="false" CssClass="table table-striped"
            OnRowCommand="gvDetalle_RowCommand">

            <Columns>
                <asp:BoundField DataField="NombreArticulo" HeaderText="Artículo" />
                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:C}" />
                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />

                <asp:ButtonField Text="Quitar" CommandName="Quitar" ButtonType="Button" />
            </Columns>

        </asp:GridView>

        <!-- TOTAL -->
        <h4 class="text-end mt-3">TOTAL: $ <asp:Label ID="lblTotal" runat="server" Text="0" /></h4>

        <!-- CONFIRMAR -->
        <div class="text-end mt-3">
            <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar Venta" CssClass="btn btn-primary"
                OnClick="btnConfirmar_Click" />
        </div>

    </div>

</asp:Content>