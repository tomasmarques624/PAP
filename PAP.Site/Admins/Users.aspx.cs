using PAP.DataAccess.UserDA;
using PAP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
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
                List<User> listUsers = UserDAO.GetUsers();
                gvUsers.DataSource = listUsers;
                gvUsers.DataBind();
            }
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
            for (int i = 0; i < gvUsers.Rows.Count; i++)
            {

                User user = UserDAO.GetUserByID(Convert.ToInt32(gvUsers.DataKeys[i].Value));
                int id_user = user.id_User;

                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxEliminar")).Checked)
                {
                    UserDAO.RemoveUser(id_user);
                    continue;
                }

                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxAdmin")).Checked)
                {
                    user.Role = 'A';
                }
                else
                {
                    user.Role = 'U';
                    if (Session["username"].ToString() == user.Username)
                    {
                        Session["role"] = 'U';
                    }
                }
                if (((CheckBox)gvUsers.Rows[i].FindControl("chbxDesbloquear")).Checked)
                {
                    UserDAO.LockUser(id_user);
                }
                else
                {
                    UserDAO.UnlockUser(id_user);
                }
                UserDAO.UpdateUser(user);
            }
            Response.Redirect("~/Admins/Home.aspx");
        }

        protected void btNovoUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Admins/NewUser.aspx");
        }
    }
}