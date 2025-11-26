using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Datos;
using TPC_Articulos.Dominio;
using TPC_Articulos.Negocio;


namespace TPC_Articulos
{
    public partial class ClienteFormulario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                int id = int.Parse(Request.QueryString["id"]);

                ClienteNegocio negocio = new ClienteNegocio();
                TPC_Articulos.Dominio.Cliente cli = negocio.Listar().Find(x => x.Id == id);

                if (cli != null)
                {
                    txtNombre.Text = cli.Nombre;
                    txtApellido.Text = cli.Apellido;
                    txtEmail.Text = cli.Email;
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            ClienteNegocio negocio = new ClienteNegocio();
            TPC_Articulos.Dominio.Cliente cli = new TPC_Articulos.Dominio.Cliente();

            cli.Nombre = txtNombre.Text;
            cli.Apellido = txtApellido.Text;
            cli.Email = txtEmail.Text;

            try
            {
                if (Request.QueryString["id"] != null)
                {
                    cli.Id = int.Parse(Request.QueryString["id"]);
                    negocio.Modificar(cli);

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "okEditar",
                        "Swal.fire('Éxito','Cliente modificado correctamente','success')" +
                        ".then(() => { window.location.href = '~/Clientes.aspx'; });",
                        true);
                }
                else
                {
                    negocio.Agregar(cli);

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "okAgregar",
                        "Swal.fire('Éxito','Cliente agregado correctamente','success')" +
                        ".then(() => { window.location.href = '~/Clientes.aspx'; });",
                        true);
                }
            }
            catch (Exception ex)
            {
                Session["Error"] = ex;
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}
