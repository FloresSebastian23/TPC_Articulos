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
            if (!IsPostBack)
            {
                // Verificar sesión: si no hay usuario, redirigir al login
                if (Session["Usuario"] == null)
                {
                    string returnUrl = Server.UrlEncode(Request.RawUrl);
                    Response.Redirect("Login.aspx?returnUrl=" + returnUrl);
                    return;
                }

                // Obtener el id del artículo desde la query string
                int id;
                if (!int.TryParse(Request.QueryString["id"], out id))
                {
                    // Si no es válido, redirigir al catálogo
                    Response.Redirect("Catalogo.aspx");
                    return;
                }

                // Obtener el artículo desde negocio
                ArticuloNegocio negocio = new ArticuloNegocio();
                Articulo articulo = negocio.ObtenerPorId(id);

                if (articulo == null)
                {
                    // Si no existe el artículo
                    Response.Redirect("Catalogo.aspx");
                    return;
                }

                // Cargar datos en la vista
                lblNombre.Text = articulo.Nombre;
                lblDescripcion.Text = articulo.Descripcion;
                lblMarca.Text = articulo.Marca.Descripcion;
                lblCategoria.Text = articulo.Categoria.Descripcion;
                lblPrecioCompra.Text = articulo.PrecioCompra.ToString("C");
                lblPorcentajeGanancia.Text = articulo.PorcentajeGanancia.ToString("N2") + " %";
                lblStockActual.Text = articulo.StockActual.ToString();
                lblStockMinimo.Text = articulo.StockMinimo.ToString();

                // Imagen: si no tiene URL, poner placeholder
                if (string.IsNullOrEmpty(articulo.ImagenUrl))
                {
                    imgProducto.ImageUrl = "https://via.placeholder.com/300x300?text=Sin+Imagen%22;";
                }
                else
                {
                    imgProducto.ImageUrl = articulo.ImagenUrl;
                }
            }
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            int IdArticulo = int.Parse(Request.QueryString["id"]);
            Response.Redirect("NuevaVenta.aspx?articuloId=" + IdArticulo);
        }
    }
}