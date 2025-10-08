using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginAdmin.aspx");
        }
    }
}