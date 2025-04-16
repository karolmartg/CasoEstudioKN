using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CasoEstudioKN.Models
{
    public class CasasModel
    {
        public string DescripcionCasa { get; set; }
        public decimal PrecioCasa { get; set; }
        public string UsuarioAlquiler { get; set; }
        public DateTime FechaAlquiler { get; set; }
    }
}