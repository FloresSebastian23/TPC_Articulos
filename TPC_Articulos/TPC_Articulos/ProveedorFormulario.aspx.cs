using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Negocio;
using TPC_Articulos.Dominio;

namespace TPC_Articulos
{
    public partial class ProvedorFormulario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = int.Parse(Request.QueryString["id"]);
                    cargarProveedor(id);
                    lblTitulo.Text = "Editar Proveedor";
                }
                else
                {
                    lblTitulo.Text = "Nuevo Proveedor";
                }
            }
        }

        private void cargarProveedor(int id)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            Proveedor prov = negocio.obtenerPorId(id);

            hfId.Value = prov.Id.ToString();
            txtNombre.Text = prov.Nombre;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            Proveedor prov = new Proveedor();

            prov.Nombre = txtNombre.Text;

            if (!string.IsNullOrEmpty(hfId.Value))
            {
                // EDITAR
                prov.Id = int.Parse(hfId.Value);
                negocio.Modificar(prov);
            }
            else
            {
                // AGREGAR
                negocio.Agregar(prov);
            }

            Response.Redirect("Provedor.aspx");
        }
    }
}