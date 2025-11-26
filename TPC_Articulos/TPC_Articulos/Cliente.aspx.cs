using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Negocio;
using TPC_Articulos.Datos;

namespace TPC_Articulos
{
	public partial class Cliente : System.Web.UI.Page
    {
        ClienteNegocio negocio = new ClienteNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrilla();
            }
        }

        private void CargarGrilla()
        {
            dgvClientes.DataSource = negocio.Listar();
            dgvClientes.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClienteFormulario.aspx");
        }

        protected void dgvClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvClientes.SelectedDataKey.Value.ToString();
            Response.Redirect("ClienteFormulario.aspx?id=" + id);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int id = int.Parse(btn.CommandArgument);

            negocio.Eliminar(id);
            CargarGrilla();
        }
    }
}
