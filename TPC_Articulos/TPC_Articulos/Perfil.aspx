<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4" style="max-width: 500px;">
        <div class="card shadow-sm">
            <div class="card-body">
                <h3 class="mb-3">Mi Perfil</h3>

                <p><strong>Usuario:</strong> <asp:Label ID="lblUsuario" runat="server" /></p>
                <p><strong>Rol:</strong> <asp:Label ID="lblRol" runat="server" /></p>

                <asp:Button ID="btnCambiarPass" runat="server" Text="Cambiar contraseña" CssClass="btn btn-primary mt-3" />
                <a href="Logout.aspx" class="btn btn-danger mt-3">Cerrar sesión</a>

            </div>
        </div>
    </div>

</asp:Content>