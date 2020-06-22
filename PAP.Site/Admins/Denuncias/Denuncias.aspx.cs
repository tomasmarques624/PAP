using PAP.DataAccess.DenunciasDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using QRCoder;
using System.IO;
using System.Drawing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Printing;
using System.Data.SqlClient;
using System.Configuration;
using PAP.DataAccess.CatDA;
using PAP.DataAccess.SalasDA;

namespace PAP.Site.Admins
{
    public partial class Denuncias : System.Web.UI.Page
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
            List<Models.Denuncias> listDenuncias = DenunciasDAO.GetDenuncias();
            gvDenuList.DataSource = listDenuncias;
            gvDenuList.DataBind();
        }

        protected void gvDenuList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (denuncia.prioridade == 'A')
                {
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).SelectedValue = "1";
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).ForeColor = System.Drawing.Color.Red;
                }
                else if (denuncia.prioridade == 'M')
                {
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).SelectedValue = "2";
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).ForeColor = System.Drawing.Color.Orange;
                }else if (denuncia.prioridade == 'B')
                {
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).SelectedValue = "3";
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    ((DropDownList)e.Row.FindControl("ddlPrioridade")).SelectedValue = "4";
                }

                if (denuncia.estado == 'V')
                {
                    ((DropDownList)e.Row.FindControl("ddlEstado")).SelectedValue = "1";
                    ((DropDownList)e.Row.FindControl("ddlEstado")).ForeColor = System.Drawing.Color.Red;
                }
                else if (denuncia.estado == 'P')
                {
                    ((DropDownList)e.Row.FindControl("ddlEstado")).SelectedValue = "2";
                    ((DropDownList)e.Row.FindControl("ddlEstado")).ForeColor = System.Drawing.Color.Orange;
                }
                else if (denuncia.estado == 'R')
                {
                    ((DropDownList)e.Row.FindControl("ddlEstado")).SelectedValue = "3";
                    ((DropDownList)e.Row.FindControl("ddlEstado")).ForeColor = System.Drawing.Color.Green;
                }

                Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
                User user = UserDAO.GetUserByID(denuncia.id_user);
                Button btEquip = (Button)e.Row.FindControl("btEquip");
                btEquip.Text = equip.descri;
                Button btUser = (Button)e.Row.FindControl("btUser");
                btUser.Text = user.Username;
            }
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < gvDenuList.Rows.Count; i++)
            {
                CheckBox drp = (CheckBox)sender;

                GridViewRow gv = (GridViewRow)drp.NamingContainer;

                int index = gv.RowIndex;

                CheckBox chbxEliminar = (CheckBox)gvDenuList.Rows[index].FindControl("chbxEliminar");

                if (chbxEliminar.Checked)
                {
                    Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(Convert.ToInt32(gvDenuList.DataKeys[i].Value));
                    int id_denuncia = denuncia.id_denuncia;

                    User user = UserDAO.GetUserByID(denuncia.id_user);
                    Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);

                    MailMessage mailMessage = new MailMessage();
                    mailMessage.From = new MailAddress("likedat6969@gmail.com");
                    mailMessage.To.Add(user.Email);
                    mailMessage.Subject = "Cancelamento de uma denuncia.";
                    mailMessage.Body = "Vimos por este meio informar que a sua denuncia do seguinte equipamento : <br/>" + equip.descri + "<br/> Foi removida. <br/> Para mais informacoes contacte um administrador.";
                    mailMessage.IsBodyHtml = true;

                    SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                    smtpClient.EnableSsl = true;
                    smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
                    smtpClient.Send(mailMessage);

                    DenunciasDAO.RemoveDenuncia(id_denuncia);
                }
            }
            MPE_Rem.Hide();
            DataBindGrid();
        }

        protected void ddlPrioridade_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drp = (DropDownList)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            DropDownList ddlPrioridade = (DropDownList)gvDenuList.Rows[index].FindControl("ddlPrioridade");
            id_denu.Value = gvDenuList.Rows[index].Cells[0].Text;
            prio.Value = ddlPrioridade.SelectedValue;
            MPE_Prio.Show();
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drp = (DropDownList)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            DropDownList ddlEstado = (DropDownList)gvDenuList.Rows[index].FindControl("ddlEstado");
            id_denu.Value = gvDenuList.Rows[index].Cells[0].Text;
            estado.Value = ddlEstado.SelectedValue;
            MPE_Estado.Show();
        }

        protected void btSimEstado_Click(object sender, EventArgs e)
        {
            char est;
            Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(Convert.ToInt32(id_denu.Value));
            if (estado.Value == "1")
            {
                est = 'V';
            }
            else if (estado.Value == "2")
            {
                est = 'P';
                int a = EquipDAO.UpdateEquipDisp(Convert.ToInt32(denuncia.id_equip), Convert.ToBoolean(0));
            }
            else
            {
                est = 'R';
            }
            int returncode = DenunciasDAO.UpdateDenuEstado(Convert.ToInt32(id_denu.Value), est);
            MPE_Estado.Hide();
            if (returncode == -1)
            {
                // alerta
            }
            else
            {
                User user = UserDAO.GetUserByID(denuncia.id_user);
                Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
                string esta;
                if (denuncia.estado == 'V')
                {
                    esta = "Por ver";
                }else if(denuncia.estado == 'P')
                {
                    esta = "Por resolver";
                }
                else
                {
                    esta = "Resolvida";
                }

                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("likedat6969@gmail.com");
                mailMessage.To.Add(user.Email);
                mailMessage.Subject = "Alteracao do estado de uma denuncia.";
                mailMessage.Body = "Vimos por este meio informar que o estado da sua denuncia do seguinte equipamento : <br/>" + equip.descri + "<br/> Foi alterado para " + esta + ". <br/> Para mais informacoes contacte um administrador.";
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

        protected void btNaoEstado_Click(object sender, EventArgs e)
        {
            MPE_Estado.Hide();
            DataBindGrid();
        }

        protected void btSimPrio_Click(object sender, EventArgs e)
        {
            char pri;
            if (prio.Value == "1")
            {
                pri = 'A';
            }
            else if (prio.Value == "2")
            {
                pri = 'M';
            }
            else if(prio.Value == "3")
            {
                pri = 'B';
            }
            else
            {
                pri = 'N';
            }
            int returncode = DenunciasDAO.UpdateDenuPrio(Convert.ToInt32(id_denu.Value), pri);
            MPE_Estado.Hide();
            if (returncode == -1)
            {
                // alerta
            }
            else
            {
                // alerta
            }
            DataBindGrid();
        }

        protected void btNaoPrio_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }
        protected void btNaoRe_Click(object sender, EventArgs e)
        {
            DataBindGrid();
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
            Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
            string code = "Equipamento : "+ equip.descri+"\nProblema :"+denuncia.problema;
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
                    bitMap.Save("C:\\Users\\Utilizador\\source\\repos\\PAP\\PAP.Site\\Content\\Imagens\\qrcode.png", System.Drawing.Imaging.ImageFormat.Png);
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();
                    imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
                
                PlaceHolder1.Controls.Add(imgBarCode);
            }
        }

        protected void btSimQrCode_Click(object sender, EventArgs e)
        {
            PrintDocument pd = new PrintDocument();
            pd.PrintPage += PrintPage;
            pd.Print();
        }
        private void PrintPage(object o, PrintPageEventArgs e)
        {
            System.Drawing.Image img = System.Drawing.Image.FromFile("C:\\Users\\Utilizador\\source\\repos\\PAP\\PAP.Site\\Content\\Imagens\\qrcode.png");
            Point loc = new Point(100, 100);
            e.Graphics.DrawImage(img, loc);
            img.Dispose();
        }

        protected void btRemover_Click(object sender, EventArgs e)
        {
            MPE_Rem.Show();
        }

        protected void tbxPesq_TextChanged(object sender, EventArgs e)
        {
            if (tbxPesq.Text != "")
            {
                List<Models.Denuncias> listDenus = null;

                using (SqlConnection connection = new SqlConnection())
                {
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        if (rblPesq.SelectedValue == "1")
                        {
                            command.CommandText = "SELECT * FROM tblDenuncias WHERE problema LIKE '" + tbxPesq.Text + "%';";
                        }
                        else if (rblPesq.SelectedValue == "2")
                        {
                            command.CommandText = "SELECT * FROM tblDenuncias WHERE data_denuncia = '" + Convert.ToDateTime(tbxPesq.Text).ToString("MM/dd/yyyy") + "';";
                        }
                        else if (rblPesq.SelectedValue == "3")
                        {
                            command.CommandText = "SELECT tblDenuncias.id_denuncia,tblDenuncias.problema,tblDenuncias.data_denuncia,tblDenuncias.estado,tblDenuncias.prioridade,tblDenuncias.id_user,tblDenuncias.id_equip FROM tblDenuncias,tblUsers WHERE tblUsers.username LIKE '" + tbxPesq.Text + "%' AND tblDenuncias.id_user = tblUsers.id_user;";
                        }
                        else
                        {
                            command.CommandText = "SELECT tblDenuncias.id_denuncia,tblDenuncias.problema,tblDenuncias.data_denuncia,tblDenuncias.estado,tblDenuncias.prioridade,tblDenuncias.id_user,tblDenuncias.id_equip FROM tblDenuncias,tblEquip WHERE tblEquip.descri LIKE '" + tbxPesq.Text + "%' AND tblDenuncias.id_equip = tblEquip.id_equip;";
                        }

                        connection.Open();

                        using (SqlDataReader dataReader = command.ExecuteReader())
                        {
                            if (dataReader.HasRows)
                            {
                                listDenus = new List<Models.Denuncias>();
                                while (dataReader.Read())
                                {
                                    listDenus.Add(new Models.Denuncias()
                                    {
                                        problema = dataReader["problema"].ToString(),
                                        estado = Convert.ToChar(dataReader["estado"].ToString()),
                                        prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                        id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                        id_user = Convert.ToInt32(dataReader["id_user"]),
                                        data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                        id_equip = Convert.ToInt32(dataReader["id_equip"])
                                    });
                                }
                            }
                        }
                    }
                }
                gvDenuList.DataSource = listDenus;
                gvDenuList.DataBind();
            }
            else
            {
                DataBindGrid();
            }
        }

        protected void OrdPrio_Click(object sender, EventArgs e)
        {
            List<Models.Denuncias> listDenus= null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordprio.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY prioridade;";
                        ordprio.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY prioridade DESC;";
                        ordprio.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listDenus = new List<Models.Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenus.Add(new Models.Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvDenuList.DataSource = listDenus;
            gvDenuList.DataBind();
        }

        protected void OrdEstado_Click(object sender, EventArgs e)
        {
            List<Models.Denuncias> listDenus = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordestado.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY estado;";
                        ordestado.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY estado DESC;";
                        ordestado.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listDenus = new List<Models.Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenus.Add(new Models.Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvDenuList.DataSource = listDenus;
            gvDenuList.DataBind();
        }

        protected void OrdUti_Click(object sender, EventArgs e)
        {
            List<Models.Denuncias> listDenus = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(orduti.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY id_user;";
                        orduti.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY id_user DESC;";
                        orduti.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listDenus = new List<Models.Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenus.Add(new Models.Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvDenuList.DataSource = listDenus;
            gvDenuList.DataBind();
        }

        protected void OrdEquip_Click(object sender, EventArgs e)
        {
            List<Models.Denuncias> listDenus = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordquip.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY id_equip;";
                        ordquip.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblDenuncias ORDER BY id_equip DESC;";
                        ordquip.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listDenus = new List<Models.Denuncias>();
                            while (dataReader.Read())
                            {
                                listDenus.Add(new Models.Denuncias()
                                {
                                    problema = dataReader["problema"].ToString(),
                                    estado = Convert.ToChar(dataReader["estado"].ToString()),
                                    prioridade = Convert.ToChar(dataReader["prioridade"].ToString()),
                                    id_denuncia = Convert.ToInt32(dataReader["id_denuncia"]),
                                    id_user = Convert.ToInt32(dataReader["id_user"]),
                                    data_denuncia = Convert.ToDateTime(dataReader["data_denuncia"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvDenuList.DataSource = listDenus;
            gvDenuList.DataBind();
        }

        protected void rblPesq_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            if (rblPesq.SelectedValue == "2")
            {
                tbxPesq.TextMode = TextBoxMode.Date;
            }
            else
            {
                tbxPesq.TextMode = TextBoxMode.SingleLine;
            }
        }

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void btContactar_Click(object sender, EventArgs e)
        {
            divContactar.Visible = true;
            MPE_User.Show();
        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("likedat6969@gmail.com");
            mailMessage.To.Add(lbEmail.Text);
            mailMessage.Subject = tbxAssunto.Text;
            mailMessage.Body = tbxMensagem.Text;
            mailMessage.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.EnableSsl = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
            smtpClient.Send(mailMessage);

            divContactar.Visible = false;
            tbxMensagem.Text = "";
            tbxAssunto.Text = "";
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            divContactar.Visible = false;
            MPE_User.Show();
        }

        protected void btUser_Click(object sender, EventArgs e)
        {
            Button bt = (Button)sender;

            GridViewRow gv = (GridViewRow)bt.NamingContainer;

            int index = gv.RowIndex;

            Button btUser = (Button)gvDenuList.Rows[index].FindControl("btUser");
            String username = btUser.Text;
            User user = UserDAO.GetUserByUsername(username);
            lbNomeUser.Text = "<b>Nome : </b>" + username + "\n";
            lbEmail.Text = "<b>Email : </b>" + user.Email + "\n";
            MPE_User.Show();
        }

        protected void btFecharUser_Click(object sender, EventArgs e)
        {
            MPE_User.Hide();
        }

        protected void btEquip_Click(object sender, EventArgs e)
        {
            Button bt = (Button)sender;

            GridViewRow gv = (GridViewRow)bt.NamingContainer;

            int index = gv.RowIndex;

            Button btEquip = (Button)gvDenuList.Rows[index].FindControl("btEquip");
            String descri = btEquip.Text;
            Equip equip = EquipDAO.GetEquipByDescri(descri);
            Categoria cat = CatDAO.GetCatByID(equip.id_cat);
            Models.Salas sala = SalasDAO.GetSalaByID(equip.id_sala);
            lbDescri.Text = "<b>Descricao : </b>" + descri + "\n";
            lbCategoria.Text = "<b>Categoria : </b>" + cat.Nome + "\n";
            lbSala.Text = "<b>Sala : </b>" + sala.nome_sala + "\n";
            MPE_Equip.Show();
        }

        protected void lkFoto_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkFoto = (LinkButton)gvDenuList.Rows[index].FindControl("lkFoto");
            int id_denuncia = Convert.ToInt32(gvDenuList.Rows[index].Cells[0].Text);
            MPE_QrCode.Show();
            Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(id_denuncia);
            Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
            string v = "~/Content/Imagens/Denuncias/" + equip.descri + "_" + denuncia.data_denuncia.ToString("MM/dd/yyyy");
            imgFoto.ImageUrl = v;
        }
    }
}