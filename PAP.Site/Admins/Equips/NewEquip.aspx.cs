using PAP.DataAccess.CatDA;
using PAP.DataAccess.EquipDA;
using PAP.DataAccess.SalasDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins.Equips
{
    public partial class NewEquip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlCat.DataSource = CatDAO.GetCats();
                ddlCat.DataValueField = "id_cat";
                ddlCat.DataTextField = "Nome";
                ddlCat.DataBind();

                ddlSala.DataSource = SalasDAO.GetSalas();
                ddlSala.DataValueField = "id_sala";
                ddlSala.DataTextField = "nome_sala";
                ddlSala.DataBind();
            }
        }

        protected void btInserir_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Equip equip = new Equip()
                {
                    descri = tbxDesc.Text,
                    id_cat = Convert.ToInt32(ddlCat.SelectedValue),
                    id_sala = Convert.ToInt32(ddlSala.SelectedValue)
                };

                if (equip.id_sala == 0)
                {
                    equip.disp = true;
                }
                else
                {
                    equip.disp = false;
                }

                int returncode = EquipDAO.InsertEquip(equip);

                if (returncode == -1)
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Red;
                    lbMensagem.Text = "Adição falhada!<br />Tente novamente mais tarde...";
                }
                else
                {
                    fluFoto.PostedFile.SaveAs(Server.MapPath("~/Content/Imagens/Equips/") + equip.descri);

                    lbMensagem.ForeColor = System.Drawing.Color.Green;
                    lbMensagem.Text = "Adição Efetuada com sucesso!";
                    btCancelar.Text = "Voltar";

                    tbxDesc.Enabled = false;
                    ddlSala.Enabled = false;
                    ddlCat.Enabled = false;
                    btInserir.Enabled = false;
                }
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/Equips/Home.aspx");
        }
    }
}