<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ClienteFormulario.aspx.cs" Inherits="TPC_Articulos.ClienteFormulario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <h2>Cliente</h2>

    <div class="form-group">
        <label>Nombre</label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group mt-2">
        <label>Apellido</label>
        <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
    </div>

    <div class="form-group mt-2">
        <label>Email</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="text-danger mt-2" Visible="false"></asp:Label>

    <br />
   <asp:Button 
    ID="btnGuardar" 
    runat="server"
    Text="Guardar"
    CssClass="btn btn-success mt-3"
    OnClick="btnGuardar_Click" />


</asp:Content>