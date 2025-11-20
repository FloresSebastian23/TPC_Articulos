using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_Articulos.Dominio
{
	public class Usuario
	{
        public int Id { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }
        public bool EsAdmin { get; set; }
    }
}