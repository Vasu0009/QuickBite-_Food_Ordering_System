<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="QuickBite__Food_Ordering_System.CheckOut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-container {
            margin-top: 100px;
            margin-bottom: 50px;
        }
        .checkout-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .checkout-card-header {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #000;
            font-weight: bold;
            border-radius: 15px 15px 0 0 !important;
            padding: 15px 20px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #ffc107;
            box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.25);
        }
        .payment-option {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-option:hover {
            border-color: #ffc107;
            background-color: #fff8e1;
        }
        .payment-option.selected {
            border-color: #ffc107;
            background-color: #fff8e1;
        }
        .order-summary-item {
            border-bottom: 1px solid #e0e0e0;
            padding: 10px 0;
        }
        .total-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
        }
        .required-field::after {
            content: " *";
            color: red;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container checkout-container">
        <div class="text-center mb-5">
            <h1 class="display-4 fw-bold text-dark">
                <i class="bi bi-credit-card text-warning me-3"></i>Checkout
            </h1>
            <p class="text-muted">Complete your order in just a few steps</p>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger d-none" role="alert"></asp:Label>

        <div class="row">
            <!-- Left Column - Order Details -->
            <div class="col-lg-7">
                <!-- Shipping Address Section -->
                <div class="card checkout-card">
                    <div class="card-header checkout-card-header">
                        <i class="bi bi-house-door me-2"></i>Shipping Address
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label required-field">Full Name</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" 
                                    ErrorMessage="Full Name is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label required-field">Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter phone number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                                    ErrorMessage="Phone is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" 
                                    ValidationExpression="^[0-9]{10}$" ErrorMessage="Enter valid 10-digit phone" 
                                    CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label required-field">Street Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" 
                                Rows="2" placeholder="House no, Building name, Street"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" 
                                ErrorMessage="Address is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label required-field">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" 
                                    ErrorMessage="City is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label required-field">Pincode</label>
                                <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" placeholder="Pincode"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPincode" runat="server" ControlToValidate="txtPincode" 
                                    ErrorMessage="Pincode is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPincode" runat="server" ControlToValidate="txtPincode" 
                                    ValidationExpression="^[0-9]{6}$" ErrorMessage="Enter valid 6-digit pincode" 
                                    CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label required-field">State</label>
                            <asp:TextBox ID="txtState" runat="server" CssClass="form-control" placeholder="State"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" 
                                ErrorMessage="State is required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <!-- Billing Address Section -->
                <div class="card checkout-card">
                    <div class="card-header checkout-card-header">
                        <i class="bi bi-receipt me-2"></i>Billing Address
                    </div>
                    <div class="card-body">
                        <div class="form-check mb-4">
                            <asp:CheckBox ID="chkSameAsShipping" runat="server" CssClass="form-check-input" AutoPostBack="true" OnCheckedChanged="chkSameAsShipping_CheckedChanged" />
                            <label class="form-check-label fw-bold" style="margin-left: 5px;">
                                Same as Shipping Address
                            </label>
                        </div>
                        <div id="billingAddressFields" runat="server">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <asp:TextBox ID="txtBillFullName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <asp:TextBox ID="txtBillPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Street Address</label>
                                <asp:TextBox ID="txtBillAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">City</label>
                                    <asp:TextBox ID="txtBillCity" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Pincode</label>
                                    <asp:TextBox ID="txtBillPincode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">State</label>
                                <asp:TextBox ID="txtBillState" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payment Method Section -->
                <div class="card checkout-card">
                    <div class="card-header checkout-card-header">
                        <i class="bi bi-wallet2 me-2"></i>Payment Method
                    </div>
                    <div class="card-body">
                        <asp:RadioButtonList ID="rblPaymentMethod" runat="server" CssClass="payment-methods">
                            <asp:ListItem Value="COD" Selected="True">
                                <div class="payment-option">
                                    <i class="bi bi-cash-coin text-success me-2"></i>
                                    <strong>Cash on Delivery</strong>
                                    <p class="text-muted mb-0 ms-4">Pay when you receive your order</p>
                                </div>
                            </asp:ListItem>
                            <asp:ListItem Value="Card">
                                <div class="payment-option">
                                    <i class="bi bi-credit-card text-primary me-2"></i>
                                    <strong>Credit/Debit Card</strong>
                                    <p class="text-muted mb-0 ms-4">Visa, MasterCard, Rupay</p>
                                </div>
                            </asp:ListItem>
                            <asp:ListItem Value="UPI">
                                <div class="payment-option">
                                    <i class="bi bi-phone text-warning me-2"></i>
                                    <strong>UPI Payment</strong>
                                    <p class="text-muted mb-0 ms-4">Google Pay, PhonePe, Paytm</p>
                                </div>
                            </asp:ListItem>
                            <asp:ListItem Value="NetBanking">
                                <div class="payment-option">
                                    <i class="bi bi-bank text-info me-2"></i>
                                    <strong>Net Banking</strong>
                                    <p class="text-muted mb-0 ms-4">Pay via your bank account</p>
                                </div>
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rfvPayment" runat="server" ControlToValidate="rblPaymentMethod" 
                            ErrorMessage="Please select a payment method" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <!-- Right Column - Order Summary -->
            <div class="col-lg-5">
                <div class="card checkout-card sticky-top" style="top: 100px;">
                    <div class="card-header checkout-card-header">
                        <i class="bi bi-list-check me-2"></i>Order Summary
                    </div>
                    <div class="card-body">
                        <asp:GridView ID="gvOrderSummary" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-borderless" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="order-summary-item">
                                            <div class="d-flex align-items-center">
                                                <asp:Image ID="imgProduct" runat="server" 
                                                    ImageUrl='<%# Eval("C_Menu_Img") %>' 
                                                    CssClass="rounded me-3" Width="60" Height="60" />
                                                <div class="flex-grow-1">
                                                    <h6 class="mb-1"><%# Eval("C_Menu_Name") %></h6>
                                                    <small class="text-muted">
                                                        ₹<%# Eval("C_Menu_Price") %> × <%# Eval("C_Menu_Quant") %>
                                                    </small>
                                                </div>
                                                <div class="text-end">
                                                    <strong class="text-warning">₹<%# Eval("C_Menu_Total") %></strong>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <div class="total-section">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Subtotal:</span>
                                <asp:Label ID="lblSubtotal" runat="server" CssClass="fw-bold"></asp:Label>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>Delivery Charges:</span>
                                <asp:Label ID="lblDelivery" runat="server" Text="₹40.00" CssClass="fw-bold"></asp:Label>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span>GST (5%):</span>
                                <asp:Label ID="lblGST" runat="server" CssClass="fw-bold"></asp:Label>
                            </div>
                            <hr />
                            <div class="d-flex justify-content-between">
                                <h5 class="mb-0">Total Amount:</h5>
                                <h5 class="mb-0 text-warning">
                                    <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                                </h5>
                            </div>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                                CssClass="btn btn-warning btn-lg fw-bold" OnClick="btnPlaceOrder_Click" />
                            <asp:Button ID="btnBackToCart" runat="server" Text="Back to Cart" 
                                CssClass="btn btn-outline-secondary" OnClick="btnBackToCart_Click" CausesValidation="false" />
                        </div>

                        <div class="text-center mt-3">
                            <small class="text-muted">
                                <i class="bi bi-shield-check text-success me-1"></i>
                                Your payment information is secure
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add selection styling to payment options
        document.addEventListener('DOMContentLoaded', function () {
            const paymentOptions = document.querySelectorAll('.payment-option');
            paymentOptions.forEach(option => {
                option.addEventListener('click', function () {
                    paymentOptions.forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    // Find and check the radio button
                    const radio = this.closest('td').querySelector('input[type="radio"]');
                    if (radio) radio.checked = true;
                });
            });
        });
    </script>
</asp:Content>