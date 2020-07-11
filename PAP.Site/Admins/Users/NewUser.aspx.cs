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
                    Nome = tbxNome.Text,
                    Role = 'U'
                };
                int returncode = UserDAO.RegisterUser(user);
                if (returncode == -1)
                {
                    String str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    lbErro.Text = "Ja existe uma sala com este nome.";
                    MPE_Erro.Show();
                }
                else
                {
                    if (fluFoto.HasFile == true)
                    {
                        fluFoto.PostedFile.SaveAs(Server.MapPath("~/Content/Imagens/Users/") + user.Username + ".png");
                    }
                    String str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);

                    btCancelar.Attributes.Add("onclick", "history.go(-4);location.reload();");
                    btCancelar.Text = "Voltar";
                    tbxNome.Enabled = false;
                    tbxUsername.Enabled = false;
                    tbxPassword.Enabled = false;
                    tbxConfirmPassword.Enabled = false;
                    tbxEmail.Enabled = false;
                    btRegistar.Enabled = false;
                }
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/Users/Users.aspx");
        }
    }
}