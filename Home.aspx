<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Home" %>

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

    <%--      <!-- Cute Login Notification -->
                <div id="cuteLoginNotification" class="cute-notification" style="display: none;">
                    <div class="notification-content">
                        <div class="notification-icon">
                            <i class="bi bi-heart-fill"></i>
                        </div>
                        <div class="notification-text">
                            <h6 class="notification-title">Hey there! 👋</h6>
                            <p class="notification-message">
                                Please login first to add items to your cart and enjoy a personalized shopping experience!</p>
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
    <!-- Hero Section with Background Slider -->
    <section class="hero-section">
        <!-- Background Image Slider -->
        <div class="hero-slider">
            <div class="slide active" style="background-image: url('assets/images/hero1.jpg')"></div>
            <div class="slide" style="background-image: url('assets/images/hero2.jpg')"></div>
            <div class="slide" style="background-image: url('assets/images/hero3.jpg')"></div>
            <div class="slide" style="background-image: url('assets/images/hero4.jpg')"></div>
            <div class="slide" style="background-image: url('assets/images/hero5.jpg')"></div>
        </div>

        <!-- Slider Navigation Dots -->
        <div class="slider-dots">
            <span class="dot active" data-slide="0"></span>
            <span class="dot" data-slide="1"></span>
            <span class="dot" data-slide="2"></span>
            <span class="dot" data-slide="3"></span>
            <span class="dot" data-slide="4"></span>
        </div>

        <div class="hero-overlay">
            <div class="container">
                <div class="row min-vh-100 align-items-center">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold text-white mb-4 hero-title">Delicious Meals Delivered To You</h1>
                        <p class="lead text-white mb-4">Experience the finest cuisine delivered right to your doorstep. Fresh ingredients, authentic flavors, and exceptional service.</p>
                        <a href="Menu.aspx" class="btn btn-warning btn-lg px-4 py-2 fw-bold btn-cta">Order Now</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="display-5 fw-bold text-dark section-title">Why Choose QuickBite?</h2>
                    <p class="lead text-muted">We're committed to providing the best dining experience</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="bi bi-phone-fill text-warning"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Easy Ordering</h4>
                        <p class="text-muted">Order your favorite meals with just a few clicks. Our interface makes ordering simple and convenient.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="bi bi-truck text-success"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Fast Delivery</h4>
                        <p class="text-muted">Get your food delivered within 30 minutes. We ensure your meals arrive hot and fresh every time.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card text-center p-4">
                        <div class="feature-icon mb-3">
                            <i class="bi bi-star-fill text-warning"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Top Quality Food</h4>
                        <p class="text-muted">We use only the finest ingredients and follow strict quality standards to deliver exceptional taste.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Dishes Preview -->
    <section class="py-5">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-12">
                    <h2 class="display-5 fw-bold text-dark section-title">Popular Dishes</h2>
                    <p class="lead text-muted">Discover our most loved menu items</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card dish-card h-100">
                        <img src="assets/images/food1.jpg" class="card-img-top" alt="Chinese Noodles">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Chinese Noodles</h5>
                            <p class="card-text text-muted">Stir-fried noodles with fresh vegetables and savory sauce</p>
                            <p class="fw-bold text-warning">₹299</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Chinese Noodles', 299, 'assets/images/food1.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dish-card h-100">
                        <img src="assets/images/food2.jpg" class="card-img-top" alt="Biryani">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Indian Pakoras</h5>
                            <p class="card-text text-muted">Crispy fritters made with vegetables and gram flour</p>
                            <p class="fw-bold text-warning">₹399</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Indian Pakoras', 399, 'assets/images/food2.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card dish-card h-100">
                        <img src="assets/images/food3.jpg" class="card-img-top" alt="Paneer Tikka">
                        <div class="card-body text-center">
                            <h5 class="card-title fw-bold">Paneer Tikka</h5>
                            <p class="card-text text-muted">Grilled cottage cheese with spices</p>
                            <p class="fw-bold text-warning">₹199</p>
                            <button class="btn btn-outline-warning" onclick="addToCart('Paneer Tikka', 199, 'assets/images/food3.jpg')">
                                Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <a href="Menu.aspx" class="btn btn-warning btn-lg">View Full Menu</a>
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

