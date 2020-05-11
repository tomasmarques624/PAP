using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.Models
{
    public class Equip
    {
        public int id_equip { get; set; }
        public string descri { get; set; }
        public bool disp { get; set; }
        public int id_cat { get; set; }
        public int id_sala { get; set; }
    }
}
