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
    public partial class Menu : System.Web.UI.Page
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
            fillDataList();
        }

        void getcon()
        {
            con = new SqlConnection(str);
            con.Open();
        }
        void fillDataList()
        {
            
            da = new SqlDataAdapter("select * from Add_MenuItems", con);
            ds = new DataSet();
            da.Fill(ds);


            dtlsmenu.DataSource = ds;
            dtlsmenu.DataBind();
        }

    }
}