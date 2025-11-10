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

            if (Session["user"] == null)
            {
                Response.Redirect("Login.aspx");
            }

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

        protected void dtlMainDish_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
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
                Response.Write("<script>alert('Item added to cart successfully!');</script>");
            }
        }
    }
}