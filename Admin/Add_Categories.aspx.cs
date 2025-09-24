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

        void selectCategory()
        {
            getcon();
            int id = Convert.ToInt32(ViewState["CategoryId"]);
            da = new SqlDataAdapter("SELECT * FROM Add_Category WHERE CategoryId=" + id, con);
            ds = new DataSet();
            da.Fill(ds);

            txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
            txtSlug.Text = ds.Tables[0].Rows[0]["Slug"].ToString();
            txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save Category")
            {
                getcon();
                cmd = new SqlCommand("INSERT INTO Add_Category (Name, Slug, Description) VALUES ('" + txtName.Text + "','" + txtSlug.Text + "','" + txtDescription.Text + "')", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Category added successfully.')</script>");

                BindCategories();
                clear();
            }
            else
            {
                getcon();
                int id = Convert.ToInt32(ViewState["CategoryId"]);
                cmd = new SqlCommand("UPDATE Add_Category SET Name='" + txtName.Text + "', Slug='" + txtSlug.Text + "', Description='" + txtDescription.Text + "' WHERE CategoryId=" + id, con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Category updated successfully.')</script>");
                btnSave.Text = "Save Category";
                lblModalTitle.Text = "Add Category";
                BindCategories();
                clear();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["admin"] = null;
            Response.Redirect("LoginAdmin.aspx");
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            if (e.CommandName == "cmd_edt")
            {
                ViewState["CategoryId"] = id;
                selectCategory();
                btnSave.Text = "Update Category";
                lblModalTitle.Text = "Edit Category";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openModal();", true);




            }
            else if (e.CommandName == "cmd_dlt")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM Add_Category WHERE CategoryId=" + id, con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Category deleted successfully.')</script>");
                BindCategories();
            }
        }
    }
}