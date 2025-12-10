using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPC_Articulos.Datos;
using TPC_Articulos.Dominio;

namespace TPC_Articulos.Negocio
{
    public class ArticuloNegocio
    { 
        public List<Articulo> Listar()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.SetConsulta("SELECT  A.Id, A.Nombre, A.IdMarca, M.Descripcion AS Marca, A.IdCategoria, C.Descripcion AS Categoria, A.PrecioCompra, A.PorcentajeGanancia, A.StockActual, A.StockMinimo, A.ImagenUrl  FROM Articulos A INNER JOIN Marcas M ON M.Id = A.IdMarca INNER JOIN Categorias C ON C.Id = A.IdCategoria WHERE A.Estado = 1;");

                datos.EjecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();

                    aux.ID = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

                    aux.Marca = new Marca();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Descripcion = (string)datos.Lector["Marca"];

                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];

                    aux.PrecioCompra = (decimal)datos.Lector["PrecioCompra"];
                    aux.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.StockMinimo = (int)datos.Lector["StockMinimo"];

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        aux.ImagenUrl = (string)datos.Lector["ImagenUrl"];

                    lista.Add(aux);
                }

                return lista;
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



        public void Agregar(Articulo nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_AgregarArticulo");
                datos.AgregarParametro("@Nombre", nuevo.Nombre);
                datos.AgregarParametro("@Codigo", nuevo.Codigo);
                datos.AgregarParametro("@Descripcion", nuevo.Descripcion);
                datos.AgregarParametro("@IdCategoria", nuevo.Categoria.Id);
                datos.AgregarParametro("@PrecioCompra", nuevo.PrecioCompra);
                datos.AgregarParametro("@PorcentajeGanancia", nuevo.PorcentajeGanancia);
                datos.AgregarParametro("@StockActual", nuevo.StockActual);
                datos.AgregarParametro("@StockMinimo", nuevo.StockMinimo);
                datos.AgregarParametro("@IdMarca", nuevo.Marca.Id);
                datos.AgregarParametro("@ImagenUrl", nuevo.ImagenUrl ?? (object)DBNull.Value);
                datos.EjecutarAccion();
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

        public void Modificar(Articulo articulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_ModificarArticulo");
                datos.AgregarParametro("@Id", articulo.ID);
                datos.AgregarParametro("@Nombre", articulo.Nombre);
                datos.AgregarParametro("@Codigo", articulo.Codigo);
                datos.AgregarParametro("@Descripcion", articulo.Descripcion);
                datos.AgregarParametro("@IdMarca", articulo.Marca.Id);
                datos.AgregarParametro("@IdCategoria", articulo.Categoria.Id);
                datos.AgregarParametro("@PrecioCompra", articulo.PrecioCompra);
                datos.AgregarParametro("@PorcentajeGanancia", articulo.PorcentajeGanancia);
                datos.AgregarParametro("@StockActual", articulo.StockActual);
                datos.AgregarParametro("@StockMinimo", articulo.StockMinimo);
                datos.AgregarParametro("@ImagenUrl", articulo.ImagenUrl ?? (object)DBNull.Value);

                datos.EjecutarAccion();
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

        public void Eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetearSP("sp_EliminarArticulo");
                datos.AgregarParametro("@Id", id);
                datos.EjecutarAccion();
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
        public Articulo ObtenerPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Articulo articulo = null;
            try
            {
                datos.SetConsulta("SELECT A.Id, A.Nombre, A.IdMarca, M.Descripcion AS Marca, A.IdCategoria, C.Descripcion AS Categoria, A.PrecioCompra, A.PorcentajeGanancia, A.StockActual, A.StockMinimo, A.ImagenUrl FROM Articulos A INNER JOIN Marcas M ON M.Id = A.IdMarca INNER JOIN Categorias C ON C.Id = A.IdCategoria WHERE A.Id = @Id AND A.Estado = 1;");
                datos.AgregarParametro("@Id", id);
                datos.EjecutarLectura();
                if (datos.Lector.Read())
                {
                    articulo = new Articulo();
                    articulo.ID = (int)datos.Lector["Id"];
                    articulo.Nombre = (string)datos.Lector["Nombre"];
                    articulo.Marca = new Marca();
                    articulo.Marca.Id = (int)datos.Lector["IdMarca"];
                    articulo.Marca.Descripcion = (string)datos.Lector["Marca"];
                    articulo.Categoria = new Categoria();
                    articulo.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    articulo.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                    articulo.PrecioCompra = (decimal)datos.Lector["PrecioCompra"];
                    articulo.PorcentajeGanancia = (decimal)datos.Lector["PorcentajeGanancia"];
                    articulo.StockActual = (int)datos.Lector["StockActual"];
                    articulo.StockMinimo = (int)datos.Lector["StockMinimo"];
                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        articulo.ImagenUrl = (string)datos.Lector["ImagenUrl"];
                }
                return articulo;
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

