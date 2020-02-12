using PAP.DataAccess.PasswordDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.PwdMgmt
{
    public partial class SetNewPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btConfirmar_Click(object sender, EventArgs e)
        {
            string guid = Request.QueryString["guid"];
            if (PasswordDAO.GetNewPwdRequestDataByGUID(guid) == null)
            {
                lbMensagem.ForeColor = System.Drawing.Color.Red;
                lbMensagem.Text = "Guid inválido!<br />Contacte o administrador ou faça um novo pedido...";
                tbxConfirmPassword.Enabled = false;
                tbxPassword.Enabled = false;
                btConfirmar.Enabled = false;
                hlLogin.Text = "Voltar";
            }
            else
            {
                ResetPwdRequests resetPwd = PasswordDAO.GetNewPwdRequestDataByGUID(guid);
                User user = UserDAO.GetUserByEmail(resetPwd.email);
                int returncode = PasswordDAO.ResetPassword(user.id_User, tbxPassword.Text);
                if (returncode == -1)
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Red;
                    lbMensagem.Text = "Guid inválido!<br />Contacte o administrador ou faça um novo pedido...";
                    tbxConfirmPassword.Enabled = false;
                    tbxPassword.Enabled = false;
                    btConfirmar.Enabled = false;
                    hlLogin.Text = "Voltar";
                }
                else
                {
                    int return_code = PasswordDAO.DeletePwdRequestByEmail(resetPwd.email);
                    if (return_code == -1)
                    {
                        lbMensagem.ForeColor = System.Drawing.Color.Red;
                        lbMensagem.Text = "Guid inválido!<br />Contacte o administrador ou faça um novo pedido...";
                        tbxConfirmPassword.Enabled = false;
                        tbxPassword.Enabled = false;
                        btConfirmar.Enabled = false;
                        hlLogin.Text = "Voltar";
                    }
                    else
                    {
                        lbMensagem.ForeColor = System.Drawing.Color.Green;
                        lbMensagem.Text = "Reposição efetuada com sucesso!";
                        tbxConfirmPassword.Enabled = false;
                        tbxPassword.Enabled = false;
                        btConfirmar.Enabled = false;
                        hlLogin.Text = "Voltar";
                    }
                }
            }
        }
    }
}