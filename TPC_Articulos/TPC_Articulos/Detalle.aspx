<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detalle.aspx.cs" Inherits="TPC_Articulos.Detalle" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">

        <asp:Panel ID="pnlDetalle" runat="server" Visible="false">

            <div class="card mb-4" style="max-width: 600px;">
                <img id="imgArticulo" runat="server" class="card-img-top" />

                <div class="card-body">
                    <h3 id="lblNombre" runat="server"></h3>
                    <h5 id="lblMarca" runat="server"></h5>
                    <p id="lblDescripcion" runat="server"></p>
                </div>
            </div>

        </asp:Panel>

        <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>

    </div>

</asp:Content>