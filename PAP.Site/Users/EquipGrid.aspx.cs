using PAP.DataAccess.CatDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.SalasDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Users
{
    public partial class EquipGrid : System.Web.UI.Page
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
            List<Equip> listEquips = EquipDAO.GetDispEquips();
            gvEquipList.DataSource = listEquips;
            gvEquipList.DataBind();
        }

        protected void gvEquipList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Equip Equip = EquipDAO.GetEquipByID(Convert.ToInt32(e.Row.Cells[0].Text));

                Categoria cat = CatDAO.GetCatByID(Equip.id_cat);
                Label lbCategoria = (Label)e.Row.FindControl("lbCategoria");
                lbCategoria.Text = cat.Nome;

                Salas sala = SalasDAO.GetSalaByID(Equip.id_sala);
                Label lbSala = (Label)e.Row.FindControl("lbSala");
                lbSala.Text = sala.nome_sala;
            }
        }

        protected void btSimReq_Click(object sender, EventArgs e)
        {
            String str;
            Equip equip = EquipDAO.GetEquipByID(Convert.ToInt32(id_equip.Value));
            if (ddlNDias.SelectedValue == "1")
            {
                User user = UserDAO.GetUserByEmail(Session["email"].ToString());
                Requisicoes req = new Requisicoes()
                {
                    id_equip = Convert.ToInt32(id_equip.Value),
                    data_requisicao = Convert.ToDateTime(tbxDataReserva.Text),
                    data_requisicao_final = Convert.ToDateTime(tbxDataReserva.Text),
                    estado = false,
                    id_user = user.id_User
                };
                if (equip.disp == false)
                {
                    str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                }
                else
                {
                    int returncode = RequisicoesDAO.InsertReq(req);
                    if (returncode == -1)
                    {
                        lbMensagem.Text = "Ja existe uma reserva deste equipamento para essa data.";
                        MPE_NewReq.Show();
                        str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    }
                    else
                    {
                        MPE_NewReq.Hide();
                        str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    }
                }
            }
            else
            {
                if (equip.disp == false)
                {
                    str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                }
                else
                {
                    var dataIni = Convert.ToDateTime(tbxDataReqIni.Text);
                    var dataFin = Convert.ToDateTime(tbxDataReqFin.Text);
                    if (dataIni < dataFin)
                    {
                        User user = UserDAO.GetUserByEmail(Session["email"].ToString());
                        Requisicoes req = new Requisicoes()
                        {
                            id_equip = Convert.ToInt32(id_equip.Value),
                            data_requisicao = Convert.ToDateTime(tbxDataReqIni.Text),
                            data_requisicao_final = Convert.ToDateTime(tbxDataReqFin.Text),
                            estado = false,
                            id_user = user.id_User
                        };
                        int returncode = RequisicoesDAO.InsertReq(req);
                        if (returncode == -1)
                        {
                            lbMensagem.Text = "Ja existe uma reserva deste equipamento para essas datas.";
                            MPE_NewReq.Show();
                            str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                        }
                        else
                        {
                            MPE_NewReq.Hide();
                            str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                        }
                    }
                    else
                    {
                        lbMensagem.Text = "A data final tem de ser superior à inicial.";
                        MPE_NewReq.Show();
                        str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    }
                }
            }
            btSimReq.CausesValidation = false;
            rfvData.Enabled = false;
            rfvDataIni.Enabled = false;
            rfvDataFin.Enabled = false;
        }

        protected void btNaoReq_Click(object sender, EventArgs e)
        {
            btSimReq.CausesValidation = false;
            rfvData.Enabled = false;
            rfvDataIni.Enabled = false;
            rfvDataFin.Enabled = false;
            lbMensagem.Text = "";
            DataBindGrid();
        }

        protected void ddlNDias_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlNDias.SelectedValue == "1")
            {
                lbTxtData.Visible = true;
                tbxDataReserva.Visible = true;

                lblTxtDataIni.Visible = false;
                lblTxtDataFin.Visible = false;
                tbxDataReqFin.Visible = false;
                tbxDataReqIni.Visible = false;
            }
            else
            {
                lbTxtData.Visible = false;
                tbxDataReserva.Visible = false;
                lblTxtDataIni.Visible = true;
                lblTxtDataFin.Visible = true;
                tbxDataReqFin.Visible = true;
                tbxDataReqIni.Visible = true;
            }
        }

        protected void lkReservar_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkReservar = (LinkButton)gvEquipList.Rows[index].FindControl("lkReservar");
            id_equip.Value = gvEquipList.Rows[index].Cells[0].Text;
            btSimReq.CausesValidation = true;
            rfvData.Enabled = true;
            rfvDataIni.Enabled = true;
            rfvDataFin.Enabled = true;
            MPE_NewReq.Show();
        }

        protected void buttonLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            Response.Redirect("~/Authentication/Login.aspx");
        }

        protected void rblPesq_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void tbxPesq_TextChanged(object sender, EventArgs e)
        {
            if (tbxPesq.Text != "")
            {
                List<Equip> listEquips = null;

                using (SqlConnection connection = new SqlConnection())
                {
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        if (rblPesq.SelectedValue == "1")
                        {
                            command.CommandText = "SELECT * FROM tblEquip WHERE descri LIKE '" + tbxPesq.Text + "%';";
                        }
                        else if (rblPesq.SelectedValue == "2")
                        {
                            command.CommandText = "SELECT tblEquip.id_equip,tblEquip.descri,tblEquip.disp,tblEquip.id_cat,tblEquip.id_sala FROM tblEquip,tblCat WHERE tblCat.Nome LIKE " + tbxPesq.Text + "%' AND tblEquip.id_cat = tblCat.id_cat;";
                        }
                        else
                        {
                            command.CommandText = "SELECT tblEquip.id_equip,tblEquip.descri,tblEquip.disp,tblEquip.id_cat,tblEquip.id_sala FROM tblEquip,tblSalas WHERE tblSalas.nome_sala LIKE " + tbxPesq.Text + "%' AND tblEquip.id_sala = tblCat.id_sala;";
                        }

                        connection.Open();

                        using (SqlDataReader dataReader = command.ExecuteReader())
                        {
                            if (dataReader.HasRows)
                            {
                                listEquips = new List<Equip>();
                                while (dataReader.Read())
                                {
                                    listEquips.Add(new Equip()
                                    {
                                        descri = dataReader["descri"].ToString(),
                                        disp = Convert.ToBoolean(dataReader["disp"]),
                                        id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                        id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                        id_equip = Convert.ToInt32(dataReader["id_equip"])
                                    });
                                }
                            }
                        }
                    }
                }
                gvEquipList.DataSource = listEquips;
                gvEquipList.DataBind();
            }
        }

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            List<Equip> listEquips = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordcat.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY id_cat;";
                        ordcat.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY id_cat DESC;";
                        ordcat.Value = "1";
                    }

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listEquips = new List<Equip>();
                            while (dataReader.Read())
                            {
                                listEquips.Add(new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"]),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                    id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvEquipList.DataSource = listEquips;
            gvEquipList.DataBind();
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            List<Equip> listEquips = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(ordsala.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY id_sala;";
                        ordsala.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY id_sala DESC;";
                        ordsala.Value = "1";
                    }
                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listEquips = new List<Equip>();
                            while (dataReader.Read())
                            {
                                listEquips.Add(new Equip()
                                {
                                    descri = dataReader["descri"].ToString(),
                                    disp = Convert.ToBoolean(dataReader["disp"]),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"]),
                                    id_sala = Convert.ToInt32(dataReader["id_sala"]),
                                    id_equip = Convert.ToInt32(dataReader["id_equip"])
                                });
                            }
                        }
                    }
                }
            }
            gvEquipList.DataSource = listEquips;
            gvEquipList.DataBind();
        }

        protected void lkFoto_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkFoto = (LinkButton)gvEquipList.Rows[index].FindControl("lkFoto");
            int id_equip = Convert.ToInt32(gvEquipList.Rows[index].Cells[0].Text);
            MPE_Foto.Show();
            Equip equip = EquipDAO.GetEquipByID(id_equip);
            string jpg = "/Content/Imagens/Equips/" + equip.descri + ".jpg";
            if (File.Exists(Server.MapPath(jpg)))
            {
                imgFoto.ImageUrl = jpg;
            }
            else
            {
                imgFoto.ImageUrl = "../../Content/Imagens/ImgNotFound.png";
            }
        }
    }
}