using System;
using System.Collections.Generic;
using System.Linq;
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
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("likedat6969@gmail.com");
            mailMessage.To.Add("likedat6969@gmail.com");
            mailMessage.Subject = tbxAssunto.Text;
            mailMessage.Body = "<b>Remente: </b>" + tbxNome.Text + "<br/>" + "<b>Email do remetente: </b>" + tbxEmail.Text + "<br/>" + "<b>Mensagem: </b>" + tbxMensagem.Text;
            mailMessage.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.EnableSsl = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
            smtpClient.Send(mailMessage);

            lbMensagem.ForeColor = System.Drawing.Color.Blue;
            lbMensagem.Text = "Mensagem enviada com sucesso.";
            tbxMensagem.Enabled = false;
            tbxNome.Enabled = false;
            tbxEmail.Enabled = false;
            tbxAssunto.Enabled = false;
        }
    }
}