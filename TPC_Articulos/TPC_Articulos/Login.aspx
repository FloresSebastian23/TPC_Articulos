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

                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Ingresar" OnClick="btnLogin_Click" />
                        <asp:Label ID="lblError" runat="server" foreColor="Red" CssClass="mt-2 d-block" />

                        <div class="mt-3 text-center">
                           <asp:LinkButton ID="lnkRegistro" runat="server" Text="¿No tenés cuenta? Registrate" OnClick="lnkRegistro_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>