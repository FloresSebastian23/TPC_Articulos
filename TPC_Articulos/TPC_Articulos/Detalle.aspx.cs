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
    public partial class Detalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //  Valido el ID
            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                lblError.Text = "Artículo no válido.";
                return;
            }

            //  Si no hay login voy  al login 
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx?returnUrl=Detalle.aspx?id=" + id, false);
                return;
            }

            //  Cargar el artículo 
            if (!IsPostBack)
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                Articulo art = negocio.Listar().Find(x => x.ID == id);

                if (art == null)
                {
                    lblError.Text = "No se encontró el artículo.";
                    return;
                }

                // Muestra artículo
                imgArticulo.Src = art.ImagenUrl;
                lblNombre.InnerText = art.Nombre;
                lblMarca.InnerText = art.Marca.Descripcion;
                lblDescripcion.InnerText = art.Categoria.Descripcion;

                pnlDetalle.Visible = true;
            }
        }
    }
}