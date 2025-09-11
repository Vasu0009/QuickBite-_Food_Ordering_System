using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace QuickBite__Food_Ordering_System
{
    public partial class Login : System.Web.UI.Page
    {
        string Q = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int i;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void getcon()
        {
            if (con == null)
            {
                con = new SqlConnection(Q);
                con.Open();
            }
        }
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            getcon();
            if (txteml.Text != null && txtpwd.Text != null)
            {
                cmd = new SqlCommand("SELECT count(*) FROM register_tbl WHERE Email_Address='" + txteml.Text + "' AND Password='" + txtpwd.Text + "'", con);
                cmd.ExecuteNonQuery();
                i = Convert.ToInt32(cmd.ExecuteScalar());

                if (i > 0)
                {
                    Session["user"] = txteml.Text;
                    Label1.Text = "Login Successful";
                    Response.Redirect("Home.aspx");
                }
            }
            else
            {
                lblMessage.Text = "Invalid Username or Password";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}
  