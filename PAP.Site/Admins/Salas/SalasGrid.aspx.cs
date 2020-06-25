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
            MPE_Rem.Show();
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
                String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                lbErro.Text = "Ja existe uma sala com este nome.";
                MPE_Erro.Show();
                gvSalaList.EditIndex = -1;
                DataBindGrid();
            }
            else
            {
                String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                gvSalaList.EditIndex = -1;
                DataBindGrid();
            }
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            bool a = false;
            for (int i = 0; i < gvSalaList.Rows.Count; i++)
            {
                if (((CheckBox)gvSalaList.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    a = true;
                    Models.Salas salas = SalasDAO.GetSalaByID(Convert.ToInt32(gvSalaList.DataKeys[i].Value));
                    int id_sala = salas.id_sala;
                    SalasDAO.RemoveSala(id_sala);
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
    }
}