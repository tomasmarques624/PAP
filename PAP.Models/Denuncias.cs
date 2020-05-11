using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.Models
{
    public class Denuncias
    {
        public int id_denuncia { get; set; }
        public string problema { get; set; }
        public DateTime data_denuncia { get; set; }
        public char estado { get; set; }
        public char prioridade { get; set; }
        public int id_user { get; set; }
        public int id_equip { get; set; }
    }
}
