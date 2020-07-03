using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PAP.Site.Users
{
    public partial class Users : System.Web.UI.Page
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
            List<User> listUsers = UserDAO.GetUsers();
            gvUsers.DataSource = listUsers;
            gvUsers.DataBind();
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                User user = UserDAO.GetUserByID(Convert.ToInt32(e.Row.Cells[0].Text));
                if (user.Role == 'A')
                {
                    ((CheckBox)e.Row.FindControl("chbxAdmin")).Checked = true;
                }
                if (user.isloocked == true)
                {
                    ((CheckBox)e.Row.FindControl("chbxDesbloquear")).Checked = true;
                }
            }
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            MPE_Rem.Show();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            DataBindGrid();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            DataBindGrid();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Boolean a = false;
            User user = null;
            try
            {
                user = UserDAO.GetUserByID(Convert.ToInt32(gvUsers.Rows[e.RowIndex].Cells[0].Text));
                a = true;
            }
            catch (Exception)
            {
                throw;
            }
            if(a == true)
            {
                user.Username = e.NewValues["username"].ToString();
                user.Email = e.NewValues["email"].ToString();

                int ReturnCode = UserDAO.UpdateUser(user);
                if (ReturnCode == -1)
                {
                    String str = "<script>alertify.error('Alteração feita sem sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    lbErro.Text = "Ja existe um utilizador com este username.";
                    MPE_Erro.Show();
                    gvUsers.EditIndex = -1;
                    DataBindGrid();
                }
                else
                {
                    String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
                    gvUsers.EditIndex = -1;
                    DataBindGrid();
                }
            }
            else
            {
                gvUsers.EditIndex = -1;
                DataBindGrid();
            }
        }

        protected void btSimRe_Click(object sender, EventArgs e)
        {
            bool a = false, b = false, c = false;
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {
                User user = null;
                try
                {
                    user = UserDAO.GetUserByID(Convert.ToInt32(gvUsers.DataKeys[i].Value));
                }
                catch (Exception)
                {
                    throw;
                }
                

                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    a = true;
                    int id_user = user.id_User;
                    UserDAO.RemoveUser(id_user);
                    continue;
                }

                // Roles

                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxAdmin")).Checked)
                {
                    b = true;
                    user.Role = 'A';
                }
                else
                {
                    b = true;
                    user.Role = 'U';
                    if (Session["username"].ToString() == user.Username)
                    {
                        Session["role"] = 'U';
                    }
                }

                // Blocks

                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxDesbloquear")).Checked)
                {
                    c = true;
                    UserDAO.LockUser(user.id_User);
                }
                else
                {
                    c = true;
                    UserDAO.UnlockUser(user.id_User);
                }


                if (b == true)
                {
                    UserDAO.UpdateUser(user);
                }
            }
            MPE_Rem.Hide();
            if (a == true)
            {
                String str = "<script>alertify.success('Remoção feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
            if (b == true)
            {
                String str = "<script>alertify.success('Alteração feita com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }
            if (c == true)
            {
                String str = "<script>alertify.success('Bloqueio feito com sucesso!');</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            }

            DataBindGrid();
        }

        protected void btCancelar_Click(object sender, EventArgs e)
        {
            DataBindGrid();
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
                List<User> listUsers = null;

                using (SqlConnection connection = new SqlConnection())
                {
                    connection.ConnectionString = ConfigurationManager.ConnectionStrings["PAP_DBCS"].ConnectionString;
                    using (SqlCommand command = new SqlCommand())
                    {
                        command.Connection = connection;
                        if (rblPesq.SelectedValue == "1")
                        {
                            command.CommandText = "SELECT * FROM tblUsers WHERE username LIKE '" + tbxPesq.Text + "%';";
                        }
                        else
                        {
                            command.CommandText = "SELECT * FROM tblUsers WHERE email LIKE '" + tbxPesq.Text + "%';";
                        }

                        connection.Open();

                        using (SqlDataReader dataReader = command.ExecuteReader())
                        {
                            if (dataReader.HasRows)
                            {
                                listUsers = new List<User>();
                                while (dataReader.Read())
                                {
                                    listUsers.Add(new User()
                                    {
                                        id_User = Convert.ToInt32(dataReader["id_user"]),
                                        Username = dataReader["username"].ToString(),
                                        Email = dataReader["email"].ToString(),
                                        isloocked = Convert.ToBoolean(dataReader["is_looked"])
                                    });
                                }
                            }
                        }
                    }
                }
                gvUsers.DataSource = listUsers;
                gvUsers.DataBind();
            }
            else
            {
                DataBindGrid();
            }
        }

        protected void btLimparFiltros_Click(object sender, EventArgs e)
        {
            tbxPesq.Text = "";
            DataBindGrid();
        }

        protected void lkContactar_Click(object sender, EventArgs e)
        {
            MPE_Contactar.Show();
            LinkButton lk = (LinkButton)sender;

            GridViewRow gv = (GridViewRow)lk.NamingContainer;

            int index = gv.RowIndex;
            id_user.Value = gvUsers.Rows[index].Cells[0].Text;
        }

        protected void btCancelarContactar_Click(object sender, EventArgs e)
        {
            MPE_Contactar.Hide();
            tbxMensagem.Text = "";
            tbxAssunto.Text = "";        }

        protected void btEnviar_Click(object sender, EventArgs e)
        {
            User user = UserDAO.GetUserByID(Convert.ToInt32(id_user.Value));
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress("likedat6969@gmail.com");
            mailMessage.To.Add(user.Email);
            mailMessage.Subject = tbxAssunto.Text;
            mailMessage.Body = "<h3>G.E.T</h3><br/>" + tbxMensagem.Text;
            mailMessage.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
            smtpClient.EnableSsl = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential("likedat6969@gmail.com", "teste123456");
            smtpClient.Send(mailMessage);

            MPE_Contactar.Hide();
            String str = "<script>alertify.success('Email enviado com sucesso!');</script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Script", str, false);
            tbxMensagem.Text = "";
            tbxAssunto.Text = "";
            
        }
    }
}