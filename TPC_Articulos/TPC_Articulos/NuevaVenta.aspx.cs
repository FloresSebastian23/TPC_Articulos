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
            if (!IsPostBack)
            {
                gvDetalle.DataSource = listaDetalle;
                gvDetalle.DataBind();
            }
            // si vino desde DetalleArticulo.aspx
            if (Request.QueryString["Id"] != null && !IsPostBack)
            {
                int id = int.Parse(Request.QueryString["Id"]);
                ddlArticulos.SelectedValue = id.ToString();
                ddlArticulos_SelectedIndexChanged(null, null);
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

            if (cantidad > art.StockActual)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "stockError",
                    "Swal.fire('Error','La cantidad supera el stock disponible','error');",
                    true);
                return;
            }

            VentaDetalle detalle = new VentaDetalle();
            detalle.IdArticulo = art.ID;
            detalle.Articulo = art;
            detalle.Cantidad = cantidad;
            detalle.PrecioUnitario = art.PrecioCompra;

            listaDetalle.Add(detalle);

            gvDetalle.DataSource = listaDetalle;
            gvDetalle.DataBind();

            ActualizarTotal();
        }

        private void ActualizarTotal()
        {
            decimal total = 0;

            
            for (int i = 0; i < listaDetalle.Count; i++)
            {
                total += listaDetalle[i].SubTotal;
            }

            lblTotal.Text = total.ToString("0.00");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            VentaNegocio negocio = new VentaNegocio();

            Venta venta = new Venta();
            venta.Usuario = (Usuario)Session["Usuario"];
            venta.IdUsuario = venta.Usuario.Id;
            venta.Total = decimal.Parse(lblTotal.Text);
            venta.Detalles = listaDetalle;

            negocio.RegistrarVenta(venta);

            
            listaDetalle = new List<VentaDetalle>();
            gvDetalle.DataSource = listaDetalle;
            gvDetalle.DataBind();

            lblTotal.Text = "0";

            ScriptManager.RegisterStartupScript(this, this.GetType(),"alert", "Swal.fire('Éxito','Venta registrada correctamente','success');",true);

            
        }

        protected void gvDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Quitar")
            {
                // El índice de la fila viene en CommandArgument
                int index = Convert.ToInt32(e.CommandArgument);

                // Quitar el ítem de la lista
                listaDetalle.RemoveAt(index);

                // Rebind
                gvDetalle.DataSource = listaDetalle;
                gvDetalle.DataBind();

                // Actualizar total
                ActualizarTotal();
            }
        }
    }
}