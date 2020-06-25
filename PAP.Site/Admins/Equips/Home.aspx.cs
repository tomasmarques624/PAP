﻿using PAP.DataAccess.CatDA;
using PAP.DataAccess.DenunciasDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.SalasDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins
{
    public partial class Home : System.Web.UI.Page
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
            List<Equip> listEquips = EquipDAO.GetEquips();
            gvEquipList.DataSource = listEquips;
            gvEquipList.DataBind();
        }

        protected void gvEquipList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Equip Equip = EquipDAO.GetEquipByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (Equip.disp == false)
                {
                    ((CheckBox)e.Row.FindControl("chbxDisponivel")).Checked = false;
                }
                else
                {
                    ((CheckBox)e.Row.FindControl("chbxDisponivel")).Checked = true;
                }

                DropDownList ddlCat = (DropDownList)e.Row.FindControl("ddlCat");
                ddlCat.DataSource = CatDAO.GetCats();
                ddlCat.DataValueField = "id_cat";
                ddlCat.DataTextField = "Nome";
                ddlCat.DataBind();
                ddlCat.SelectedValue = Equip.id_cat.ToString();

                DropDownList ddlSala = (DropDownList)e.Row.FindControl("ddlSala");
                ddlSala.DataSource = SalasDAO.GetSalas();
                ddlSala.DataValueField = "id_sala";
                ddlSala.DataTextField = "nome_sala";
                ddlSala.DataBind();
                ddlSala.SelectedValue = Equip.id_sala.ToString();
            }
        }
        protected void btNovoEquip_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Equips/NewEquip.aspx");
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
        protected void lkDenuncias_Click(object sender, EventArgs e)
        {
            LinkButton drp = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            LinkButton lkDenuncias = (LinkButton)gvEquipList.Rows[index].FindControl("lkDenuncias");
            id_equip.Value = gvEquipList.Rows[index].Cells[0].Text;
            btSimDenu.CausesValidation = true;
            rfvProb.Enabled = true;
            MPE_Denu.Show();
        }

        protected void ddlCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drp = (DropDownList)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            DropDownList ddlCat = (DropDownList)gvEquipList.Rows[index].FindControl("ddlCat");
            id_equip.Value = gvEquipList.Rows[index].Cells[0].Text;
            id_cat.Value = ddlCat.SelectedValue;
            MPE_CAT.Show();
        }

        protected void ddlSala_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drp = (DropDownList)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            DropDownList ddlSala = (DropDownList)gvEquipList.Rows[index].FindControl("ddlSala");
            id_equip.Value = gvEquipList.Rows[index].Cells[0].Text;
            id_sala.Value = ddlSala.SelectedValue;
            MPE_Sala.Show();
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            bool a = false,b = false;
            for (int i = 0; i < gvEquipList.Rows.Count; i++)
            {
                Equip equip = EquipDAO.GetEquipByID(Convert.ToInt32(gvEquipList.DataKeys[i].Value));
                int id_equip = equip.id_equip;
                if (((CheckBox)gvEquipList.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    a = true;
                    int returncode = EquipDAO.RemoveEquip(id_equip);
                    if (returncode == 2)
                    {
                        lbErro.Text = "Não foi possivel remover este equipamento :"+equip.descri+"\nDevido a haver reserva(s) deste equipamento.";
                        MPE_Erro.Show();
                        b = true;
                    }
                    else if (returncode == 3)
                    {
                        lbErro.Text = "Não foi possivel remover este equipamento :" + equip.descri + "\nDevido a haver denuncia(s) deste equipamento.";
                        MPE_Erro.Show();
                        b = true;
                    }
                    
                    continue;
                }
            }
            MPE_Rem.Hide();
            if (a == true)
            {
                if(b == true)
                {
                    DataBindGrid();
                    String str = "<script>alertify.success('Remoção feita com sucesso em alguns casos!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                }
                else
                {
                    DataBindGrid();
                    String str = "<script>alertify.success('Remoção feita com sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                }            }
            else
            {
                DataBindGrid();
                String str = "<script>alertify.error('Não há nada para remover!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
        }

        protected void btSimCat_Click(object sender, EventArgs e)
        {

            int returncode = EquipDAO.UpdateEquipCat(Convert.ToInt32(id_equip.Value), Convert.ToInt32(id_cat.Value));
            MPE_CAT.Hide();
            String str;
            if (returncode == -1)
            {
                str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
            }
            else
            {
                str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
        }

        protected void btSimSala_Click(object sender, EventArgs e)
        {

            int returncode = EquipDAO.UpdateEquipSala(Convert.ToInt32(id_equip.Value), Convert.ToInt32(id_sala.Value));
            MPE_Sala.Hide();
            String str;

            if (returncode == -1)
            {
                str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
            }
            else
            {
                str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
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
                    str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                }
                else
                {
                    int returncode = RequisicoesDAO.InsertReq(req);
                    MPE_NewReq.Hide();
                    if (returncode == -1)
                    {
                        lbMensagem.Text = "Ja existem uma reserva deste equipamento para essa data.";
                    }
                    else
                    {
                        str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    }
                }
            }
            else
            {
                if (equip.disp == false)
                {
                    str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
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
                        MPE_NewReq.Hide();
                        if (returncode == -1)
                        {
                            lbMensagem.Text = "Ja existe uma reserva deste equipamento para essas datas.";
                        }
                        else
                        {
                            str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                        }
                    }
                    else
                    {
                        lbMensagem.Text = "A data final tem de ser superior à inicial.";
                    }
                }
            }
            btSimReq.CausesValidation = false;
            rfvData.Enabled = false;
            rfvDataIni.Enabled = false;
            rfvDataFin.Enabled = false;
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
            MPE_NewReq.Show();
        }

        protected void btNaoRe_Click(object sender, EventArgs e)
        {
            DataBindGrid();
        }

        protected void btNaoCat_Click(object sender, EventArgs e)
        {
            MPE_CAT.Hide();
            DataBindGrid();
        }

        protected void btNaoSala_Click(object sender, EventArgs e)
        {
            MPE_Sala.Hide();
            DataBindGrid();
        }

        protected void btNaoReq_Click(object sender, EventArgs e)
        {
            btSimReq.CausesValidation = false;
            rfvData.Enabled = false;
            rfvDataIni.Enabled = false;
            rfvDataFin.Enabled = false;
            DataBindGrid();
        }

        protected void gvEquipList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEquipList.EditIndex = -1;
            DataBindGrid();
        }

        protected void gvEquipList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEquipList.EditIndex = e.NewEditIndex;
            DataBindGrid();
        }

        protected void gvEquipList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id_equip = Convert.ToInt32(gvEquipList.Rows[e.RowIndex].Cells[0].Text);
            Equip equip = new Equip
            {
                id_equip = id_equip,
                descri = e.NewValues["descri"].ToString()
            };
            int ReturnCode = EquipDAO.UpdateEquip(equip);
            if (ReturnCode == -1)
            {
                String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                lbErro.Text = "Ja existe um equipamento com esta descrição.";
                MPE_Erro.Show();
                gvEquipList.EditIndex = -1;
                DataBindGrid();
            }
            else
            {
                String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                gvEquipList.EditIndex = -1;
                DataBindGrid();
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
                if(fluFoto.HasFile == true)
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
        }

        protected void btNaoDenu_Click(object sender, EventArgs e)
        {
            btSimDenu.CausesValidation = false;
            rfvProb.Enabled = false;
            DataBindGrid();
        }

        protected void chbxDisponivel_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox drp = (CheckBox)sender;

            GridViewRow gv = (GridViewRow)drp.NamingContainer;

            int index = gv.RowIndex;

            CheckBox chbxDisponivel = (CheckBox)gvEquipList.Rows[index].FindControl("chbxDisponivel");
            id_equip.Value = gvEquipList.Rows[index].Cells[0].Text;
            if (chbxDisponivel.Checked == true)
            {
                disp.Value = "1";
            }
            else
            {
                disp.Value = "0";
            }
            MPE_Disp.Show();
        }

        protected void btSimDisp_Click(object sender, EventArgs e)
        {
            int returncode = EquipDAO.UpdateEquipDisp(Convert.ToInt32(id_equip.Value), Convert.ToBoolean(Convert.ToInt32(disp.Value)));
            MPE_Disp.Hide();
            String str;

            if (returncode == -1)
            {
                str = "<script>alertify.error('Alteração feita sem sucesso!!');</script>";
            }
            else
            {
                str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
        }

        protected void btRemover_Click(object sender, EventArgs e)
        {
            MPE_Rem.Show();
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

        protected void OrdCat_Click(object sender, EventArgs e)
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

        protected void OrdSala_Click(object sender, EventArgs e)
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

        protected void OrdDisp_Click(object sender, EventArgs e)
        {
            List<Equip> listEquips = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    if (Convert.ToInt32(orddisp.Value) == 1)
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY disp DESC;";
                        orddisp.Value = "2";
                    }
                    else
                    {
                        command.CommandText = "SELECT * FROM tblEquip ORDER BY disp;";
                        orddisp.Value = "1";
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

        protected void rblPesq_SelectedIndexChanged(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            DataBindGrid();
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

        protected void btNaoDisp_Click(object sender, EventArgs e)
        {
            MPE_Disp.Hide();
            DataBindGrid();
        }
    }
}