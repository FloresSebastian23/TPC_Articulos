using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TPC_Articulos.Dominio
{
   public class CompraDetalle
    {
        public int Id { get; set; }
        public int IdArticulo { get; set; }
        public Articulo Articulo { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }

        public decimal Subtotal => Cantidad * PrecioUnitario;
    }
}
