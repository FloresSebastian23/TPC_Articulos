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
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
            }
        }

        private void cargarGrilla()
        {
            ProveedorNegocio negocio = new ProveedorNegocio();
            dgvProveedores.DataSource = negocio.Listar();
            dgvProveedores.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProveedorFormulario.aspx");
        }
         
        protected void dgvProveedores_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvProveedores.SelectedRow.Cells[0].Text;
            Response.Redirect("ProveedorFormulario.aspx?id=" + id);
        }

        protected void dgvProveedores_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int id = Convert.ToInt32(dgvProveedores.Rows[index].Cells[0].Text);

                ProveedorNegocio negocio = new ProveedorNegocio();
                negocio.Eliminar(id);

                cargarGrilla();
            }
        }
    }
}