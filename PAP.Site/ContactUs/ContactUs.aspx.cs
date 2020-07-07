using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PAP.Site.ContactUs
{
    public partial class ContactUs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            bool b = false;
            try
            {
                using (var client = new WebClient())
                using (client.OpenRead("http://google.com/generate_204"))
                    b = true;
            }
            catch
            {
                b = false;
            }
            if (b == true)
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("likedat6969@gmail.com");
                mailMessage.To.Add("likedat6969@gmail.com");
                mailMessage.Subject = tbxAssunto.Text;
                mailMessage.Body = "<h3>G.E.T</h3><br/><b>Remente: </b>" + tbxNome.Text + "<br/>" + "<b>Email do remetente: </b>" + tbxEmail.Text + "<br/>" + "<b>Mensagem: </b>" + tbxMensagem.Text;
                mailMessage.IsBodyHtml = true;

                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                smtpClient.Send(mailMessage);

                String str = "<script>alertify.success('Email enviado com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                tbxMensagem.Enabled = false;
                tbxNome.Enabled = false;
                tbxEmail.Enabled = false;
                tbxAssunto.Enabled = false;
                btEnviar.Enabled = false;
            }
            else
            {
                tbxMensagem.Enabled = false;
                btEnviar.Enabled = false;
                tbxNome.Enabled = false;
                tbxEmail.Enabled = false;
                tbxAssunto.Enabled = false;
                String str1 = "<script>alertify.error('Sem ligação! Email não enviado.');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str1, false);
            }
        }
    }
}