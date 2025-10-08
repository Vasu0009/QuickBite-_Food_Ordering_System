using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QuickBite__Food_Ordering_System
{
    public partial class CheckOut : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        void getcon()
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["QuickBiteConnectionString"].ConnectionString);
            con.Open();
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            getcon();

            // 1. Get user id from stud_tbl
            da = new SqlDataAdapter("Select * from stud_tbl where Email='" + Session["user"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                lblMessage.Text = "User not found";
                con.Close();
                return;
            }

            int uid = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // 2. Get cart items for this user
            da = new SqlDataAdapter("Select * , (C_Menu_Price * C_Menu_Quant) as Total from MenuCart_tbl where Cust_id='" + uid + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataTable cartItems = ds.Tables[0];

            if (cartItems.Rows.Count == 0)
            {
                lblMessage.Text = "Your cart is empty";
                con.Close();
                return;
            }

            // 3. Calculate Total Amount
            decimal totalAmount = 0;
            foreach (DataRow dr in cartItems.Rows)
            {
                if (dr["Total"] != DBNull.Value)
                {
                    totalAmount += Convert.ToDecimal(dr["Total"]);
                }
            }

            // 4. Insert Order_tbl
            string shippingAddress = txtAddress.Text.Trim() + ", " + txtCity.Text.Trim() + ", " + txtState.Text.Trim() + " - " + txtPincode.Text.Trim();
            string billingAddress = txtBillAddress.Text.Trim() + ", " + txtBillCity.Text.Trim() + ", " + txtBillState.Text.Trim() + " - " + txtBillPincode.Text.Trim();
            string paymentMethod = rblPaymentMethod.SelectedValue;

            if (string.IsNullOrEmpty(shippingAddress))
            {
                lblMessage.Text = "Please enter a shipping address";
                con.Close();
                return;
            }

            cmd = new SqlCommand("Insert into Orders(User_Id,Order_Date,Total_Amount,Order_Status,Shipping_Address,Billing_Address,Payment_Method) " +
                "values('" + uid + "','" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "','" + totalAmount + "','Pending','" + shippingAddress + "','" + billingAddress + "','" + paymentMethod + "'); SELECT SCOPE_IDENTITY();", con);

            int orderId = Convert.ToInt32(cmd.ExecuteScalar());

            // 5. Insert Order Items
            foreach (DataRow dr in cartItems.Rows)
            {
                cmd = new SqlCommand("Insert into order_items_tbl (Order_id,Menu_id,Menu_Name,Menu_Price,Menu_Quantity,Menu_Image) " +
                    "values ('" + orderId + "','" + dr["Menu_id"] + "','" + dr["C_Menu_Name"] + "','" + dr["C_Menu_Price"] + "','" + dr["C_Menu_Quant"] + "','" + dr["C_Menu_Img"] + "')", con);
                cmd.ExecuteNonQuery();
            }

            // 6. Clear user's cart after placing order
            cmd = new SqlCommand("delete from MenuCart_tbl where Cust_id='" + uid + "'", con);
            cmd.ExecuteNonQuery();

            lblMessage.CssClass = "alert alert-success";
            lblMessage.Text = "Your order has been placed successfully!";
            con.Close();
        }

        protected void btnBackToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("cart.aspx");
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
