<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder3">
    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="mb-4">QuickBite </h5>
                    <p class="mb-3">
                        Delivering premium culinary experiences to your doorstep with passion, quality, and speed.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook fs-5"></i></a><a href="#" class="text-white"><i class="bi bi-twitter fs-5"></i></a><a href="#" class="text-white"><i class="bi bi-instagram fs-5"></i></a><a href="#" class="text-white"><i class="bi bi-linkedin fs-5"></i></a>
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
                        <li class="mb-2"><i class="bi bi-geo-alt me-2"></i>Sardhar - Rajkot 360025, Gujarat, India </li>
                        <li class="mb-2"><i class="bi bi-telephone me-2"></i>+91 99999 55555 </li>
                        <li class="mb-2"><i class="bi bi-envelope me-2"></i>info@quickbite.com.in </li>
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

<%--    <!-- Cute Login Notification -->
    <div id="cuteLoginNotification" class="cute-notification" style="display: none;">
        <div class="notification-content">
            <div class="notification-icon">
                <i class="bi bi-heart-fill"></i>
            </div>
            <div class="notification-text">
                <h6 class="notification-title">Hey there! 👋</h6>
                <p class="notification-message">
                    Please login first to add items to your cart and enjoy a personalized shopping experience!
                </p>
            </div>
            <div class="notification-actions">
                <a href="Login.aspx" class="btn btn-cute-login"><i class="bi bi-box-arrow-in-right me-2"></i>Login Now </a>
                <button class="btn btn-cute-close" onclick="hideCuteNotification()">
                    <i class="bi bi-x-lg"></i>
                </button>
            </div>
        </div>
        <div class="notification-progress">
        </div>
    </div>--%>
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

    <!-- Menu Categories -->
    <section class="py-5">
        <div class="container">
            <!-- Search and Filter Section -->
            <!-- Search and Filter Section -->
            <div class="row mb-4">
                <div class="col-lg-6 col-md-8 mx-auto mb-3">
                    <div class="search-container">
                        <i class="bi bi-search search-icon"></i>
                        <input type="text" id="menuSearch" class="form-control search-input" placeholder="Search for dishes..." onkeyup="searchMenuItems()">
                    </div>
                </div>
            </div>
            <!-- Category Filter -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="d-flex justify-content-center flex-wrap">
                        <button class="btn btn-outline-warning me-2 mb-2 category-filter active" data-category="all">All</button>
                        <button class="btn btn-outline-warning me-2 mb-2 category-filter" data-category="starters">Starters</button>
                        <button class="btn btn-outline-warning me-2 mb-2 category-filter" data-category="main-course">Main Course</button>
                        <button class="btn btn-outline-warning me-2 mb-2 category-filter" data-category="desserts">Desserts</button>
                        <button class="btn btn-outline-warning me-2 mb-2 category-filter" data-category="beverages">Beverages</button>
                    </div>
                </div>
            </div>

            <!-- Menu Items -->
            <div class="row g-4" id="menu-items">
                <!-- Starters -->
                <div class="col-lg-4 col-md-6 menu-item" data-category="starters">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/1.jpg" class="card-img-top" alt="Paneer Tikka">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Paneer Tikka</h5>
                            <p class="card-text text-muted">Grilled cottage cheese with aromatic spices</p>
                            <p class="fw-bold text-warning">₹199</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Paneer Tikka', 199, 'assets/images/1.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="starters">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/2.jpg" class="card-img-top" alt="Aloo Tikki">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Aloo Tikki</h5>
                            <p class="card-text text-muted">Spiced potato patties with chutney</p>
                            <p class="fw-bold text-warning">₹149</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Aloo Tikki', 149, 'assets/images/2.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="starters">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/3.jpg" class="card-img-top" alt="Veg Spring Roll">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Veg Spring Roll</h5>
                            <p class="card-text text-muted">Crispy rolls with fresh vegetables</p>
                            <p class="fw-bold text-warning">₹149</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Veg Spring Roll', 149, 'assets/images/3.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="starters">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/4.jpg" class="card-img-top" alt="Mushroom Manchurian">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Mushroom Manchurian</h5>
                            <p class="card-text text-muted">Crispy mushrooms in spicy sauce</p>
                            <p class="fw-bold text-warning">₹179</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Mushroom Manchurian', 179, 'assets/images/4.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Main Course -->
                <div class="col-lg-4 col-md-6 menu-item" data-category="main-course">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/5.jpg" class="card-img-top" alt="Dal Makhani">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Dal Makhani</h5>
                            <p class="card-text text-muted">Creamy black lentils with spices</p>
                            <p class="fw-bold text-warning">₹199</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Dal Makhani', 199, 'assets/images/5.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="main-course">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/6.jpg" class="card-img-top" alt="Veg Biryani">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Veg Biryani</h5>
                            <p class="card-text text-muted">Aromatic rice with fresh vegetables</p>
                            <p class="fw-bold text-warning">₹299</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Veg Biryani', 299, 'assets/images/6.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="main-course">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/7.jpg" class="card-img-top" alt="Paneer Butter Masala">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Paneer Butter Masala</h5>
                            <p class="card-text text-muted">Cottage cheese in rich tomato gravy</p>
                            <p class="fw-bold text-warning">₹249</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Paneer Butter Masala', 249, 'assets/images/7.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="main-course">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/8.jpg" class="card-img-top" alt="Chana Masala">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Chana Masala</h5>
                            <p class="card-text text-muted">Spiced chickpeas in aromatic gravy</p>
                            <p class="fw-bold text-warning">₹179</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Chana Masala', 179, 'assets/images/8.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="main-course">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/9.jpg" class="card-img-top" alt="Aloo Gobi">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Aloo Gobi</h5>
                            <p class="card-text text-muted">Potato and cauliflower curry</p>
                            <p class="fw-bold text-warning">₹159</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Aloo Gobi', 159, 'assets/images/9.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Desserts -->
                <div class="col-lg-4 col-md-6 menu-item" data-category="desserts">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/10.jpg" class="card-img-top" alt="Gulab Jamun">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Gulab Jamun</h5>
                            <p class="card-text text-muted">Sweet milk dumplings in sugar syrup</p>
                            <p class="fw-bold text-warning">₹99</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Gulab Jamun', 99, 'assets/images/10.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="desserts">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/11.jpg" class="card-img-top" alt="Rasmalai">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Rasmalai</h5>
                            <p class="card-text text-muted">Soft cottage cheese patties in sweet milk</p>
                            <p class="fw-bold text-warning">₹129</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Rasmalai', 129, 'assets/images/11.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="desserts">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/12.jpg" class="card-img-top" alt="Kulfi">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Kulfi</h5>
                            <p class="card-text text-muted">Traditional Indian ice cream</p>
                            <p class="fw-bold text-warning">₹79</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Kulfi', 79, 'assets/images/12.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Beverages -->
                <div class="col-lg-4 col-md-6 menu-item" data-category="beverages">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/13.jpg" class="card-img-top" alt="Masala Chai">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Masala Chai</h5>
                            <p class="card-text text-muted">Spiced Indian tea with milk</p>
                            <p class="fw-bold text-warning">₹49</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Masala Chai', 49, 'assets/images/13.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="beverages">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/14.jpg" class="card-img-top" alt="Sweet Lassi">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Sweet Lassi</h5>
                            <p class="card-text text-muted">Refreshing yogurt-based drink</p>
                            <p class="fw-bold text-warning">₹69</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Sweet Lassi', 69, 'assets/images/14.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 menu-item" data-category="beverages">
                    <div class="card h-100 menu-card">
                        <img src="assets/images/15.jpg" class="card-img-top" alt="Fresh Juice">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Fresh Juice</h5>
                            <p class="card-text text-muted">Seasonal fruit juice</p>
                            <p class="fw-bold text-warning">₹89</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Fresh Juice', 89, 'assets/images/15.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

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
                    <li class="nav-item"><a class="nav-link active" href="Home.aspx">Home</a> </li>
                    <li class="nav-item"><a class="nav-link" href="Menu.aspx">Menu</a> </li>
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

