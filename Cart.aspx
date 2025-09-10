<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Cart" %>

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

   <%-- <!-- Cute Login Notification -->
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
    <!-- Cart Header -->
    <section class="py-5" style="margin-top: 72px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
        <div class="container">
            <div class="row text-center">
                <div class="col-12">
                    <h1 class="display-4 fw-bold text-dark mb-3 section-title">
                        <i class="bi bi-cart3 text-warning me-3"></i>Shopping Cart
                    </h1>
                    <p class="lead text-muted">Review your delicious selections and proceed to checkout</p>
                </div>
            </div>
        </div>
    </section>

    <main class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-lg cart-container">
                        <div class="card-header bg-white border-0 py-4">
                            <h5 class="fw-bold mb-0 text-dark">
                                <i class="bi bi-basket3 me-2 text-warning"></i>Your Items
                            </h5>
                        </div>
                        <div class="card-body p-0">
                            <div id="cart-items" class="cart-items-container"></div>
                            <div id="cart-empty" class="text-center py-5 px-4">
                                <div class="empty-cart-icon mb-4">
                                    <i class="bi bi-cart3 text-muted" style="font-size: 4rem; opacity: 0.3;"></i>
                                </div>
                                <h4 class="text-muted mb-3">Your cart is empty</h4>
                                <p class="text-muted mb-4">Looks like you haven't added any delicious items yet!</p>
                                <a href="Menu.aspx" class="btn btn-warning btn-lg px-4">
                                    <i class="bi bi-shop me-2"></i>Browse Menu
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card border-0 shadow-lg order-summary sticky-top" style="top: 96px;">
                        <div class="card-header bg-gradient text-white py-4" style="background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);">
                            <h5 class="fw-bold mb-0 text-dark">
                                <i class="bi bi-receipt me-2"></i>Order Summary
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="order-details">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="text-muted">Subtotal</span>
                                    <span class="fw-bold">₹<span id="cart-total">0</span></span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="text-muted">
                                        <i class="bi bi-truck me-1"></i>Delivery
                                    </span>
                                    <span class="text-success fw-bold">Free</span>
                                </div>
                                <div id="discount-row" class="d-flex justify-content-between align-items-center mb-3 text-success" style="display: none;">
                                    <span>
                                        <i class="bi bi-tag me-1"></i>Discount
                                    </span>
                                    <span class="fw-bold">-₹<span id="cart-discount">0</span></span>
                                </div>
                                <hr class="my-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <span class="h5 fw-bold text-dark">Total</span>
                                    <span class="h4 fw-bold text-warning">₹<span id="cart-grand-total">0</span></span>
                                </div>
                            </div>

                            <div class="promo-section mb-4">
                                <label class="form-label fw-bold text-dark">Promo Code</label>
                                <div class="input-group">
                                    <input type="text" id="promo-code" class="form-control" placeholder="Enter promo code">
                                    <button class="btn btn-outline-warning" type="button" onclick="applyPromoCode()">
                                        <i class="bi bi-check-lg"></i>
                                    </button>
                                </div>
                                <small class="text-muted">Try "QUICK10" for 10% off</small>
                            </div>

                            <div class="d-grid gap-3">
                                <button type="button" class="btn btn-warning btn-lg py-3 fw-bold" onclick="checkout()" id="checkout-btn">
                                    <i class="bi bi-credit-card me-2"></i>Proceed to Checkout
                                </button>
                                <a href="Menu.aspx" class="btn btn-outline-secondary py-2">
                                    <i class="bi bi-arrow-left me-2"></i>Continue Shopping
                                </a>
                            </div>

                            <div class="security-badges mt-4 text-center">
                                <small class="text-muted d-block mb-2">Secure Checkout</small>
                                <div class="d-flex justify-content-center gap-3">
                                    <i class="bi bi-shield-check text-success" title="Secure Payment"></i>
                                    <i class="bi bi-truck text-primary" title="Fast Delivery"></i>
                                    <i class="bi bi-arrow-clockwise text-info" title="Easy Returns"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

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

