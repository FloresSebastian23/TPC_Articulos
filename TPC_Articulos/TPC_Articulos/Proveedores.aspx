<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPC_Articulos.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Proveedores</h2>

    <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Proveedor" OnClick="btnNuevo_Click" CssClass="btn btn-primary" />

    <br /><br />

    <asp:GridView ID="dgvProveedores" runat="server" AutoGenerateColumns="false"
        CssClass="table table-bordered" OnSelectedIndexChanged="dgvProveedores_SelectedIndexChanged">

        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />

            <asp:CommandField ShowSelectButton="true" SelectText="Editar" />
            <asp:ButtonField Text="Eliminar" CommandName="Eliminar" />
        </Columns>
    </asp:GridView>

</asp:Content>