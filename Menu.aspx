<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder3">
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="mb-4">QuickBite</h5>
                    <p class="mb-3">Delivering premium culinary experiences to your doorstep with passion, quality, and speed.</p>
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
                        <li class="mb-2">
                            <i class="bi bi-geo-alt me-2"></i>
                            Sardhar - Rajkot 360025, Gujarat, India
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-telephone me-2"></i>
                            +91 99999 55555
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-envelope me-2"></i>
                            info@quickbite.com.in
                        </li>
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
                <p class="mb-0">&copy; 2024 QuickBite. All rights reserved. | Designed with ❤️ for food lovers</p>
            </div>
        </div>
    </footer>
    <!-- Cart Modal -->
    <div class="modal fade" id="cartModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header bg-gradient text-white" style="background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);">
                    <h5 class="modal-title fw-bold text-dark"><i class="bi bi-cart3 me-2"></i>Shopping Cart </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal">
                    </button>
                </div>
                <div class="modal-body p-0">
                    <div id="cart-items" class="cart-items-container" style="max-height: 400px; overflow-y: auto;">
                        <!-- Cart items will be populated here -->
                    </div>
                    <div id="cart-empty" class="text-center py-5 px-4">
                        <div class="empty-cart-icon mb-4">
                            <i class="bi bi-cart3 text-muted" style="font-size: 3rem; opacity: 0.3;"></i>
                        </div>
                        <h5 class="text-muted mb-3">Your cart is empty</h5>
                        <p class="text-muted mb-4">
                            Add some delicious items to get started!
                        </p>
                        <a href="Menu.aspx" class="btn btn-warning"><i class="bi bi-shop me-2"></i>Browse Menu </a>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <div class="d-flex justify-content-between align-items-center w-100">
                        <div class="cart-total">
                            <span class="h5 fw-bold text-dark">Total: ₹<span id="cart-total">0</span></span>
                        </div>
                        <div>
                            <button type="button" class="btn btn-outline-secondary me-2" data-bs-dismiss="modal">
                                Continue Shopping
                            </button>
                            <button type="button" class="btn btn-warning fw-bold" onclick="checkout()" id="checkout-btn" style="display: none;">
                                <i class="bi bi-credit-card me-2"></i>Checkout
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/auth.js"></script>

    <!-- Hero Slider JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const slides = document.querySelectorAll('.hero-slider .slide');
            const dots = document.querySelectorAll('.slider-dots .dot');
            let currentSlide = 0;

            // Function to show a specific slide
            function showSlide(index) {
                // Remove active class from all slides and dots
                slides.forEach(slide => slide.classList.remove('active'));
                dots.forEach(dot => dot.classList.remove('active'));

                // Add active class to current slide and dot
                slides[index].classList.add('active');
                dots[index].classList.add('active');
            }

            // Function to go to next slide
            function nextSlide() {
                currentSlide = (currentSlide + 1) % slides.length;
                showSlide(currentSlide);
            }

            // Auto-advance slides every 3 seconds
            setInterval(nextSlide, 3000);

            // Add click event to dots for manual navigation
            dots.forEach((dot, index) => {
                dot.addEventListener('click', () => {
                    currentSlide = index;
                    showSlide(currentSlide);
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- Menu Header -->
    <section class="menu-header py-5 mt-5">
        <div class="container">
            <div class="row text-center">
                <div class="col-12">
                    <h1 class="display-4 fw-bold text-dark mb-3 section-title">Our Menu</h1>
                    <p class="lead text-muted">Discover our delicious selection of dishes</p>
                </div>
            </div>
        </div>
    </section>

    

            <!-- Search and Filter Section -->
            <div class="row mb-4">
                <div class="col-lg-6 col-md-8 mx-auto mb-3">
                    <div class="search-container">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="menuSearch" class="form-control search-input" placeholder="Search for dishes..." onkeyup="searchMenuItems()">
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="row g-4">
                    <center>
                        <asp:DataList ID="dtlsmenu" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="3" CellPadding="10" CssClass="menu-table" OnSelectedIndexChanged="dtlsmenu_SelectedIndexChanged" OnItemCommand="dtlsmenu_ItemCommand">
                            <ItemTemplate>
                                <table class="menu-item-table">
                                    <tr>
                                        <td>
                                            <div class="card h-100 menu-card shadow-sm">
                                                <asp:Image ID="Image1" runat="server" CssClass="card-img-top"
                                                    ImageUrl='<%# Eval("Image") %>' Height="200px" Width="100%" />

                                                <div class="card-body text-center">
                                                    <h5 class="card-title fw-bold">
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                    </h5>
                                                    <p class="card-text text-muted">
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                    </p>
                                                    <p class="fw-bold text-warning">
                                                        ₹<asp:Label ID="Label3" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                                                    </p>

                                                    <div class="d-flex justify-content-center gap-2">
                                                        <asp:ImageButton ID="addbtn"
                                                            ImageUrl="~/assets/images/Add_to_cart_btn.png" runat="server" CommandName="cmd_view"
                                                            AlternateText="Add To Cart" Height="70px" Width="160px" CssClass="img-btn" />

                                                        <asp:ImageButton ID="viewbtn"
                                                            ImageUrl="~/assets/images/View_details_btn.png"
                                                            runat="server"
                                                            AlternateText="View Detail"
                                                            Height="70px" Width="160px"
                                                            PostBackUrl='<%# "MenuDetails.aspx?id=" + Eval("Id") %>' />
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </center>
                    
                    <!-- No Items Message -->
                    <asp:Panel ID="pnlNoItems" runat="server" CssClass="text-center py-5" Visible="false">
                        <i class="bi bi-inbox display-1 text-muted"></i>
                        <h4 class="text-muted mt-3">No menu items found</h4>
                        <p class="text-muted">Please try selecting a different category</p>
                    </asp:Panel>

                    <!-- Prev & Next buttons aligned -->
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <asp:ImageButton ID="prebtn" ImageUrl="~/assets/images/Previus_btn.png" runat="server" AlternateText="Previous" Height="70px" Width="100px" OnClick="prebtn_Click1" />
                        <asp:ImageButton ID="nextbtn" ImageUrl="~/assets/images/Next_btn.png" runat="server" AlternateText="Next" Height="70px" Width="100px" OnClick="nextbtn_Click1" />
                    </div>
                </div>
            </div>
        </div>
    </section>
      
    <script>
        function setActiveCategory(btn) {
            // Remove active class from all category buttons
            document.querySelectorAll('.category-btn').forEach(function (element) {
                element.classList.remove('active');
                element.classList.remove('btn-warning');
                element.classList.add('btn-outline-warning');
            });

            // Add active class to clicked button
            btn.classList.add('active');
            btn.classList.add('btn-warning');
            btn.classList.remove('btn-outline-warning');
        }

        // Set active class on page load based on current selection
        document.addEventListener('DOMContentLoaded', function () {
            const urlParams = new URLSearchParams(window.location.search);
            const categoryId = urlParams.get('category');

            if (categoryId) {
                const activeBtn = document.querySelector('[data-category="' + categoryId + '"]');
                if (activeBtn) {
                    setActiveCategory(activeBtn);
                }
            }
        });
    </script>
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
                    <li class="nav-item"><a class="nav-link" href="Home.aspx">Home</a> </li>
                    <li class="nav-item"><a class="nav-link active" href="Menu.aspx">Menu</a> </li>
                    <li class="nav-item"><a class="nav-link" href="About.aspx">About</a> </li>
                    <li class="nav-item"><a class="nav-link" href="Contact.aspx">Contact</a> </li>
                    <li class="nav-item"><a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#cartModal"><i class="bi bi-cart3"></i>Cart <span id="cart-count" class="badge bg-warning text-dark">0</span> </a></li>
                    <li class="nav-item dropdown auth-link login-link"><a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="bi bi-person-circle"></i>Account </a>
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