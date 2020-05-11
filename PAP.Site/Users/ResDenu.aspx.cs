using PAP.DataAccess.DenunciasDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Users
{
    public partial class ResDenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataBindGrid();
            }
        }
        public void DataBindGrid()
        {
            User user = UserDAO.GetUserByEmail(Session["email"].ToString());
            List<Requisicoes> listRequisicoes = RequisicoesDAO.GetUserReq(user.id_User);
            gvReqList.DataSource = listRequisicoes;
            gvReqList.DataBind();

            List<Denuncias> listDenuncias = DenunciasDAO.GetUserDenu(user.id_User);
            gvDenuList.DataSource = listDenuncias;
            gvDenuList.DataBind();
        }

        protected void gvReqList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Requisicoes req = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (req.estado == false)
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstado");
                    lbEstado.Text = "N/A";
                    lbEstado.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstado");
                    lbEstado.Text = "Aprovada";
                    lbEstado.ForeColor = System.Drawing.Color.Green;
                }

                Equip equip = EquipDAO.GetEquipByID(req.id_equip);
                Label lbEquip = (Label)e.Row.FindControl("lbEquip");
                lbEquip.Text = equip.descri;
            }
        }

        protected void buttonLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Response.Redirect("~/Authentication/Login.aspx");
        }

        protected void lkQrCode_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkQrCode = (LinkButton)gvDenuList.Rows[index].FindControl("lkQrCode");
            int id_denuncia = Convert.ToInt32(gvDenuList.Rows[index].Cells[0].Text);
            MPE_QrCode.Show();
            Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(id_denuncia);
            string code = denuncia.problema;
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(code, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            QRCode qrCode = new QRCode(qrCodeData);
            imgBarCode.Height = 150;
            imgBarCode.Width = 150;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();
                    imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
                PlaceHolder1.Controls.Add(imgBarCode);
            }
        }

        protected void lkDenu_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkDenu = (LinkButton)gvReqList.Rows[index].FindControl("lkDenu");

            Requisicoes req = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(gvReqList.Rows[index].Cells[0].Text));
            id_equip.Value = req.id_equip.ToString();
            btSimDenu.CausesValidation = true;
            rfvProb.Enabled = true;
            MPE_Denu.Show();
        }

        protected void gvDenuList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Denuncias denu = DenunciasDAO.GetDenunciaByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (denu.estado == 'V')
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstadoD");
                    lbEstado.Text = "Por ver";
                    lbEstado.ForeColor = System.Drawing.Color.Red;
                }
                else if (denu.estado == 'P')
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstadoD");
                    lbEstado.Text = "Por Resolver";
                    lbEstado.ForeColor = System.Drawing.Color.Orange;
                }
                else if (denu.estado == 'R')
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstadoD");
                    lbEstado.Text = "Resolvido";
                    lbEstado.ForeColor = System.Drawing.Color.Green;
                }

                Equip equip = EquipDAO.GetEquipByID(denu.id_equip);
                Label lbEquip = (Label)e.Row.FindControl("lbEquipD");
                lbEquip.Text = equip.descri;
            }
        }

        protected void btSimDenu_Click(object sender, EventArgs e)
        {
            User user = UserDAO.GetUserByEmail(Session["email"].ToString());
            Denuncias denu = new Denuncias()
            {
                id_equip = Convert.ToInt32(id_equip.Value),
                prioridade = 'N',
                estado = 'V',
                id_user = user.id_User,
                problema = tbxProb.Text
            };
            int returncode = DenunciasDAO.InsertDenu(denu);
            MPE_Denu.Hide();
            if (returncode == -1)
            {
                // alerta
            }
            else
            {
                // alerta
            }
            btSimDenu.CausesValidation = false;
            rfvProb.Enabled = false;
            DataBindGrid();
        }

        protected void btNaoDenu_Click(object sender, EventArgs e)
        {
            btSimDenu.CausesValidation = false;
            rfvProb.Enabled = false;
            DataBindGrid();
        }

        protected void btSimQrCode_Click(object sender, EventArgs e)
        {
            // Imprimir a imagem
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton btCancelar = (LinkButton)gvReqList.Rows[index].FindControl("btCancelar");
            id_req.Value = gvReqList.Rows[index].Cells[0].Text;
            MPE_Rem.Show();
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            Models.Requisicoes requisicoes = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(id_req.Value));
            int id_requisicao = requisicoes.id_requisicao;
            User user = UserDAO.GetUserByID(requisicoes.id_user);
            Equip equip = EquipDAO.GetEquipByID(requisicoes.id_equip);

            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("likedat6969@gmail.com");
            mailMessage.To.Add(user.Email);
            mailMessage.Subject = "Cancelamento de uma requisicao.";
            mailMessage.Body = "Vimos por este meio informar que a sua reserva do seguinte equipamento : <br/>" + equip.descri + "<br/> Foi cancelada. <br/> Para mais informacoes contacte um administrador.";
            mailMessage.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.EnableSsl = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
            smtpClient.Send(mailMessage);

            RequisicoesDAO.RemoveRequisicao(id_requisicao);
            MPE_Rem.Hide();
            DataBindGrid();
        }

        protected void btNaoRe_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }
    }
}