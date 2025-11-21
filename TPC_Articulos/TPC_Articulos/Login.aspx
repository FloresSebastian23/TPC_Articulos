<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPC_Articulos.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header text-center">
                        <h4>Iniciar Sesión</h4>
                    </div>
                    <div class="card-body">

                        <div class="form-group mb-3">
                            <label>Usuario</label>
                            <asp:TextBox ID="txtUsuario" CssClass="form-control" runat="server" />
                        </div>

                        <div class="form-group mb-3">
                            <label>Contraseña</label>
                            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" runat="server" />
                        </div>

                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Ingresar" />

                        <div class="mt-3 text-center">
                            <a href="RegistroUsuario.aspx">¿No tenés cuenta? Registrate</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>