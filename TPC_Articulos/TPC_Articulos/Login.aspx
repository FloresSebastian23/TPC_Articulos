<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPC_Articulos.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" />
    <style>
        .login-container {
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container login-container">
        <div class="card login-card p-4" style="max-width: 400px; width: 100%;">
            <h3 class="text-center mb-4">Iniciar sesión</h3>

            <div class="mb-3">
                <label class="form-label">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Ingresar" 
                        CssClass="btn btn-primary w-100 mb-2" OnClick="btnLogin_Click" />

            <asp:Label ID="lblError" runat="server" CssClass="text-danger d-block mb-2"></asp:Label>

            <div class="text-center">
                <asp:LinkButton ID="lnkRegistro" runat="server" OnClick="lnkRegistro_Click">
                    ¿No tenés cuenta? Registrate
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>