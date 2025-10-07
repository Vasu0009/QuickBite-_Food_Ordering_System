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
    public partial class Cart : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;
        int p, row;

        void getcon()
        {
            con = new SqlConnection(str);
            con.Open();
        }

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
            string Q = ds.Tables[0].Rows[0][1].ToString();
            lblmsg.Text = "Welcome, " + Q;

            fillGrid();

        }

        void fillGrid()
        {
            getcon();
            da = new SqlDataAdapter("Select * from register_tbl where Email_Address ='" + Session["user"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            int userid = Convert.ToInt16(ds.Tables[0].Rows[0][0]);
            da = new SqlDataAdapter("Select * from MenuCart_tbl where User_Cart_Id='" + userid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            gvCart.DataSource = ds;
            gvCart.DataBind();
        }

        protected void btnUpd_Click(object sender, EventArgs e)
        {
          
          
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_remove")
            {
                int cartid = Convert.ToInt32(e.CommandArgument);
                getcon();
                cmd = new SqlCommand("Delete from MenuCart_tbl where Cart_Id='" + cartid + "'", con);
                cmd.ExecuteNonQuery();
                fillGrid();
            }
            else if (e.CommandName == "cmd_minus")
            {
                int cartid = Convert.ToInt32(e.CommandArgument);
                getcon();
                da = new SqlDataAdapter("Select * from MenuCart_tbl where Cart_Id='" + cartid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int quant = Convert.ToInt32(ds.Tables[0].Rows[0][4]);
                    int price = Convert.ToInt32(ds.Tables[0].Rows[0][5]);

                    if (quant > 1)
                    {
                        quant--;
                        Int64 tot = quant * price;
                        cmd = new SqlCommand("Update MenuCart_tbl set C_Menu_Quant='" + quant + "', C_Menu_Total='" + tot + "' where Cart_Id='" + cartid + "'", con);
                        cmd.ExecuteNonQuery();
                        fillGrid();
                    }
                }
            }
            else if (e.CommandName == "cmd_plus")
            {
                int cartid = Convert.ToInt32(e.CommandArgument);
                getcon();
                da = new SqlDataAdapter("Select * from MenuCart_tbl where Cart_Id='" + cartid + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int quant = Convert.ToInt32(ds.Tables[0].Rows[0][4]);
                    int price = Convert.ToInt32(ds.Tables[0].Rows[0][5]);
                    quant++;
                    Int64 total = quant * price;
                    cmd = new SqlCommand("Update MenuCart_tbl set C_Menu_Quant='" + quant + "', C_Menu_Total='" + total + "' where Cart_Id='" + cartid + "'", con);
                    cmd.ExecuteNonQuery();
                    fillGrid();
                }
            }
        }

        

  
    }
}