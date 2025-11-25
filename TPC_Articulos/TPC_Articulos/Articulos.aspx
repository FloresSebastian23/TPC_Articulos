<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Articulos.aspx.cs" Inherits="TPC_Articulos.Articulos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="dgvArticulos" runat="server" AutoGenerateColumns="false" CssClass="table table-striped"
    OnSelectedIndexChanged="dgvArticulos_SelectedIndexChanged">

    <Columns>

        <asp:BoundField DataField="Id" HeaderText="ID" />

        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />

        <asp:BoundField DataField="Marca.Descripcion" HeaderText="Marca" />

        <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoría" />

        <asp:BoundField DataField="PrecioVenta" HeaderText="Precio Venta" DataFormatString="{0:C}" />

        <asp:CommandField ShowSelectButton="true" SelectText="Editar" />

        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger"
                    CommandArgument='<%# Eval("Id") %>'
                    OnClick="btnEliminar_Click" />
                &nbsp;
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

<br />

<asp:Button ID="btnAgregar" runat="server" Text="Agregar Artículo" CssClass="btn btn-primary"
    OnClick="btnAgregar_Click" />
</asp:Content>
