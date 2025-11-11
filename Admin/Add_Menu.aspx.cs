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
using CrystalDecisions.Web.Design;

namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class Add_MenuAdmin : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

            getcon();
            if (!IsPostBack)
            {
                fillCategory();
                BindMenuItems();
                CrystalReportViewer1.Visible = false;

            }
        }

        void clear()
        {
            txtName.Text = "";
            ddlCategory.SelectedIndex = -1;
            txtPrice.Text = "";
            txtDescription.Text = "";
        }

        void imgUpload()
        {
            if (fldimg.HasFile)
            {
                fnm = "../MenuImg/" + fldimg.FileName;
                fldimg.SaveAs(Server.MapPath(fnm));
            }
        }

        void fillCategory()
        {
            getcon();
            da = new SqlDataAdapter("SELECT CategoryId, Name FROM Add_Category", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlCategory.Items.Clear();
            ddlCategory.Items.Add("-- Select Category --");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                ddlCategory.Items.Add(ds.Tables[0].Rows[i][1].ToString());
            }
        }

        void BindMenuItems()
        {
            getcon();
            da = new SqlDataAdapter("SELECT Id, Name, Price, CategoryId, Image, [Description] AS Description FROM Add_MenuItems", con);
            ds = new DataSet();
            da.Fill(ds);

            gvMenuItems.DataSource = ds;
            gvMenuItems.DataBind();
        }

        void selectMenuItem()
        {
            getcon();
            int id = Convert.ToInt32(ViewState["MenuItemId"]);
            da = new SqlDataAdapter("SELECT Id, Name, Price, CategoryId, Image, [Description] AS Description FROM Add_MenuItems WHERE Id='" + id + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                txtPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                txtDescription.Text = ds.Tables[0].Rows[0]["Description"].ToString();

                string categoryId = ds.Tables[0].Rows[0]["CategoryId"].ToString();
                da = new SqlDataAdapter("SELECT Name FROM Add_Category WHERE CategoryId='" + categoryId + "'", con);
                DataSet dsCategory = new DataSet();
                da.Fill(dsCategory);

                if (dsCategory.Tables[0].Rows.Count > 0)
                {
                    ddlCategory.SelectedItem.Text = dsCategory.Tables[0].Rows[0]["Name"].ToString();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (btnSave.Text == "Save Item")
            {
                getcon();
                imgUpload();

                cmd = new SqlCommand("INSERT INTO Add_MenuItems (Name, Price, CategoryId, Image, Description) VALUES ('" + txtName.Text + "','" + txtPrice.Text + "','" + ViewState["cid"].ToString() + "','" + fnm + "','" + txtDescription.Text + "')", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Menu item added successfully.')</script>");
                clear();
                BindMenuItems();
            }
            else if (btnSave.Text == "Update Item")
            {
                getcon();
                imgUpload();
                int id = Convert.ToInt32(ViewState["MenuItemId"]);
                cmd = new SqlCommand("UPDATE Add_MenuItems SET Name='" + txtName.Text + "', Price='" + txtPrice.Text + "', CategoryId='" + ViewState["cid"].ToString() + "', Image='" + fnm + "', Description='" + txtDescription.Text + "' WHERE Id='" + id + "'", con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Menu item updated successfully.')</script>");
                clear();
                BindMenuItems();
                btnSave.Text = "Save Item";
                lblModalTitle.Text = "Add Menu Item";
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "var modal = new bootstrap.Modal(document.getElementById('menuModal')); modal.hide();", true);
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            da = new SqlDataAdapter("SELECT CategoryId FROM Add_Category WHERE Name='" + ddlCategory.SelectedItem.ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            ViewState["cid"] = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
        }

        protected void gvMenuItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            if (e.CommandName == "cmd_edt")
            {
                ViewState["MenuItemId"] = id;
                selectMenuItem();
                btnSave.Text = "Update Item";
                lblModalTitle.Text = "Edit Menu Item";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "var modal = new bootstrap.Modal(document.getElementById('menuModal')); modal.show();", true);
            }
            else if (e.CommandName == "cmd_dlt")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM Add_MenuItems WHERE Id=" + id, con);
                cmd.ExecuteNonQuery();
                Response.Write("<script>alert('Menu item deleted successfully.')</script>");
                BindMenuItems();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["admin"] = null;
            Response.Redirect("LoginAdmin.aspx");
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Add_MenuItems", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/MenuItem_Report.xml";
            ds.WriteXmlSchema(xml);


            Crypath = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/MenuItem.rpt";
            cr.Load(Crypath);
            cr.SetDataSource(ds);
            cr.Database.Tables[0].SetDataSource(ds);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;


            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "MenuItem_Report");

        }
    }
}