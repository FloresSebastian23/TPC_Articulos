using System;
using System.Data.SqlClient;
using TPC_Articulos.Datos;
using TPC_Articulos.Dominio;

namespace TPC_Articulos.Negocio
{
    public class UsuarioNegocio
    {
        public bool ExisteUsuario(string user)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_ExisteUsuario");
                datos.AgregarParametro("@UserName", user);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    int existe = (int)datos.Lector["Existe"];
                    return existe > 0;
                }

                return false;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Registrar(Usuario nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_AgregarUsuario");
                datos.AgregarParametro("@UserName", nuevo.User);
                datos.AgregarParametro("@Pass", nuevo.Pass);
                datos.AgregarParametro("@EsAdmin", nuevo.EsAdmin);

                datos.EjecutarLectura();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public Usuario Login(string user, string pass)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_Login");
                datos.AgregarParametro("@UsNombre", user);
                datos.AgregarParametro("@Pass", pass);

                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario aux = new Usuario
                    {
                        Id = (int)datos.Lector["Id"],
                        User = (string)datos.Lector["NombreUsuario"],
                        EsAdmin = (bool)datos.Lector["EsAdmin"]
                    };

                    return aux;
                }

                return null; 
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}