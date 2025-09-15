using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class Add_Categories : System.Web.UI.Page
    {
        string Q = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

            getcon();

            if (!IsPostBack)
            {
                BindCategories();
            }
        }

        void getcon()
        {
            con = new SqlConnection(Q);
            con.Open();
        }

        void clear()
        {
            txtName.Text = "";
            txtSlug.Text = "";
            txtDescription.Text = "";
        }

        void BindCategories()
        {
            da = new SqlDataAdapter("SELECT * FROM Add_Category", con);
            ds = new DataSet();
            da.Fill(ds);

            gvCategories.DataSource = ds;
            gvCategories.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand("INSERT INTO Add_Category (Name, Slug, Description) VALUES ('" + txtName.Text + "','" + txtSlug.Text + "','" + txtDescription.Text + "')", con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Category added successfully.')</script>");


            BindCategories();
            clear();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["admin"] = null;
            Response.Redirect("LoginAdmin.aspx");
        }
    }
}