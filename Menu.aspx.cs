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
        int row;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            da = new SqlDataAdapter("Select * from register_tbl where Email_Address='" + Session["user"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            int userid = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            string s = ds.Tables[0].Rows[0][1].ToString();
            lbl.Text = "Welcome, " + s;
            fillDataList();
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
            else if (e.CommandName == "cmd_cart")
            {
               
                da = new SqlDataAdapter("Select * from register_tbl where Email_Address ='" + Session["user"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                int userid = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

                int menuid = Convert.ToInt32(e.CommandArgument);
                da = new SqlDataAdapter("Select * from Add_MenuItems where Id='" + menuid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                string menuname = ds.Tables[0].Rows[0]["Name"].ToString();
                string menuprice = ds.Tables[0].Rows[0]["Price"].ToString();
                int quant = 1;
                int total = Convert.ToInt32(menuprice) * quant;
                string menuimg = ds.Tables[0].Rows[0]["Image"].ToString();

               
                cmd = new SqlCommand("Insert into MenuCart_tbl (User_Cart_Id, Menu_Cart_Id, C_Menu_Name, C_Menu_Quant, C_Menu_Price, C_Menu_Total, C_Menu_Img) " +
                                     "values('" + userid + "','" + menuid + "','" + menuname + "','" + quant + "','" + menuprice + "','" + total + "','" + menuimg + "')", con);
                cmd.ExecuteNonQuery();
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
