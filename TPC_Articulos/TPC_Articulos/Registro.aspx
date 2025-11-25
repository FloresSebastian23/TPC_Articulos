<%@ Page Title="Registro" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="TPC_Articulos.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-header text-center">
                        <h4>Crear Cuenta</h4>
                    </div>

                    <div class="card-body">

                        <div class="form-group mb-3">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" TextMode="Email" CssClass="form-control" runat="server" />
                        </div>

                        <div class="form-group mb-3">
                            <label>Usuario</label>
                            <asp:TextBox ID="txtUsuario" CssClass="form-control" runat="server" />
                        </div>

                        <div class="form-group mb-3">
                            <label>Contraseña</label>
                            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" runat="server" />
                        </div>

                        <div class="form-group mb-3">
                             <asp:CheckBox ID="chkAdmin" runat="server" Text="¿Es administrador?" />
                        </div>

                        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger" Visible="false"></asp:Label>

                        <asp:Button ID="btnRegistrarse" 
                                    runat="server" 
                                    CssClass="btn btn-success w-100" 
                                    Text="Registrarse"
                                    OnClick="btnRegistrarse_Click" />

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>