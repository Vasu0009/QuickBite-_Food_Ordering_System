using System;
using System.Collections.Generic;
using System.ComponentModel;
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
            if (!IsPostBack)
            {
                fillDataList();
            }

        }

        void getcon()
        {
            con = new SqlConnection(str);
            con.Open();

        }
        protected void dtlsmenu_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected void nextbtn_Click1(object sender, ImageClickEventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["pid"]);
            currentPage++;
            ViewState["pid"] = currentPage;
            fillDataList();
        }

        protected void prebtn_Click1(object sender, ImageClickEventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["pid"]);
            currentPage--;
            ViewState["pid"] = currentPage;
            fillDataList();
        }

        protected void dtlsmenu_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("MenuDetails.aspx?id=" + id);
            }
        }

        void fillDataList()
        {

            da = new SqlDataAdapter("SELECT Id, Name, Price, CategoryId, Image, Description FROM Add_MenuItems", con);
            ds = new DataSet();
            da.Fill(ds);

            row = ds.Tables[0].Rows.Count;

            pg.AllowPaging = true;
            pg.PageSize = 3;
            pg.CurrentPageIndex = Convert.ToInt32(ViewState["pid"]);

            pg.DataSource = ds.Tables[0].DefaultView;

            prebtn.Enabled = !pg.IsFirstPage;
            nextbtn.Enabled = !pg.IsLastPage;


            dtlsmenu.DataSource = pg;
            dtlsmenu.DataBind();
        }



    }
}