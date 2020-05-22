using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins
{
    public partial class RequisicoesGrid : System.Web.UI.Page
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
            List<Models.Requisicoes> listRequisicoes = RequisicoesDAO.GetRequisicoes();
            gvReqList.DataSource = listRequisicoes;
            gvReqList.DataBind();
        }

        protected void gvReqList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Models.Requisicoes requisicoes = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (requisicoes.estado == false)
                {
                    ((DropDownList)e.Row.FindControl("ddlEstado")).SelectedValue = "1";
                    ((DropDownList)e.Row.FindControl("ddlEstado")).ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    ((DropDownList)e.Row.FindControl("ddlEstado")).SelectedValue = "2";
                    ((DropDownList)e.Row.FindControl("ddlEstado")).ForeColor = System.Drawing.Color.Green;
                }

                Equip equip = EquipDAO.GetEquipByID(requisicoes.id_equip);
                User user = UserDAO.GetUserByID(requisicoes.id_user);
                Button btEquip = (Button)e.Row.FindControl("btEquip");
                btEquip.Text = equip.descri;
                Button btUser = (Button)e.Row.FindControl("btUser");
                btUser.Text = user.Username;
            }

        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {

            for (int i = 0; i < gvReqList.Rows.Count; i++)
            {
                Models.Requisicoes requisicoes = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(gvReqList.DataKeys[i].Value));
                int id_requisicao = requisicoes.id_requisicao;
                if (((CheckBox)gvReqList.Rows[i].FindControl("chbxCancelar")).Checked)
                {
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
                }
            }
            MPE_Rem.Hide();
            DataBindGrid();
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drp = (DropDownList)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            DropDownList ddlEstado = (DropDownList)gvReqList.Rows[index].FindControl("ddlEstado");
            id_req.Value = gvReqList.Rows[index].Cells[0].Text;
            estado.Value = ddlEstado.SelectedValue;
            MPE_Estado.Show();
        }

        protected void btNaoEstado_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }

        protected void btSimEstado_Click(object sender, EventArgs e)
        {
            bool est;
            if(estado.Value == "1")
            {
                est = false;
            }
            else
            {
                est = true;
            }
            int returncode = RequisicoesDAO.UpdateReqEstado(Convert.ToInt32(id_req.Value), est);
            MPE_Estado.Hide();
            if (returncode == -1)
            {
                // alerta
            }
            else
            {
                Requisicoes requisicao = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(id_req.Value));
                User user = UserDAO.GetUserByID(requisicao.id_user);
                Equip equip = EquipDAO.GetEquipByID(requisicao.id_equip);
                string esta;
                if (requisicao.estado == false)
                {
                    esta = "Nao Aprovada";
                }
                else
                {
                    esta = "Aprovada";
                }
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("likedat6969@gmail.com");
                mailMessage.To.Add(user.Email);
                mailMessage.Subject = "Alteracao do estado de uma requisicao.";
                mailMessage.Body = "Vimos por este meio informar que o estado da sua reserva do seguinte equipamento : <br/>" + equip.descri + "<br/> Foi aleterado para "+ esta +". <br/> Para mais informacoes contacte um administrador.";
                mailMessage.IsBodyHtml = true;

                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                smtpClient.Send(mailMessage);
                DataBindGrid();
                // alerta
            }

        }

        protected void btNaoRe_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }

        protected void OrdEquip_Click(object sender, EventArgs e)
        {

        }

        protected void OrdUti_Click(object sender, EventArgs e)
        {

        }
    }
}