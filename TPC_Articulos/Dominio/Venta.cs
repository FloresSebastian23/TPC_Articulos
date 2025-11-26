using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TPC_Articulos.Dominio
{
   public class Venta
    {
        public int Id { get; set; }
        public string NumeroFactura { get; set; }
        public Usuario Usuario { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
        public List<VentaDetalle> Detalles { get; set; }

    }    
}

