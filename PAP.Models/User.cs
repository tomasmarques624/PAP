using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.Models
{
    public class User
    {
        public int id_User { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Nome { get; set; }
        public char Role { get; set; }
        public bool? isloocked { get; set; }
        public int? nr_attempts { get; set; }
        public DateTime? locked_date_time { get; set; }
    }
}
