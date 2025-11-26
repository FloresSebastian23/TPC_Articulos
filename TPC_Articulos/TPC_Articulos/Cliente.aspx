<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="TPC_Articulos.Cliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Gestión de Clientes</h2>

    <asp:GridView ID="dgvClientes" runat="server"
        AutoGenerateColumns="false"
        DataKeyNames="Id"
        CssClass="table table-bordered mt-3"
        OnSelectedIndexChanged="dgvClientes_SelectedIndexChanged">

        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
            <asp:BoundField DataField="Email" HeaderText="Email" />

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

    <asp:Button ID="btnAgregar" runat="server"
        Text="Agregar Cliente"
        CssClass="btn btn-primary mt-3"
        OnClick="btnAgregar_Click" />
</asp:Content>