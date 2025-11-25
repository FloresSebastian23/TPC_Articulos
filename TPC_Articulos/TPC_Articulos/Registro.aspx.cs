using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_Articulos.Datos;

namespace TPC_Articulos
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrarse_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string pass = txtPassword.Text.Trim();

            if (usuario == "" || pass == "")
            {
                MostrarMensaje("Debe completar usuario y contraseña.");
                return;
            }

            AccesoDatos datos = new AccesoDatos();

            try
            {
                // 🔍 1) Verificar si existe usuario
                datos.SetearSP("sp_ExisteUsuario");
                datos.AgregarParametro("@UsNombree", usuario);
                datos.EjecutarLectura();

                int existe = 0;

                if (datos.Lector.Read())
                {
                    // ⚠ Acá va tu estilo de casteo
                    existe = (int)datos.Lector[0];
                }

                datos.CerrarConexion();

                if (existe > 0)
                {
                    MostrarMensaje("Ese usuario ya existe.");
                    return;
                }

                // 🟢 2) Crear nuevo usuario
                datos = new AccesoDatos();
                datos.SetearSP("sp_AgregarUsuario");
                datos.AgregarParametro("@UsNombre", usuario);
                datos.AgregarParametro("@Clave", pass);
                int esAdmin = chkAdmin.Checked ? 1 : 0;
                datos.AgregarParametro("@EsAdmin", esAdmin);
                datos.EjecutarAccion();

                MostrarMensaje("Usuario registrado exitosamente. Ya puedes iniciar sesión.");
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error: " + ex.Message);
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        private void MostrarMensaje(string msg)
        {
            lblMensaje.Visible = true;
            lblMensaje.Text = msg;
        }
    }
}