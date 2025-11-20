<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Catalogo.aspx.cs" Inherits="TPC_Articulos.Catalogo" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <div class="row">

            <% if (ListaArticulos != null) { %>

                <% foreach (var art in ListaArticulos) { %>

                    <div class="col-md-3 mb-4">
                        <div class="card h-100">

                            <img src="<%= art.ImagenUrl %>" class="card-img-top" alt="Imagen">

                            <div class="card-body">
                                <h5 class="card-title"><%= art.Nombre %></h5>
                                <p class="card-text"><%= art.Marca.Descripcion %></p>

                                <a href="Detalle.aspx?id=<%= art.ID %>" class="btn btn-primary">
                                    Ver detalle
                                </a>
                            </div>

                        </div>
                    </div>

                <% } %>

            <% } %>

        </div>
    </div>

</asp:Content>