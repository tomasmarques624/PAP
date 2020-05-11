using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.Models
{
    public class Requisicoes
    {
        public int id_requisicao { get; set; }
        public DateTime data_requisicao { get; set; }
        public DateTime data_requisicao_final { get; set; }
        public bool estado { get; set; }
        public int id_user { get; set; }
        public int id_equip { get; set; }
    }
}
