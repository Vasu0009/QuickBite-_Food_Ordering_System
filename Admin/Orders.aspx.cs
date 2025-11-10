using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;

namespace QuickBite__Food_Ordering_System.Admin
{
    public partial class Orders : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        void BindOrders()
        {
            getcon();

            da = new SqlDataAdapter("SELECT * FROM Orders ORDER BY Order_Date DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "No orders found.";
                GridView1.DataSource = null;
                GridView1.DataBind();
                con.Close();
                return;
            }

            GridView1.DataSource = ds.Tables[0];
            GridView1.DataBind();

            con.Close();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                getcon();

                cmd = new SqlCommand("DELETE FROM Orders WHERE Order_Id='" + orderId + "'", con);
                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    lblMessage.CssClass = "alert alert-success";
                    lblMessage.Text = "Order deleted successfully!";
                    BindOrders();
                }
                else
                {
                    lblMessage.Text = "Failed to delete order.";
                }
            if (Session["admin"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

                con.Close();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../Login.aspx");
            Response.Redirect("LoginAdmin.aspx");
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from Orders", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/Orders_Data.xml";
            ds.WriteXmlSchema(xml);

            Crypath = @"E:/SEM-5/ASP.NET/QuickBite _Food_Ordering_System/Orders_info.rpt";
            cr.Load(Crypath);
            cr.SetDataSource(ds);
            cr.Database.Tables[0].SetDataSource(ds);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;


            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Orders");

        }
    }
}
