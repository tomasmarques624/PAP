using PAP.DataAccess.CatDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.RequisicoesDA;
using PAP.DataAccess.SalasDA;
using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
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
                int returncode = RequisicoesDAO.InsertReq(req);
                MPE_NewReq.Hide();
                if (returncode == -1)
                {
                    // alerta
                }
                else
                {
                    // alerta
                }
            }
            else
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
                    // alerta
                }
                else
                {
                    // alerta
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
    }
}