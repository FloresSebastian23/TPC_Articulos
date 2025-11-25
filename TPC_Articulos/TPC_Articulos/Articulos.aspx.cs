using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Negocio;

namespace TPC_Articulos
{
	public partial class Articulos : System.Web.UI.Page
	{
        ArticuloNegocio negocio = new ArticuloNegocio();
        protected void Page_Load(object sender, EventArgs e)
		{
            if(!IsPostBack)
            {
                try
                {
                    dgvArticulos.DataSource = negocio.Listar();
                    dgvArticulos.DataBind();
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex);
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ArticuloFormulario.aspx");
        }

        protected void dgvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvArticulos.SelectedDataKey.Value.ToString();
            Response.Redirect("ArticuloFormulario.aspx?id=" + id);
        }
        protected void btnEliminar_click(object sender, GridViewPageEventArgs e)
        {
            int id = int.Parse((sender as Button).CommandArgument);
            try
            {
                negocio.Eliminar(id);
                dgvArticulos.DataSource = negocio.Listar();
                dgvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx");
            }
        }

    }

}