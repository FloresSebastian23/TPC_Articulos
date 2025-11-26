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
    public partial class NuevaVenta : System.Web.UI.Page
    {
        private List<VentaDetalle> listaDetalle
        {
            get { return (List<VentaDetalle>)Session["VentaDetalle"]; }
            set { Session["VentaDetalle"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
                CargarArticulos();
                listaDetalle = new List<VentaDetalle>();
                lblTotal.Text = "0";
            }
        }

        private void CargarClientes()
        {
            ClienteNegocio negocio = new ClienteNegocio();
            ddlClientes.DataSource = negocio.Listar();
            ddlClientes.DataTextField = "NombreCompleto";
            ddlClientes.DataValueField = "Id";
            ddlClientes.DataBind();
        }

        private void CargarArticulos()
        {
            ArticuloNegocio negocio = new ArticuloNegocio();
            ddlArticulos.DataSource = negocio.Listar();
            ddlArticulos.DataTextField = "Nombre";
            ddlArticulos.DataValueField = "Id";
            ddlArticulos.DataBind();
        }

        protected void ddlArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(ddlArticulos.SelectedValue);

            ArticuloNegocio negocio = new ArticuloNegocio();
            Articulo art = negocio.ObtenerPorId(idArticulo);

            if (art != null)
                lblPrecio.Text = art.PrecioCompra.ToString("0.00");
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(ddlArticulos.SelectedValue);
            int cantidad = int.Parse(txtCantidad.Text);

            ArticuloNegocio negocio = new ArticuloNegocio();
            Articulo art = negocio.ObtenerPorId(idArticulo);

            VentaDetalle detalle = new VentaDetalle();
            detalle.IdArticulo = art.ID;
            detalle.Articulo = art.Categoria;
            detalle.Cantidad = cantidad;
            detalle.PrecioUnitario = art.PrecioCompra;
            detalle.SubTotal = art.PrecioCompra * cantidad;

            listaDetalle.Add(detalle);

            gvDetalle.DataSource = listaDetalle;
            gvDetalle.DataBind();

            ActualizarTotal();
        }

        private void ActualizarTotal()
        {
            decimal total = 0;

            // SIN foreach
            for (int i = 0; i < listaDetalle.Count; i++)
            {
                total += listaDetalle[i].Subtotal;
            }

            lblTotal.Text = total.ToString("0.00");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            VentaNegocio negocio = new VentaNegocio();

            Venta venta = new Venta();
            venta.Usuario = int.Parse(ddlClientes.SelectedValue);
            venta.Total = decimal.Parse(lblTotal.Text);
            venta.Detalles = listaDetalle;

            negocio.RegistrarVenta(venta);

            // Limpieza
            listaDetalle = new List<VentaDetalle>();
            gvDetalle.DataSource = listaDetalle;
            gvDetalle.DataBind();

            lblTotal.Text = "0";

            Response.Write("<script>alert('Venta registrada correctamente');</script>");
        }
    }
}