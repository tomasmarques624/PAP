using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PAP.Models
{
    public class ResetPwdRequests
    {
        public int id_resetPwdRequest { get; set; }
        public string guid { get; set; }
        public string email { get; set; }
        public DateTime date_recovery_request { get; set; }
    }
}
