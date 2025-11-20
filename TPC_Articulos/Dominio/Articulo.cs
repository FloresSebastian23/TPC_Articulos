using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_Articulos.Dominio
{
	public class Articulo
	{
        public int ID { get; set; }
        public string Nombre { get; set; }
        public Marca Marca { get; set; }
        public Categoria Categoria { get; set; }
        public string ImagenUrl { get; set; }
        public decimal PrecioCompra { get; set; }
        public decimal PorcentajeGanancia { get; set; }
        public int StockActual { get; set; }
        public int StockMinimo { get; set; }
        
    }
}