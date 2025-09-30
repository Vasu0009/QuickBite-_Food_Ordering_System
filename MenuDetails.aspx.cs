using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBite__Food_Ordering_System
{
    public partial class MenuDetails : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        PagedDataSource pg = new PagedDataSource();
        string fnm;
        int p, row;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (!IsPostBack)
            {
                filldtLs();
            }
        }

        void getcon()
        {
            con = new SqlConnection(str);
            con.Open();
        }

        void filldtLs()
        {

            getcon();
            da = new SqlDataAdapter("select * from Add_MenuItems where Id=" + Request.QueryString["id"].ToString(), con);
            ds = new DataSet();
            da.Fill(ds);

            dtlMainDish.DataSource = ds;
            dtlMainDish.DataBind();
        }

    }
}

