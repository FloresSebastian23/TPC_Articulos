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
	public partial class Login : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["Usuario"] != null)
			{
				Response.Redirect("Catalogo.aspx", false);
			}
		}

        protected void btnLogin_Click(object sender, EventArgs e)
        {
			
			try
			{
                UsuarioNegocio negocio = new UsuarioNegocio();
				
				string user = txtUsuario.Text.Trim();
				string pass = txtPassword.Text.Trim();

                if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass)) 	
				{
					lblError.Text = "Completa ambos campos.";
					return;
				}
				Usuario logueado = negocio.Login(user, pass);
				if (logueado != null)
				{ 
                    Session["Usuario"] = logueado;

                    // SI HAY returnUrl, volver ahí
                    string returnUrl = Request.QueryString["returnUrl"];
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl, false);
                        return;
                    }

                    // Si no había returnUrl, flujo normal
                    if (logueado.EsAdmin)
                        Response.Redirect("Administracion.aspx", false);
                    else
                        Response.Redirect("Catalogo.aspx", false);

                    return;
                }
				else
				{
					lblError.Text = "Usuario o contraseña incorrectos";
				}
				
			}
			catch (Exception ex)
			{

				throw ex;
			}
        }

        protected void lnkRegistro_Click(object sender, EventArgs e)
        {
			Response.Redirect("Registro.aspx", false);
        }
    }
}