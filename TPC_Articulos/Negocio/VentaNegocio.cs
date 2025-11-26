using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TPC_Articulos.Datos;
using TPC_Articulos.Dominio;

namespace TPC_Articulos.Negocio
{
    public class VentaNegocio
    {
        private string GenerarNumeroFactura()
        {
            return "F" + DateTime.Now.ToString("yyyyMMddHHmmss");
        }

        public int RegistrarVenta(Venta venta)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                venta.NumeroFactura = GenerarNumeroFactura();

                // Insertar venta
                datos.SetearSP("SP_Ventas_Agregar");
                datos.AgregarParametro("@NumeroFactura", venta.NumeroFactura);
                datos.AgregarParametro("@IdUsuario", venta.Usuario.Id);
                datos.AgregarParametro("@Total", venta.Total);
                datos.EjecutarLectura();

                int idVenta = 0;
                if (datos.Lector.Read())
                {
                    idVenta = (int)datos.Lector["IdVenta"]; 
                }
                datos.CerrarConexion();

                // Insertar detalles
                for (int i = 0; i < venta.Detalles.Count; i++)
                {
                    var d = venta.Detalles[i];

                    datos = new AccesoDatos();

                    datos.SetearSP("SP_VentaDetalle_Agregar");
                    datos.AgregarParametro("@IdVenta", idVenta);
                    datos.AgregarParametro("@IdArticulo", d.IdArticulo);
                    datos.AgregarParametro("@Cantidad", d.Cantidad);
                    datos.AgregarParametro("@PrecioUnitario", d.PrecioUnitario);
                    datos.AgregarParametro("@Subtotal", d.SubTotal);

                    datos.EjecutarAccion();
                    datos.CerrarConexion();
                }

                return idVenta;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
} 