<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="NuevaVenta.aspx.cs" Inherits="TPC_Articulos.NuevaVenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" />
    <style>
        .venta-card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <div class="card venta-card">
            <div class="card-header bg-dark text-white">
                <h4 class="mb-0">Nueva Venta</h4>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Cliente</label>
                        <asp:DropDownList ID="ddlClientes" runat="server" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Artículo</label>
                        <asp:DropDownList ID="ddlArticulos" runat="server" CssClass="form-select"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlArticulos_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">Precio</label><br />
                        <asp:Label ID="lblPrecio" runat="server" CssClass="fw-bold"></asp:Label>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-3">
                        <label class="form-label">Cantidad</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <asp:Button ID="btnAgregar" runat="server" Text="Agregar ítem"
                            CssClass="btn btn-success w-100" OnClick="btnAgregar_Click" />
                    </div>
                </div>

                <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="false"
                    CssClass="table table-striped table-hover table-bordered"
                    OnRowCommand="gvDetalle_RowCommand">
                    <Columns>
                        <asp:BoundField HeaderText="Artículo" DataField="Articulo.Nombre" />
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />
                        <asp:BoundField HeaderText="Precio Unitario" DataField="PrecioUnitario" 
                                        DataFormatString="{0:C}" />
                        <asp:BoundField HeaderText="Subtotal" DataField="SubTotal" 
                                        DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CommandName="Quitar"
                                    CommandArgument="<%# Container.DataItemIndex %>"
                                    CssClass="btn btn-sm btn-danger">
                                    Quitar
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <div class="d-flex justify-content-end align-items-center mt-3">
                    <h5 class="me-3 mb-0">Total:</h5>
                    <asp:Label ID="lblTotal" runat="server" CssClass="fs-4 fw-bold text-success"></asp:Label>
                </div>

                <div class="d-flex justify-content-end mt-3">
                    <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar venta"
                        CssClass="btn btn-primary" OnClick="btnConfirmar_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>