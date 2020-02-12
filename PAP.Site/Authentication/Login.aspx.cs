using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Authentication
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = tbxUsername.Text;
                string password = tbxPassword.Text;
                User user = UserDAO.GetUser(username, password);
                if (user == null)
                {
                    lbMensagem.Text = "O username não existe";
                }
                else if (user.nr_attempts != 0)
                {
                    lbMensagem.Text = "Palavra-passe incorreta! Tem mais " + (4 - user.nr_attempts) + " tentativas!";
                }
                else if (user.isloocked == true)
                {
                    lbMensagem.Text = "Username encontra-se bloqueado! Data de bloqueio :" + user.locked_date_time;
                }
                else
                {
                    Session["role"] = user.Role;
                    char a = user.Role;
                    Session["username"] = user.Username;
                    FormsAuthentication.RedirectFromLoginPage("", false);
                }
            }
        }
    }
}