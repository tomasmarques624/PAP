using PAP.DataAccess.CatDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins
{
    public partial class EquipCat : System.Web.UI.Page
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
            List<Categoria> listRequisicoes = CatDAO.GetCats();
            gvCatList.DataSource = listRequisicoes;
            gvCatList.DataBind();
        }

        protected void btRemover_Click(object sender, EventArgs e)
        {
            MPE_Rem.Show();
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < gvCatList.Rows.Count; i++)
            {
                Categoria cat = CatDAO.GetCatByID(Convert.ToInt32(gvCatList.DataKeys[i].Value));
                int id_cat = cat.id_cat;
                if (((CheckBox)gvCatList.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    CatDAO.RemoveCat(id_cat);
                    continue;
                }
            }
            MPE_Rem.Hide();
            DataBindGrid();
        }

        protected void btNovaCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("../Cat/NewCat.aspx");
        }

        protected void gvCatList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCatList.EditIndex = -1;
            DataBindGrid();
        }

        protected void gvCatList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCatList.EditIndex = e.NewEditIndex;
            DataBindGrid();
        }

        protected void gvCatList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id_cat = Convert.ToInt32(gvCatList.Rows[e.RowIndex].Cells[0].Text);
            Categoria cat = new Categoria
            {
                id_cat = id_cat,
                Nome = e.NewValues["Nome"].ToString()
            };
            int ReturnCode = CatDAO.UpdateCat(cat);

            if (ReturnCode == -1) { // alerta
            }else{   // alerta 
            }

            gvCatList.EditIndex = -1;
            DataBindGrid();
        }
    }
}