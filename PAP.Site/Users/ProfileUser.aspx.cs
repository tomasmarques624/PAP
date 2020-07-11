using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Users
{
    public partial class ProfileUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lbTitulo.Text = Session["username"].ToString();
                User user = UserDAO.GetUserByUsername(Session["username"].ToString());
                lbUsername.Text = user.Username;
                lbNome.Text = user.Nome;
                lbEmail.Text = user.Email;
                string jpg = "/Content/Imagens/Users/" + user.Username + ".png";
                if (File.Exists(Server.MapPath(jpg)))
                {
                    avatar.ImageUrl = jpg;
                }
                else
                {
                    avatar.ImageUrl = "../../Content/Imagens/Users/Default.png";
                }
            }
        }

        protected void buttonLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Response.Redirect("~/Authentication/Home.aspx");
        }

        protected void btSim_Click(object sender, EventArgs e)
        {
            string username = lbUsername.Text;
            string password = tbxPassAtual.Text;
            int returnCode = UserDAO.VerifyPass(username, password);
            if (returnCode == -1)
            {
                lbMensagem.Text = "A password não corresponde à atual.";
                MPE_Pass.Show();
            }
            else
            {
                int returncode = UserDAO.UpdatePass(username, tbxPassNova.Text);
                if (returncode == -1)
                {
                    String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    tbxPassAtual.Text = "";
                    tbxPassConfirmar.Text = "";
                    tbxPassNova.Text = "";
                }
                else
                {
                    String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    tbxPassAtual.Text = "";
                    tbxPassConfirmar.Text = "";
                    tbxPassNova.Text = "";
                }
            }
            rfvConfirmPass.Enabled = false;
            rfvPass.Enabled = false;
            rfvNewPass.Enabled = false;
            btSim.CausesValidation = false;
        }

        protected void btNao_Click(object sender, EventArgs e)
        {
            MPE_Pass.Hide();
            rfvConfirmPass.Enabled = false;
            rfvPass.Enabled = false;
            rfvNewPass.Enabled = false;
            btSim.CausesValidation = false;
            tbxPassAtual.Text = "";
            tbxPassConfirmar.Text = "";
            tbxPassNova.Text = "";
        }

        protected void btAltPass_Click(object sender, EventArgs e)
        {
            rfvConfirmPass.Enabled = true;
            rfvPass.Enabled = true;
            rfvNewPass.Enabled = true;
            btSim.CausesValidation = true;
            MPE_Pass.Show();
        }
    }
}