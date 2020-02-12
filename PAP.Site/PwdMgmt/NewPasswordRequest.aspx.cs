using PAP.DataAccess.PasswordDA;
using PAP.DataAccess.UserDA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.PwdMgmt
{
    public partial class NewPasswordRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btPedir_Click(object sender, EventArgs e)
        {
            if (UserDAO.GetUserByEmail(tbxEmail.Text) == null)
            {
                lbMensagem.ForeColor = System.Drawing.Color.Red;
                lbMensagem.Text = "Email inválido!<br />Contacte o administrador ou tente novamente...";
                hlLogin.Text = "Voltar";
            }
            else
            {
                lbMensagem.ForeColor = System.Drawing.Color.Green;
                lbMensagem.Text = "Pedido Efetuado com sucesso! Instruções foram enviadas para o seu email.";

                tbxEmail.Enabled = false;
                btPedir.Enabled = false;
                hlLogin.Text = "Voltar";

                string guid = PasswordDAO.InsertNewResetPwdRequest(tbxEmail.Text);

                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("likedat6969@gmail.com");
                mailMessage.To.Add(tbxEmail.Text);
                mailMessage.Subject = "Reposição de password";
                mailMessage.Body = "Clique aqui para repor a sua password : https://localhost:44344/PwdMgmt/SetNewPassword.aspx?guid=" + guid;
                mailMessage.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                smtpClient.Send(mailMessage);
            }
        }
    }
}
