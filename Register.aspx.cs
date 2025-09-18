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
    public partial class Register : System.Web.UI.Page
    {
        string Q = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;

        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
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


    }
}