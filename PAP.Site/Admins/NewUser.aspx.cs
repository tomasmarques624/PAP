using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins
{
    public partial class NewUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btRegistar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                User user = new User()
                {
                    Username = tbxUsername.Text,
                    Password = tbxPassword.Text,
                    Email = tbxEmail.Text,
                    Role = 'U'
                };
                int returncode = UserDAO.RegisterUser(user);
                if (returncode == -1)
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Red;
                    lbMensagem.Text = "Adicao falhada!<br />Tente novamente mais tarde.";
                }
                else
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Green;
                    lbMensagem.Text = "Adicao Efetuada com sucesso!";

                    tbxUsername.Enabled = false;
                    tbxPassword.Enabled = false;
                    tbxConfirmPassword.Enabled = false;
                    tbxEmail.Enabled = false;
                    btCancelar.Text = "Voltar";
                    btRegistar.Enabled = false;
                }
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/Users.aspx");
        }
    }
}