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
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

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

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

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
            CrystalReportViewer1.Visible = false;

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
            pg.PageSize = 6;
            pg.CurrentPageIndex = Convert.ToInt32(ViewState["pid"]);

            pg.DataSource = ds.Tables[0].DefaultView;

            prebtn.Enabled = !pg.IsFirstPage;
            nextbtn.Enabled = !pg.IsLastPage;

            dtlsmenu.DataSource = pg;
            dtlsmenu.DataBind();
        }



        protected void reportbtn_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Add_MenuItems", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/MenuItem_user.xml";
            ds.WriteXmlSchema(xml);


            Crypath = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/Menu_Dwo.rpt";
            cr.Load(Crypath);
            cr.SetDataSource(ds);
            cr.Database.Tables[0].SetDataSource(ds);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;


            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "MenuItem_QuickBite");

        }
    }
}
