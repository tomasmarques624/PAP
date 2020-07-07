using PAP.DataAccess.CatDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
            bool a = false;
            for (int i = 0; i < gvCatList.Rows.Count; i++)
            {
                if (((CheckBox)gvCatList.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    a = true;
                    Categoria cat = CatDAO.GetCatByID(Convert.ToInt32(gvCatList.DataKeys[i].Value));
                    int id_cat = cat.id_cat;
                    CatDAO.RemoveCat(id_cat);
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

            if (ReturnCode == -1)
            {
                String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);

            }
            else if (ReturnCode == 2)
            {
                String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                lbErro.Text = "Ja existe uma categoria com este nome.";
                MPE_Erro.Show();
            }
            else
            {
                String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }

            gvCatList.EditIndex = -1;
            DataBindGrid();
        }

        protected void tbxPesq_TextChanged(object sender, EventArgs e)
        {
            List<Categoria> listCats = null;

            using (SqlConnection connection = new SqlConnection())
            {
                connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "SELECT * FROM tblCat WHERE Nome LIKE '" + tbxPesq.Text + "%';";

                    connection.Open();

                    using (SqlDataReader dataReader = command.ExecuteReader())
                    {
                        if (dataReader.HasRows)
                        {
                            listCats = new List<Categoria>();
                            while (dataReader.Read())
                            {
                                listCats.Add(new Categoria()
                                {
                                    Nome = dataReader["Nome"].ToString(),
                                    id_cat = Convert.ToInt32(dataReader["id_cat"])
                                });
                            }
                        }
                    }
                }
            }
            gvCatList.DataSource = listCats;
            gvCatList.DataBind();
        }
    }
}