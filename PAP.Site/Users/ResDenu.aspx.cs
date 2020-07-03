using PAP.DataAccess.DenunciasDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Printing;
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
                DataBindGridDenu();
            }
        }
        public void DataBindGrid()
        {
            User user = UserDAO.GetUserByEmail(Session["email"].ToString());
            List<Requisicoes> listRequisicoes = RequisicoesDAO.GetUserReq(user.id_User);
            gvReqList.DataSource = listRequisicoes;
            gvReqList.DataBind();
        }

        public void DataBindGridDenu()
        {
            User user = UserDAO.GetUserByEmail(Session["email"].ToString());

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
                    LinkButton lkDenu = (LinkButton)e.Row.FindControl("lkDenu");
                    lkDenu.Text = "Não disponível";
                    lkDenu.Enabled = false;
                }
                else
                {
                    Label lbEstado = (Label)e.Row.FindControl("lbEstado");
                    lbEstado.Text = "Aprovada";
                    lbEstado.ForeColor = System.Drawing.Color.Green;
                    LinkButton lkDenu = (LinkButton)e.Row.FindControl("lkDenu");
                    lkDenu.Text = "Denunciar";
                    lkDenu.Enabled = true;
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
            Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
            string code = "Equipamento : " + equip.descri + "\nProblema :" + denuncia.problema;
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

            Models.Denuncias denu = new Models.Denuncias()
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
                String str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                lbErro.Text = "Ja existe uma denuncia com este problema neste equipamento que ainda não se encontra resolvida.";
                MPE_Erro.Show();
            }
            else
            {
                if (fluFoto.HasFile == true)
                {
                    Equip equip = EquipDAO.GetEquipByID(denu.id_equip);
                    String path = equip.descri + "_" + DateTime.Now.ToString("MM-dd-yyyy") + ".jpg";
                    fluFoto.PostedFile.SaveAs(Server.MapPath("~/Content/Imagens/Denuncias/") + path);
                }
                else
                {
                    imgFoto.ImageUrl = "../../Content/Imagens/ImgNotFound.png";
                }

                String str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }

            btSimDenu.CausesValidation = false;
            rfvProb.Enabled = false;
            DataBindGridDenu();
        }

        protected void btNaoDenu_Click(object sender, EventArgs e)
        {
            btSimDenu.CausesValidation = false;
            rfvProb.Enabled = false;
            DataBindGridDenu();
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
            mailMessage.Body = "<h3>G.E.T</h3><br/>Vimos por este meio informar que a sua reserva do seguinte equipamento : <br/>" + equip.descri + "<br/> Foi cancelada. <br/> Para mais informacoes contacte um administrador.";
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
                            command.CommandText = "SELECT * FROM tblRequisicoes WHERE data_requisicao LIKE '" + Convert.ToDateTime(tbxPesq.Text).ToString("MM/dd/yyyy") + "%';";
                        }
                        else if (rblPesq.SelectedValue == "2")
                        {
                            command.CommandText = "SELECT * FROM tblRequisicoes WHERE data_requisicao_final = '" + Convert.ToDateTime(tbxPesq.Text).ToString("MM/dd/yyyy") + "';";
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

        protected void OrdEstadoDenu_Click(object sender, ImageClickEventArgs e)
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

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void btLimparFiltrosDenu_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGridDenu();
        }

        protected void tbxPesqDenu_TextChanged(object sender, EventArgs e)
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
                DataBindGridDenu();
            }
        }

        protected void lkFoto_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkFoto = (LinkButton)gvDenuList.Rows[index].FindControl("lkFoto");
            int id_denuncia = Convert.ToInt32(gvDenuList.Rows[index].Cells[0].Text);
            Models.Denuncias denuncia = DenunciasDAO.GetDenunciaByID(id_denuncia);
            Equip equip = EquipDAO.GetEquipByID(denuncia.id_equip);
            string jpg = "/Content/Imagens/Denuncias/" + equip.descri + "_" + denuncia.data_denuncia.ToString("MM-dd-yyyy") + ".jpg";
            if (File.Exists(Server.MapPath(jpg)))
            {
                imgFoto.ImageUrl = jpg;
            }
            else
            {
                imgFoto.ImageUrl = "../../Content/Imagens/ImgNotFound.png";
            }
            MPE_Foto.Show();
        }
    }
}