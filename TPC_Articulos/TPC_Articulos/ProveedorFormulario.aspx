<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProveedorFormulario.aspx.cs" Inherits="TPC_Articulos.ProvedorFormulario" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2><asp:Label ID="lblTitulo" runat="server" Text="Nuevo Proveedor"></asp:Label></h2>

    <asp:HiddenField ID="hfId" runat="server" />

    <div class="form-group">
        <label>Nombre del Proveedor</label>
        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
    </div>

    <br />

    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
    &nbsp;
    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secondary" PostBackUrl="~/Provedor.aspx" />

</asp:Content>