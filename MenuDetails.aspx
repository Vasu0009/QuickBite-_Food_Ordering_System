<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="MenuDetails.aspx.cs" Inherits="QuickBite__Food_Ordering_System.MenuDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
</asp:Content>

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="Home.aspx">QuickBite <i class="bi bi-cup-hot-fill text-warning ms-2"></i></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="Home.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="Menu.aspx">Menu</a></li>
                    <li class="nav-item"><a class="nav-link" href="About.aspx">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="Contact.aspx">Contact</a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-cart3"></i> Cart <span id="cart-count" class="badge bg-warning text-dark">0</span></a></li>
                    <li class="nav-item dropdown auth-link login-link">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle"></i> Account
                        </a>
                        <link href="css/MenuDetails.css" rel="stylesheet" />
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="Login.aspx"><i class="bi bi-box-arrow-in-right me-2"></i>Login</a></li>
                            <li><a class="dropdown-item" href="Register.aspx"><i class="bi bi-person-plus me-2"></i>Register</a></li>
                        </ul>
                    </li>
                    <li class="nav-item user-info" style="display: none;">
                        <!-- User dropdown will be populated by JavaScript -->
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</asp:Content>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- Menu Details Section -->
    <section class="menu-details-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <asp:DataList ID="dtlMainDish" runat="server" 
                        RepeatDirection="Horizontal" 
                        RepeatLayout="Flow" 
                        CssClass="main-dish-datalist">
                        <ItemTemplate>
                            <div class="dish-card">
                                <div class="row g-0 align-items-center">
                                    <!-- Dish Image -->
                                    <div class="col-lg-6 col-md-12">
                                        <div class="dish-image-container">
                                            <asp:Image ID="imgDish" runat="server" 
                                                CssClass="dish-image" 
                                                ImageUrl='<%# Eval("Image") %>' />
                                        </div>
                                    </div>
                                    
                                    <!-- Dish Information -->
                                    <div class="col-lg-6 col-md-12">
                                        <div class="dish-info">
                                            <h1 class="dish-title">
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                            </h1>
                                            
                                            <p class="dish-description">
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                            </p>
                                            
                                            <div class="dish-price">
                                                ₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                            </div>

                                            <div class="action-buttons">
                                                <asp:Button ID="btnAddToCart" runat="server"
                                                    Text="🛒 Add to Cart"
                                                    CssClass="btn btn-add-cart"
                                                    CommandName="AddToCart"
                                                    CommandArgument='<%# Eval("Id") %>' />
                                                <a href="Menu.aspx" class="btn-back">
                                                    <i class="bi bi-arrow-left me-2"></i>Back to Menu
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder3">
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="mb-4">QuickBite</h5>
                    <p class="mb-3">
                        Delivering premium culinary experiences to your doorstep with passion, quality, and speed.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-twitter fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin fs-5"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h5 class="mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="Home.aspx">Home</a></li>
                        <li class="mb-2"><a href="Menu.aspx">Menu</a></li>
                        <li class="mb-2"><a href="About.aspx">About</a></li>
                        <li class="mb-2"><a href="Contact.aspx">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="mb-4">Contact Info</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="bi bi-geo-alt me-2"></i>Sardhar - Rajkot 360025, Gujarat, India</li>
                        <li class="mb-2"><i class="bi bi-telephone me-2"></i>+91 99999 55555</li>
                        <li class="mb-2"><i class="bi bi-envelope me-2"></i>info@quickbite.com.in</li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5 class="mb-4">Business Hours</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2">Monday - Friday: 11:00 AM - 11:00 PM</li>
                        <li class="mb-2">Saturday - Sunday: 10:00 AM - 12:00 AM</li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p class="mb-0">
                    &copy; 2024 QuickBite. All rights reserved. | Designed with ❤️ for food lovers
                </p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/auth.js"></script>
</asp:Content>