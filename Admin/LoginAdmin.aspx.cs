using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class LoginAdminaspx : System.Web.UI.Page
    {
        string Q = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        int i;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }

            adminLoginAlert.Visible = false;
        }

        void getcon()
        {
            if (con == null)
            {
                con = new SqlConnection(Q);
                con.Open();
            }
        }

        protected void adminLoginBtn_Click(object sender, EventArgs e)
        {
            getcon();

            if (admintxtunm.Text != null && admintxtpwd.Text != null)
            {
                cmd = new SqlCommand("SELECT count(*) FROM Admin WHERE Username='" + admintxtunm.Text + "' AND Password='" + admintxtpwd.Text + "'", con);
                i = Convert.ToInt32(cmd.ExecuteScalar());

                if (i > 0)
                {
                    Session["admin"] = admintxtunm.Text;
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    adminLoginAlert.Visible = true;
                }
            }
            else
            {
                adminLoginAlert.Visible = true;
            }
        }
    }
}