<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="TPC_Articulos.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Proveedores</h2>

    <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Proveedor" OnClick="btnNuevo_Click" CssClass="btn btn-primary" />

    <br /><br />

  <asp:GridView ID="dgvProveedores" runat="server" AutoGenerateColumns="false"
      CssClass="table table-bordered"
      DataKeyNames="Id"
      OnRowCommand="dgvProveedores_RowCommand">

    <Columns>

        
        <asp:BoundField DataField="Id" HeaderText="ID" />

        
        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />

        
        <asp:TemplateField HeaderText="Editar">
            <ItemTemplate>
                <asp:Button ID="btnEditar" runat="server" 
                    Text="Editar"
                    CssClass="btn btn-primary"
                    CommandName="Editar"
                    CommandArgument='<%# Eval("Id") %>' />
            </ItemTemplate>
        </asp:TemplateField>

        
        <asp:TemplateField HeaderText="Eliminar">
            <ItemTemplate>
                <asp:Button ID="btnEliminar" runat="server" 
                    Text="Eliminar"
                    CssClass="btn btn-danger"
                    CommandName="Eliminar"
                    CommandArgument='<%# Eval("Id") %>' />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>


</asp:Content>