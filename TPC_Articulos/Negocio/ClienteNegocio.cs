using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TPC_Articulos.Dominio;
using TPC_Articulos.Datos;

namespace TPC_Articulos.Negocio
{
    public class ClienteNegocio
    {
        public List<Cliente> Listar()
        {
            List<Cliente> lista = new List<Cliente>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearSP("SP_ListarClientes");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Cliente aux = new Cliente();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Email = (string)datos.Lector["Email"];

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Agregar(Cliente nuevo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearSP("SP_AgregarCliente");
                datos.AgregarParametro("@Nombre", nuevo.Nombre);
                datos.AgregarParametro("@Apellido", nuevo.Apellido);
                datos.AgregarParametro("@Email", nuevo.Email);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Modificar(Cliente cli)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearSP("SP_ModificarCliente");
                datos.AgregarParametro("@Id", cli.Id);
                datos.AgregarParametro("@Nombre", cli.Nombre);
                datos.AgregarParametro("@Apellido", cli.Apellido);
                datos.AgregarParametro("@Email", cli.Email);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetearSP("SP_EliminarCliente");
                datos.AgregarParametro("@Id", id);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
