using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TPC_Articulos.Datos;
using TPC_Articulos.Dominio;

namespace TPC_Articulos.Negocio
{
    public class ProveedorNegocio
    {
        public List<Proveedor> Listar()
        {
            List<Proveedor> lista = new List<Proveedor>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetConsulta("SELECT Id, Nombre FROM Proveedores");
                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Proveedor aux = new Proveedor();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Agregar(Proveedor nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("INSERT INTO Proveedores (Nombre) VALUES (@Nombre)");
                datos.AgregarParametro("@Nombre", nuevo.Nombre);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void Modificar(Proveedor prov)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("UPDATE Proveedores SET Nombre = @Nombre WHERE Id = @Id");
                datos.AgregarParametro("@Nombre", prov.Nombre);
                datos.AgregarParametro("@Id", prov.Id);
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
                datos.SetConsulta("DELETE FROM Proveedores WHERE Id = @Id");
                datos.AgregarParametro("@Id", id);
                datos.EjecutarAccion();
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public Proveedor obtenerPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetConsulta("SELECT Id, Nombre FROM Proveedores WHERE Id = @Id");
                datos.AgregarParametro("@Id", id);
                datos.EjecutarLectura();

                if (datos.Lector.Read())
                {
                    Proveedor prov = new Proveedor();
                    prov.Id = (int)datos.Lector["Id"];
                    prov.Nombre = datos.Lector["Nombre"].ToString();

                    return prov;
                }

                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
