using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;




namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class Users : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["QuickBite"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;


        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new CrystalDecisions.CrystalReports.Engine.ReportDocument();

        static string Crypath = "";

        void getcon()
        {
            con = new SqlConnection(str);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

            if (!IsPostBack)
            {
                BindUsersGrid();
            }
        }

        void BindUsersGrid()
        {
            getcon();
            da = new SqlDataAdapter("SELECT Id, First_Name, Last_Name, Email_Address, Phone_Number, Delivery_Address FROM register_tbl ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "No users registered yet.";
                gvUsers.DataSource = null;
                gvUsers.DataBind();
                lblTotalUsers.Text = "Total Users: 0";
                con.Close();
                return;
            }

            gvUsers.DataSource = ds.Tables[0];
            gvUsers.DataBind();
            lblTotalUsers.Text = "Total Users: " + ds.Tables[0].Rows.Count.ToString();
            con.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginAdmin.aspx");
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            BindUsersGrid();
            lblMessage.CssClass = "alert alert-success";
            lblMessage.Text = "Users list refreshed successfully!";
            pnlMessage.Visible = true;
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("DELETE FROM register_tbl WHERE Id='" + userId + "'", con);
            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                lblMessage.CssClass = "alert alert-success";
                lblMessage.Text = "User deleted successfully!";
                pnlMessage.Visible = true;
                BindUsersGrid();
            }
            else
            {
                lblMessage.CssClass = "alert alert-danger";
                lblMessage.Text = "Failed to delete user.";
                pnlMessage.Visible = true;
            }
            con.Close();
        }

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindUsersGrid();
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[5].Text.Length > 50)
                {
                    e.Row.Cells[5].Text = e.Row.Cells[5].Text.Substring(0, 47) + "...";
                    e.Row.Cells[5].ToolTip = e.Row.Cells[5].Text;
                }
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from register_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/User_Data.xml";
            ds.WriteXmlSchema(xml);

            Crypath = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/User_info.rpt";
            cr.Load(Crypath);
            cr.SetDataSource(ds);
            cr.Database.Tables[0].SetDataSource(ds);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;


            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "UserData");

        }
    }
}