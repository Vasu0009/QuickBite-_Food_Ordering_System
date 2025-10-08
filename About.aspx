<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="QuickBite__Food_Ordering_System.About" %>

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

    <%--  <!-- Cart Modal -->
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
    </div>--%>

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
    <!-- About Header -->
    <section class="about-header py-5 mt-5">
        <div class="container">
            <div class="row text-center">
                <div class="col-12">
                    <h1 class="display-4 fw-bold text-dark mb-3 section-title">About QuickBite</h1>
                    <p class="lead text-muted">Delivering happiness, one meal at a time</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Company Information -->
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-4">
                    <img src="assets/images/restaurant.jpg" class="img-fluid rounded" alt="QuickBite Restaurant">
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bold mb-4">Our Story</h2>
                    <p class="lead mb-4">We provide fast, fresh, and affordable food delivered to your door.</p>
                    <p class="mb-4">Founded with a passion for authentic Indian cuisine, QuickBite has been serving the community of Sardhar and Rajkot since 2020. Our journey began with a simple mission: to bring the authentic flavors of India to your doorstep.</p>
                    <p class="mb-4">We believe that great food has the power to bring people together. That's why we use only the finest ingredients, sourced locally whenever possible, and prepare each dish with love and care.</p>
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill text-success me-2"></i>
                                <span>Fresh Ingredients</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill text-success me-2"></i>
                                <span>Fast Delivery</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill text-success me-2"></i>
                                <span>Quality Assured</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-check-circle-fill text-success me-2"></i>
                                <span>24/7 Support</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Values Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="display-5 fw-bold text-dark">Our Values</h2>
                    <p class="lead text-muted">What drives us every day</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="value-icon mb-3">
                            <i class="bi bi-heart-fill text-danger"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Passion for Food</h4>
                        <p class="text-muted">We cook with love and passion, ensuring every dish tells a story of tradition and taste.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="value-icon mb-3">
                            <i class="bi bi-shield-check text-success"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Quality First</h4>
                        <p class="text-muted">We never compromise on quality. Every ingredient is carefully selected and every dish is prepared with attention to detail.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="value-icon mb-3">
                            <i class="bi bi-people-fill text-primary"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Customer First</h4>
                        <p class="text-muted">Your satisfaction is our priority. We go above and beyond to ensure you have the best dining experience.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Location Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <h2 class="fw-bold mb-4">Visit Us</h2>
                    <div class="address-card p-4 bg-light rounded">
                        <h5 class="fw-bold mb-3">
                            <i class="bi bi-geo-alt-fill text-warning me-2"></i>Our Location
                        </h5>
                        <p class="mb-3">
                            <strong>Address:</strong><br>
                            Sardhar - Rajkot 360025<br>
                            Gujarat, India
                        </p>
                        <p class="mb-3">
                            <strong>Phone:</strong><br>
                            +91 98765 43210
                        </p>
                        <p class="mb-3">
                            <strong>Email:</strong><br>
                            info@quickbite.com
                        </p>
                        <p class="mb-0">
                            <strong>Hours:</strong><br>
                            Monday - Sunday: 11:00 AM - 11:00 PM
                        </p>
                    </div>
                </div>
                <div class="col-lg-6">
                    <h2 class="fw-bold mb-4">Find Us on Map</h2>
                    <div class="map-container">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3691.6767890123456!2d70.12345678901234!3d22.12345678901234!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMjLCsDA3JzM0LjQiTiA3MMKwMDcnMzQuNCJF!5e0!3m2!1sen!2sin!4v1234567890123"
                            width="100%"
                            height="300"
                            style="border: 0;"
                            allowfullscreen=""
                            loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="display-5 fw-bold text-dark">Meet Our Team</h2>
                    <p class="lead text-muted">The people behind QuickBite's success</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center">
                        <img src="assets/images/chef1.jpg" class="rounded-circle mb-3" alt="Head Chef" style="width: 80px; height: 80px; object-fit: cover;">
                        <h5 class="fw-bold">Rutu Zalavadiya</h5>
                        <p class="text-muted">Head Chef</p>
                        <p class="small">With over 5 years of experience in Indian cuisine, Chef Rutu brings authentic flavors to every dish.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <img src="assets/images/chef2.png" class="rounded-circle mb-3" alt="Sous Chef" style="width: 80px; height: 80px; object-fit: cover;">
                        <h5 class="fw-bold">Chef Priya</h5>
                        <p class="text-muted">Sous Chef</p>
                        <p class="small">Specializing in vegetarian dishes, Chef Priya ensures our vegetarian menu is as delicious as our non-vegetarian options.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <img src="assets/images/manager.jpeg" class="rounded-circle mb-3" alt="Restaurant Manager" style="width: 80px; height: 80px; object-fit: cover;">
                        <h5 class="fw-bold">Vasu Padariya</h5>
                        <p class="text-muted">Restaurant Manager</p>
                        <p class="small">Ensuring smooth operations and excellent customer service, Vasu makes sure every order is perfect.</p>
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
                    <li class="nav-item"><a class="nav-link" href="Cart.aspx">Cart</a> </li>
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

