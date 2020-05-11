using PAP.DataAccess.SalasDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Admins.Salas
{
    public partial class NewSala : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btInserir_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Models.Salas sala = new Models.Salas()
                {
                    nome_sala = tbxNome.Text
                };

                int returncode = SalasDAO.InsertSala(sala);

                if (returncode == -1)
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Red;
                    lbMensagem.Text = "Adição falhada!<br />Contacte o administrador ou tente novamente...";
                }
                else
                {
                    lbMensagem.ForeColor = System.Drawing.Color.Green;
                    lbMensagem.Text = "Adição Efetuada com sucesso!";
                    tbxNome.Enabled = false;
                    btInserir.Enabled = false;
                    btCancelar.Text = "Voltar";
                }
            }
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/Salas/SalasGrid.aspx");
        }
    }
}