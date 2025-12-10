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
            get
            {
                if (Session["VentaDetalle"] == null)
                    Session["VentaDetalle"] = new List<VentaDetalle>();

                return (List<VentaDetalle>)Session["VentaDetalle"];
            }
            set { Session["VentaDetalle"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
                CargarArticulos();
                lblTotal.Text = "0.00";

                // Si vino desde Detalle.aspx con un artículo preseleccionado
                int articuloId;
                if (int.TryParse(Request.QueryString["articuloId"], out articuloId))
                {
                    ddlArticulos.SelectedValue = articuloId.ToString();
                    ddlArticulos_SelectedIndexChanged(null, null);
                }

                gvDetalle.DataSource = listaDetalle;
                gvDetalle.DataBind();
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
            ddlArticulos.DataValueField = "ID"; 
            ddlArticulos.DataBind();
        }

        protected void ddlArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(ddlArticulos.SelectedValue);

            ArticuloNegocio negocio = new ArticuloNegocio();
            Articulo art = negocio.ObtenerPorId(idArticulo);

            if (art != null)
            {
                // PRECIO DE VENTA = precio compra + % ganancia
                decimal precioVenta = art.PrecioCompra * (1 + (art.PorcentajeGanancia / 100m));
                lblPrecio.Text = precioVenta.ToString("0.00");
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            // Validar cantidad
            int cantidad;
            if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "cantidadError",
                    "Swal.fire('Error','Ingrese una cantidad válida mayor a cero','error');",
                    true);
                return;
            }

            int idArticulo = int.Parse(ddlArticulos.SelectedValue);

            ArticuloNegocio negocio = new ArticuloNegocio();
            Articulo art = negocio.ObtenerPorId(idArticulo);

            if (art == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "artError",
                    "Swal.fire('Error','No se pudo obtener el artículo seleccionado','error');",
                    true);
                return;
            }

            // Calcular la cantidad total (ya cargada + nueva)
            int cantidadAcumulada = 0;
            for (int i = 0; i < listaDetalle.Count; i++)
            {
                if (listaDetalle[i].IdArticulo == idArticulo)
                    cantidadAcumulada += listaDetalle[i].Cantidad;
            }

            int cantidadTotal = cantidadAcumulada + cantidad;

            // Validar stock disponible
            if (cantidadTotal > art.StockActual)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "stockError",
                    $"Swal.fire('Error','Stock insuficiente. Disponible: {art.StockActual}','error');",
                    true);
                return;
            }

            // Si ya existe el artículo en la lista, actualizar cantidad
            for (int i = 0; i < listaDetalle.Count; i++)
            {
                if (listaDetalle[i].IdArticulo == idArticulo)
                {
                    listaDetalle[i].Cantidad += cantidad;

                    gvDetalle.DataSource = listaDetalle;
                    gvDetalle.DataBind();
                    ActualizarTotal();
                    return;
                }
            }

            // Crear nuevo detalle
            VentaDetalle detalle = new VentaDetalle();
            detalle.IdArticulo = art.ID;
            detalle.Articulo = art;
            detalle.Cantidad = cantidad;

            // PRECIO DE VENTA = precio compra + % ganancia
            decimal precioVentaUnitario = art.PrecioCompra * (1 + (art.PorcentajeGanancia / 100m));
            detalle.PrecioUnitario = precioVentaUnitario;

            listaDetalle.Add(detalle);

            gvDetalle.DataSource = listaDetalle;
            gvDetalle.DataBind();

            ActualizarTotal();
        }

        private void ActualizarTotal()
        {
            decimal total = 0;

            for (int i = 0; i < listaDetalle.Count; i++)
                total += listaDetalle[i].SubTotal;

            lblTotal.Text = total.ToString("0.00");
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            // Validar que haya al menos un ítem
            if (listaDetalle == null || listaDetalle.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "sinItems",
                    "Swal.fire('Atención','Debe agregar al menos un artículo a la venta','warning');",
                    true);
                return;
            }

            // Validar cliente seleccionado (aunque hoy no lo guardes en BD)
            int idCliente;
            if (!int.TryParse(ddlClientes.SelectedValue, out idCliente))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "clienteError",
                    "Swal.fire('Error','Seleccione un cliente válido','error');",
                    true);
                return;
            }

            try
            {
                VentaNegocio negocio = new VentaNegocio();

                Venta venta = new Venta();
                venta.Usuario = (Usuario)Session["Usuario"];
                venta.IdUsuario = venta.Usuario.Id;
                venta.Total = decimal.Parse(lblTotal.Text);
                venta.Detalles = listaDetalle;

                // Registrar venta (SP valida stock y descuenta)
                negocio.RegistrarVenta(venta);

                // Limpiar
                listaDetalle = new List<VentaDetalle>();
                gvDetalle.DataSource = listaDetalle;
                gvDetalle.DataBind();
                lblTotal.Text = "0.00";
                txtCantidad.Text = "";

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "okVenta",
                    "Swal.fire('Éxito','Venta registrada correctamente','success');",
                    true);
            }
            catch (Exception ex)
            {
                // Si el SP tira RAISERROR por stock u otra cosa, cae acá
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "errVenta",
                    $"Swal.fire('Error','No se pudo registrar la venta: {ex.Message}','error');",
                    true);
            }
        }

        protected void gvDetalle_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Quitar")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                if (index >= 0 && index < listaDetalle.Count)
                {
                    listaDetalle.RemoveAt(index);
                    gvDetalle.DataSource = listaDetalle;
                    gvDetalle.DataBind();
                    ActualizarTotal();
                }
            }
        }
    }
}