using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QuickBite__Food_Ordering_System
{
    public partial class CheckOut : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                BindOrderSummary();
            }
        }

        void BindOrderSummary()
        {
            getcon();

            if (Session["user"] == null)
            {
                lblMessage.Text = "Please login first.";
                con.Close();
                return;
            }

            da = new SqlDataAdapter("SELECT * FROM register_tbl WHERE Email_Address='" + Session["user"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "User not found.";
                con.Close();
                return;
            }

            int uid = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

     
            da = new SqlDataAdapter("SELECT C_Menu_Name, C_Menu_Price, C_Menu_Quant, C_Menu_Img, (C_Menu_Price * C_Menu_Quant) AS C_Menu_Total FROM MenuCart_tbl WHERE User_Cart_Id='" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty.";
                gvOrderSummary.DataSource = null;
                gvOrderSummary.DataBind();
                con.Close();
                return;
            }

            decimal subtotal = 0;
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                subtotal += Convert.ToDecimal(dr["C_Menu_Total"]);
            }

            lblSubtotal.Text = "₹" + subtotal.ToString("0.00");
            lblTotalAmount.Text = "₹" + subtotal.ToString("0.00");

            gvOrderSummary.DataSource = ds.Tables[0];
            gvOrderSummary.DataBind();

            con.Close();
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            getcon();

            if (Session["user"] == null)
            {
                lblMessage.Text = "Please login first.";
                con.Close();
                return;
            }
            // 1. Get user id
            da = new SqlDataAdapter("SELECT * FROM register_tbl WHERE Email_Address='" + Session["user"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "User not found.";
                con.Close();
                return;
            }

            int uid = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // 2. Get cart items with CAST
            da = new SqlDataAdapter("SELECT *, (C_Menu_Price * C_Menu_Quant) AS Total FROM MenuCart_tbl WHERE User_Cart_Id='" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataTable cartItems = ds.Tables[0];

            if (cartItems.Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty.";
                con.Close();
                return;
            }

            // 3. Calculate Total Amount
            decimal subtotal = 0;
            foreach (DataRow dr in cartItems.Rows)
            {
                subtotal += Convert.ToDecimal(dr["Total"]);
            }

            lblSubtotal.Text = "₹" + subtotal.ToString("0.00");
            lblTotalAmount.Text = "₹" + subtotal.ToString("0.00");

            // 4. Insert Order_tbl
            string shippingAddress = txtAddress.Text.Trim() + ", " + txtCity.Text.Trim() + ", " + txtState.Text.Trim() + " - " + txtPincode.Text.Trim();
            string billingAddress = txtBillAddress.Text.Trim() + ", " + txtBillCity.Text.Trim() + ", " + txtBillState.Text.Trim() + " - " + txtBillPincode.Text.Trim();
            string paymentMethod = rblPaymentMethod.SelectedValue;

            if (string.IsNullOrEmpty(shippingAddress))
            {
                lblMessage.Text = "Please enter a shipping address.";
                return;
            }

            
            cmd = new SqlCommand(
                "INSERT INTO Orders(User_Id,Order_Date,Total_Amount,Order_Status,Shipping_Address,Billing_Address,Payment_Method) " +
                "VALUES('" + uid + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + subtotal + "','Pending','" + shippingAddress + "','" + billingAddress + "','" + paymentMethod + "'); SELECT SCOPE_IDENTITY();",
                con);

            int orderId = Convert.ToInt32(cmd.ExecuteScalar());

            // 5. Insert Order Items
            foreach (DataRow dr in cartItems.Rows)
            {
                cmd = new SqlCommand(
                    "INSERT INTO order_items_tbl(Order_id,Menu_id,Menu_Name,Menu_Price,Menu_Quantity,Menu_Image) " +
                    "VALUES('" + orderId + "', 0, '" + dr["C_Menu_Name"] + "', '" + dr["C_Menu_Price"] + "', '" + dr["C_Menu_Quant"] + "', '" + dr["C_Menu_Img"] + "')",
                    con);

                cmd.ExecuteNonQuery();
            }

            // 6. Clear user's cart
            cmd = new SqlCommand("DELETE FROM MenuCart_tbl WHERE User_Cart_Id='" + uid + "'", con);
            cmd.ExecuteNonQuery();

            lblMessage.CssClass = "alert alert-success";
            lblMessage.Text = " Your order has been placed successfully!";

            gvOrderSummary.DataSource = null;
            gvOrderSummary.DataBind();
            lblSubtotal.Text = "₹0.00";
            lblTotalAmount.Text = "₹0.00";

            con.Close();
        }

        protected void btnBackToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void chkSameAsShipping_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSameAsShipping.Checked)
            {
                txtBillFullName.Text = txtFullName.Text;
                txtBillPhone.Text = txtPhone.Text;
                txtBillAddress.Text = txtAddress.Text;
                txtBillCity.Text = txtCity.Text;
                txtBillPincode.Text = txtPincode.Text;
                txtBillState.Text = txtState.Text;
            }
            else
            {
                txtBillFullName.Text = "";
                txtBillPhone.Text = "";
                txtBillAddress.Text = "";
                txtBillCity.Text = "";
                txtBillPincode.Text = "";
                txtBillState.Text = "";
            }
        }
    }
}
