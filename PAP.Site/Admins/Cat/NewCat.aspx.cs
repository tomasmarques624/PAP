using PAP.DataAccess.CatDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins.Cat
{
    public partial class NewCat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btInserir_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Categoria cat = new Categoria()
                {
                    Nome = tbxNome.Text
                };

                int returncode = CatDAO.InsertCat(cat);

                if (returncode == -1)
                {
                    String str = "<script>alertify.error('Inserção feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    lbErro.Text = "Ja existe uma sala com este nome.";
                    MPE_Erro.Show();
                }
                else
                {
                    String str = "<script>alertify.success('Inserção feita com sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    tbxNome.Enabled = false;
                    btInserir.Enabled = false;
                    btCancelar.Text = "Voltar";
                }
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/Cat/EquipCat.aspx");
        }
    }
}