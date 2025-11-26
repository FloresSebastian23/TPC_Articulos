using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_Articulos.Dominio
{
	public class Cliente
	{
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }

        public string NombreCompleto
        {
            get { return Nombre + " " + Apellido; }
        }
    }
     
}