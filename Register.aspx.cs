using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

using CrystalDecisions.CrystalReports.Engine;

using CrystalDecisions.Shared;


namespace QuickBite__Food_Ordering_System
{
    public partial class Register : System.Web.UI.Page
    {
        string Q = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;

        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new CrystalDecisions.CrystalReports.Engine.ReportDocument();

        static string Crypath = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }

        void clear()
        {
            txtfnm.Text = "";
            txtlnm.Text = "";
            txteml.Text = "";
            txtphone.Text = "";
            txtadd.Text = "";
            txtpwd.Text = "";
            txtcfpwd.Text = "";
        }

        void getcon()
        {
            con = new SqlConnection(Q);
            con.Open();
        }



        protected void btnregister_Click(object sender, EventArgs e)
        {


            if (btnregister.Text == "Create Account")
            {
                getcon();
                cmd = new SqlCommand("insert into register_tbl(First_Name,Last_Name,Email_Address,Phone_Number,Delivery_Address,Password)" + " values('" + txtfnm.Text + "','" + txtlnm.Text + "','" + txteml.Text + "','" + txtphone.Text + "','" + txtadd.Text + "','" + txtpwd.Text + "')", con);
                cmd.ExecuteNonQuery();
                lblMessage.Text = "Registration Successful";
                Response.Redirect("Login.aspx");
                clear();
               
            }

        }

        protected void rept1_Click(object sender, EventArgs e)
        {

            da = new SqlDataAdapter("select * from register_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = @"E:\SEM-5\ASP.NET\QuickBite _Food_Ordering_System\User_Data.xml";
            ds.WriteXmlSchema(xml);
            ds.WriteXml(xml);

            Crypath = @"E:\SEM-5\ASP.NET\QuickBite _Food_Ordering_System\Register.rpt";
            cr.Load(Crypath);
            cr.SetDataSource(ds);
            CrystalReportViewer1.ReportSource = cr;
            CrystalReportViewer1.RefreshReport();






        }



    }
}
