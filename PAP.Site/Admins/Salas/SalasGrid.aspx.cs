using PAP.DataAccess.SalasDA;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins
{
    public partial class SalasGrid : System.Web.UI.Page
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
            List<Models.Salas> listRequisicoes = SalasDAO.GetSalas();
            gvSalaList.DataSource = listRequisicoes;
            gvSalaList.DataBind();
        }

        protected void btRemover_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < gvSalaList.Rows.Count; i++)
            {
                Models.Salas salas = SalasDAO.GetSalaByID(Convert.ToInt32(gvSalaList.DataKeys[i].Value));
                int id_sala = salas.id_sala;
                if (((CheckBox)gvSalaList.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    SalasDAO.RemoveSala(id_sala);
                }
            }
        }

        protected void btNovaSala_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Salas/NewSala.aspx");
        }

        protected void gvSalaList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSalaList.EditIndex = -1;
            DataBindGrid();
        }

        protected void gvSalaList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSalaList.EditIndex = e.NewEditIndex;
            DataBindGrid();
        }

        protected void gvSalaList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id_sala = Convert.ToInt32(gvSalaList.Rows[e.RowIndex].Cells[0].Text);
            Models.Salas sala = new Models.Salas
            {
                id_sala = id_sala,
                nome_sala = e.NewValues["nome_sala"].ToString()
            };
            int ReturnCode = SalasDAO.UpdateSala(sala);
            if (ReturnCode == -1)
            {
                // alerta
                gvSalaList.EditIndex = -1;
                DataBindGrid();
            }
            else
            {
                // alerta
                gvSalaList.EditIndex = -1;
                DataBindGrid();
            }
        }
    }
}