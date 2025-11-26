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
	public partial class ArticuloFormulario : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if(!IsPostBack)
            {
                MarcaNegocio marcaNegocio = new MarcaNegocio();
                CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
                try
                {
                    ddlMarca.DataSource = marcaNegocio.Listar();
                    ddlMarca.DataTextField = "Descripcion";
                    ddlMarca.DataValueField = "Id";
                    ddlMarca.DataBind();
                    ddlCategoria.DataSource = categoriaNegocio.Listar();
                    ddlCategoria.DataTextField = "Descripcion";
                    ddlCategoria.DataValueField = "Id";
                    ddlCategoria.DataBind();
                    if (Request.QueryString["id"] != null)
                    {
                        int id = int.Parse(Request.QueryString["id"]);
                        ArticuloNegocio articuloNegocio = new ArticuloNegocio();
                        Articulo articulo = articuloNegocio.ObtenerPorId(id);
                        txtNombre.Text = articulo.Nombre;
                        txtCodigo.Text = articulo.Codigo;
                        txtDescripcion.Text = articulo.Descripcion;
                        ddlMarca.SelectedValue = articulo.Marca.Id.ToString();
                        ddlCategoria.SelectedValue = articulo.Categoria.Id.ToString();
                        txtPrecioCompra.Text = articulo.PrecioCompra.ToString();
                        txtPorcentajeGanancia.Text = articulo.PorcentajeGanancia.ToString();
                        txtStockActual.Text = articulo.StockActual.ToString();
                        txtStockMinimo.Text = articulo.StockMinimo.ToString();
                        txtImagenUrl.Text = articulo.ImagenUrl;
                    }
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex);
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string errorMensaje = ValidarCampos();
            if (errorMensaje != null)
            {
                lblError.Text = errorMensaje;
                lblError.Visible = true;
                return;
            }

            ArticuloNegocio articuloNegocio = new ArticuloNegocio();
            Articulo articulo = new Articulo();

            articulo.Codigo = txtCodigo.Text;
            articulo.Nombre = txtNombre.Text;
            articulo.Descripcion = txtDescripcion.Text;
            articulo.ImagenUrl = txtImagenUrl.Text;
            articulo.Marca = new Marca() { Id = int.Parse(ddlMarca.SelectedValue) };
            articulo.Categoria = new Categoria() { Id = int.Parse(ddlCategoria.SelectedValue) };
            articulo.PrecioCompra = decimal.Parse(txtPrecioCompra.Text);
            articulo.PorcentajeGanancia = decimal.Parse(txtPorcentajeGanancia.Text);
            articulo.StockActual = int.Parse(txtStockActual.Text);
            articulo.StockMinimo = int.Parse(txtStockMinimo.Text);

            try
            {
                if (Request.QueryString["id"] != null) // ✅ EDITAR
                {
                    articulo.ID = int.Parse(Request.QueryString["id"]);
                    articuloNegocio.Modificar(articulo);

                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "okEditar",
                        "Swal.fire({title:'Éxito',text:'Artículo modificado correctamente',icon:'success'})" +
                        ".then(() => { window.location.href = 'Articulos.aspx'; });",
                        true);
                }
                else // ✅ AGREGAR
                {
                    articuloNegocio.Agregar(articulo);

                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "okAgregar",
                        "Swal.fire({title:'Éxito',text:'Artículo agregado correctamente',icon:'success'})" +
                        ".then(() => { window.location.href = 'Articulos.aspx'; });",
                        true);
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        private string ValidarCampos()
        {
            // Validar texto obligatorio
            if (string.IsNullOrWhiteSpace(txtNombre.Text))
                return "El nombre del artículo no puede estar vacío.";

            if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
                return "La descripción no puede estar vacía.";

            // Validar precio
            decimal precio;
            if (!decimal.TryParse(txtPrecioCompra.Text, out precio) || precio < 0)
                return "Ingrese un precio válido (número positivo).";

            // Validar stock
            int stock;
            if (!int.TryParse(txtStockActual.Text, out stock) || stock < 0)
                return "Ingrese un stock válido (número entero positivo).";

            // Validar selección del DropDownList Marca
            if (ddlMarca.SelectedIndex <= 0)
                return "Debe seleccionar una marca.";

            // Validar selección del DropDownList Categoría
            if (ddlCategoria.SelectedIndex <= 0)
                return "Debe seleccionar una categoría.";

            // Si todo OK
            return null;
        }
    }
}