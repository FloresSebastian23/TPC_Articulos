<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Articulos.aspx.cs" Inherits="TPC_Articulos.Articulos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <asp:GridView ID="dgvArticulos" runat="server"
    AutoGenerateColumns="false"
    CssClass="table table-bordered"
    DataKeyNames="Id"
    OnSelectedIndexChanged="dgvArticulos_SelectedIndexChanged">

    <Columns>
        <asp:BoundField DataField="Id" HeaderText="ID" />
        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
        <asp:BoundField DataField="PrecioCompra" HeaderText="Precio" />
        <asp:BoundField DataField="StockActual" HeaderText="Stock" />

        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />

        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnEliminar" runat="server"
                    Text="Eliminar"
                    CssClass="btn btn-danger"
                    CommandArgument='<%# Eval("Id") %>'
                    OnClick="btnEliminar_Click" />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>


<br />

<asp:Button ID="btnAgregar" runat="server" Text="Agregar Artículo" CssClass="btn btn-primary"
    OnClick="btnAgregar_Click" />
</asp:Content>
