﻿using PAP.DataAccess.CatDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.SalasDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
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
            bool a = false, b = false;
            for (int i = 0; i < gvReqList.Rows.Count; i++)
            {
                Models.Requisicoes requisicoes = RequisicoesDAO.GetRequisicaoByID(Convert.ToInt32(gvReqList.DataKeys[i].Value));
                int id_requisicao = requisicoes.id_requisicao;
                if (((CheckBox)gvReqList.Rows[i].FindControl("chbxCancelar")).Checked)
                {
                    a = true;
                    User user = UserDAO.GetUserByID(requisicoes.id_user);
                    Equip equip = EquipDAO.GetEquipByID(requisicoes.id_equip);
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
                        mailMessage.To.Add(user.Email);
                        mailMessage.Subject = "Cancelamento de uma reserva.";
                        if (tbxRazao.Text != "")
                        {
                            mailMessage.Body = "<h3>G.E.T</h3><br/>Vimos por este meio informar que a sua reserva do seguinte equipamento : " + equip.descri + "<br/>Foi cancelada.<br/>Razão: " + tbxRazao.Text + "<br/>Para mais informações contacte um administrador.";
                        }
                        else
                        {
                            mailMessage.Body = "<h3>G.E.T</h3><br/>Vimos por este meio informar que a sua reserva do seguinte equipamento : " + equip.descri + "<br/>Foi cancelada.<br/>Para mais informações contacte um administrador.";
                        }

                        mailMessage.IsBodyHtml = true;

                        SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                        smtpClient.EnableSsl = true;
                        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                        smtpClient.UseDefaultCredentials = false;
                        smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                        smtpClient.Send(mailMessage);
                    }
                    else
                    {
                        String str = "<script>alertify.error('Sem ligação! Email não enviado.');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    }
                    RequisicoesDAO.RemoveRequisicao(id_requisicao);
                    continue;
                }
            }
            MPE_Rem.Hide();
            if (a == true)
            {
                DataBindGrid();
                String str = "<script>alertify.success('Remoção feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
            else
            {
                DataBindGrid();
                String str = "<script>alertify.error('Não há nada para remover!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
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
            bool est, b = false;
            if (estado.Value == "1")
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
                String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
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
                    mailMessage.To.Add(user.Email);
                    mailMessage.Subject = "Alteração do estado de uma reserva.";
                    mailMessage.Body = "<h3>G.E.T</h3><br/>Vimos por este meio informar que o estado da sua reserva do seguinte equipamento : " + equip.descri + "<br/>Foi alterado para " + esta + ". <br/>Para mais informações contacte um administrador.";
                    mailMessage.IsBodyHtml = true;

                    SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                    smtpClient.EnableSsl = true;
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                    smtpClient.Send(mailMessage);
                }
                else
                {
                    String str1 = "<script>alertify.error('Sem ligação! Email não enviado.');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str1, false);
                }
                DataBindGrid();
                String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
        }

        protected void btNaoRe_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }

        protected void OrdEquip_Click(object sender, EventArgs e)
        {
            List<Requisicoes> listReqs = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordequip.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY id_equip;";
                        ordequip.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY id_equip DESC;";
                        ordequip.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listReqs = new List<Requisicoes>();
                            while (dataReader.Read())
                            {
                                listReqs.Add(new Requisicoes()
                                {
                                    id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                    data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                    data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                    estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvReqList.DataSource = listReqs;
            gvReqList.DataBind();
        }

        protected void OrdUti_Click(object sender, EventArgs e)
        {
            List<Requisicoes> listReqs = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(orduti.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY id_user;";
                        orduti.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY id_user DESC;";
                        orduti.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listReqs = new List<Requisicoes>();
                            while (dataReader.Read())
                            {
                                listReqs.Add(new Requisicoes()
                                {
                                    id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                    data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                    data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                    estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvReqList.DataSource = listReqs;
            gvReqList.DataBind();
        }

        protected void tbxPesq_TextChanged(object sender, EventArgs e)
        {
            if (tbxPesq.Text != "")
            {
                List<Requisicoes> listReqs = null;

                using (SqlConnection connection = new SqlConnection())
                {
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        if (rblPesq.SelectedValue == "1")
                        {
                            command.CommandText = "SELECT * FROM tblRequisicoes WHERE data_requisicao = '" + Convert.ToDateTime(tbxPesq.Text).ToString("M/d/yyyy") + "';";
                        }
                        else if (rblPesq.SelectedValue == "2")
                        {
                            command.CommandText = "SELECT * FROM tblRequisicoes WHERE data_requisicao_final = '" + Convert.ToDateTime(tbxPesq.Text).ToString("M/d/yyyy") + "';";
                        }
                        else if (rblPesq.SelectedValue == "3")
                        {
                            command.CommandText = "SELECT tblRequisicoes.id_requisicao,tblRequisicoes.data_requisicao,tblRequisicoes.data_requisicao_final,tblRequisicoes.estado,tblRequisicoes.id_user,tblRequisicoes.id_equip FROM tblRequisicoes,tblUsers WHERE tblUsers.username LIKE '" + tbxPesq.Text + "%' AND tblRequisicoes.id_user = tblUsers.id_user;";
                        }
                        else
                        {
                            command.CommandText = "SELECT tblRequisicoes.id_requisicao,tblRequisicoes.data_requisicao,tblRequisicoes.data_requisicao_final,tblRequisicoes.estado,tblRequisicoes.id_user,tblRequisicoes.id_equip FROM tblRequisicoes,tblUsers WHERE tblEquip.descri LIKE '" + tbxPesq.Text + "%' AND tblRequisicoes.id_equip = tblEquip.id_equip;";
                        }

                        connection.Open();

                        using (SqlDataReader dataReader = command.ExecuteReader())
                        {
                            if (dataReader.HasRows)
                            {
                                listReqs = new List<Requisicoes>();
                                while (dataReader.Read())
                                {
                                    listReqs.Add(new Requisicoes()
                                    {
                                        id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                        data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                        data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                        estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                        id_user = Convert.ToInt32(dataReader["id_user"]),
                                        id_equip = Convert.ToInt32(dataReader["id_equip"])
                                    });
                                }
                            }
                        }
                    }
                }
                gvReqList.DataSource = listReqs;
                gvReqList.DataBind();
            }
            else
            {
                DataBindGrid();
            }
        }

        protected void rblPesq_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            if (rblPesq.SelectedValue == "1" || rblPesq.SelectedValue == "2")
            {
                tbxPesq.TextMode = TextBoxMode.Date;
            }
            else
            {
                tbxPesq.TextMode = TextBoxMode.SingleLine;
            }
        }

        protected void OrdEstado_Click(object sender, ImageClickEventArgs e)
        {
            List<Requisicoes> listReqs = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordest.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY estado;";
                        ordest.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblRequisicoes ORDER BY estado DESC;";
                        ordest.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listReqs = new List<Requisicoes>();
                            while (dataReader.Read())
                            {
                                listReqs.Add(new Requisicoes()
                                {
                                    id_requisicao = Convert.ToInt32(dataReader["id_requisicao"]),
                                    data_requisicao = Convert.ToDateTime(dataReader["data_requisicao"].ToString()),
                                    data_requisicao_final = Convert.ToDateTime(dataReader["data_requisicao_final"].ToString()),
                                    estado = Convert.ToBoolean(dataReader["estado"].ToString()),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvReqList.DataSource = listReqs;
            gvReqList.DataBind();
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
                mailMessage.To.Add(lbEmail.Text);
                mailMessage.Subject = tbxAssunto.Text;
                mailMessage.Body = "<h3>G.E.T</h3><br/>" + tbxMensagem.Text;
                mailMessage.IsBodyHtml = true;

                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                smtpClient.EnableSsl = true;
                smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                smtpClient.Send(mailMessage);
                String str = "<script>alertify.success('Email enviado com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                divContactar.Visible = false;
                tbxMensagem.Text = "";
                tbxAssunto.Text = "";
            }
            else
            {
                MPE_User.Hide();
                divContactar.Visible = false;
                btContactar.Enabled = false;
                tbxMensagem.Text = "";
                tbxAssunto.Text = "";
                String str1 = "<script>alertify.error('Sem ligação! Email não enviado.');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str1, false);
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            divContactar.Visible = false;
            btContactar.Visible = true;
            MPE_User.Show();
        }

        protected void btContactar_Click(object sender, EventArgs e)
        {
            divContactar.Visible = true;
            btContactar.Visible = false;
            MPE_User.Show();
        }

        protected void btFecharUser_Click(object sender, EventArgs e)
        {
            MPE_User.Hide();
        }

        protected void btUser_Click(object sender, EventArgs e)
        {
            Button bt = (Button)sender;

            GridViewRow gv = (GridViewRow)bt.NamingContainer;

            int index = gv.RowIndex;

            Button btUser = (Button)gvReqList.Rows[index].FindControl("btUser");
            String username = btUser.Text;
            User user = UserDAO.GetUserByUsername(username);
            lbUsername.Text = "<b>Username : </b>" + username + "\n";
            lbEmail.Text = "<b>Email : </b>" + user.Email + "\n";
            lbNomeUser.Text = "<b>Nome : </b>" + user.Nome + "\n";
            MPE_User.Show();
        }

        protected void btEquip_Click(object sender, EventArgs e)
        {
            Button bt = (Button)sender;

            GridViewRow gv = (GridViewRow)bt.NamingContainer;

            int index = gv.RowIndex;

            Button btEquip = (Button)gvReqList.Rows[index].FindControl("btEquip");
            String descri = btEquip.Text;
            Equip equip = EquipDAO.GetEquipByDescri(descri);
            Categoria cat = CatDAO.GetCatByID(equip.id_cat);
            Models.Salas sala = SalasDAO.GetSalaByID(equip.id_sala);
            lbDescri.Text = "<b>Descrição : </b>" + descri + "\n";
            lbCategoria.Text = "<b>Categoria : </b>" + cat.Nome + "\n";
            lbSala.Text = "<b>Sala : </b>" + sala.nome_sala + "\n";
            MPE_Equip.Show();
        }

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

    }
}