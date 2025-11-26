using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TPC_Articulos.Dominio;
using TPC_Articulos.Datos;

namespace TPC_Articulos.Negocio
{
    class CompraNegocio
    {
        public int RegistrarCompra(Compra compra)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                // SP para insertar compra
                datos.SetearSP("SP_Compras_Agregar");
                datos.AgregarParametro("@IdProveedor", compra.Proveedor.Id);
                datos.AgregarParametro("@Total", compra.Total);

                int idCompra = (int)datos.Lector["IdProveedor"];
                datos.CerrarConexion();

                // Insertar detalle(s)
                for (int i = 0; i < compra.Detalles.Count; i++)
                {
                    var d = compra.Detalles[i];

                    datos = new AccesoDatos();
                    datos.SetearSP("SP_CompraDetalle_Agregar");
                    datos.AgregarParametro("@IdCompra", idCompra);
                    datos.AgregarParametro("@IdArticulo", d.IdArticulo);
                    datos.AgregarParametro("@Cantidad", d.Cantidad);
                    datos.AgregarParametro("@PrecioUnitario", d.PrecioUnitario);
                    datos.AgregarParametro("@Subtotal", d.Subtotal);

                    datos.EjecutarAccion();
                    datos.CerrarConexion();
                }

                return idCompra;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
