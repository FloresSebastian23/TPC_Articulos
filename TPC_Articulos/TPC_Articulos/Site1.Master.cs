using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Dominio;
using TPC_Articulos.Negocio;

namespace TPC_Articulos
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pagina = System.IO.Path.GetFileName(Request.PhysicalPath).ToLower();

            // Páginas públicas
            bool esPublica =
                pagina == "catalogo.aspx" ||
                pagina == "detalle.aspx" ||
                pagina == "login.aspx";

            // Mostrar / ocultar elementos del navbar
            if (Session["Usuario"] == null)
            {
                // No logueado  mostrar Login, ocultar Admin y Logout
                liLogin.Visible = true;
                liAdmin.Visible = false;
                liLogout.Visible = false;
                liProveedores.Visible = false;

                // Bloqueo de páginas privadas
                if (!esPublica)
                {
                    Response.Redirect("Login.aspx", false);
                    return;
                }
            }
            else
            {
                // Usuario logueado  ocultar Login
                liLogin.Visible = false;
                liLogout.Visible = true;

                Usuario user = (Usuario)Session["Usuario"];

                // Mostrar administración solo si es admin
                liAdmin.Visible = user.EsAdmin;
                liProveedores.Visible = true;

                // Bloquear admin si NO es admin real
                if (pagina == "administracion.aspx" && !user.EsAdmin)
                {
                    Response.Redirect("Catalogo.aspx", false);
                    return;
                }
            }
        }
    }
}