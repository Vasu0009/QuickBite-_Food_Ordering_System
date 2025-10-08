<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Login" %>

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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to toggle password visibility
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const passwordToggleIcon = document.getElementById('passwordToggleIcon');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                passwordToggleIcon.className = 'bi bi-eye-slash';
            } else {
                passwordInput.type = 'password';
                passwordToggleIcon.className = 'bi bi-eye';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('loginForm');
            const emailField = document.getElementById('email');
            const passwordField = document.getElementById('password');

            // Validation disabled by request

            // Form submission
            form.addEventListener('submit', handleLogin);
        });

        function validateEmail() {
            const email = document.getElementById('email').value.trim();
            const field = document.getElementById('email');

            if (!email) {
                showFieldError('email', 'Email is required');
                return false;
            } else if (!isValidEmail(email)) {
                showFieldError('email', 'Please enter a valid email address');
                return false;
            } else {
                showFieldSuccess('email');
                return true;
            }
        }

        function validatePassword() {
            const password = document.getElementById('password').value;
            const field = document.getElementById('password');

            if (!password) {
                showFieldError('password', 'Password is required');
                return false;
            } else if (password.length < 6) {
                showFieldError('password', 'Password must be at least 6 characters');
                return false;
            } else {
                showFieldSuccess('password');
                return true;
            }
        }

        function handleLogin(event) {
            event.preventDefault();

            const form = event.target;
            const email = form.querySelector('#email').value.trim();
            const password = form.querySelector('#password').value;
            const rememberMe = form.querySelector('#rememberMe').checked;

            // Proceed without validation
            // Show loading state
            showLoadingState(form.querySelector('button[type="submit"]'));

            // Simulate API call
            setTimeout(() => {
                // Check if user exists
                const users = JSON.parse(localStorage.getItem('quickbiteUsers') || '[]');
                const user = users.find(u => u.email === email && u.password === password);

                if (user) {
                    // Login successful
                    const currentUser = {
                        id: user.id,
                        firstName: user.firstName,
                        lastName: user.lastName,
                        email: user.email,
                        phone: user.phone,
                        address: user.address,
                        profileImage: user.profileImage || null,
                        preferences: user.preferences || {},
                        lastLogin: new Date().toISOString()
                    };

                    // Save user session
                    localStorage.setItem('quickbiteCurrentUser', JSON.stringify(currentUser));

                    if (rememberMe) {
                        localStorage.setItem('quickbiteRememberMe', 'true');
                    }

                    // Show success message
                    showAlert('success', 'Login successful! Redirecting to home...');

                    // Redirect after delay
                    setTimeout(() => {
                        window.location.href = 'Home.aspx';
                    }, 1500);

                } else {
                    // Login failed
                    hideLoadingState(form.querySelector('button[type="submit"]'));
                    showAlert('danger', 'Invalid email or password. Please try again.');
                }
            }, 1500);
        }

        function showAlert(type, message) {
            const alertContainer = document.getElementById('alertContainer');
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type} alert-custom alert-dismissible fade show`;
            alertDiv.innerHTML = `
                <i class="bi bi-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-triangle' : 'info-circle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            alertContainer.appendChild(alertDiv);

            // Auto remove after 5 seconds
            setTimeout(() => {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }

        function showFieldError(fieldName, message) {
            const field = document.getElementById(fieldName);
            const errorElement = document.getElementById(fieldName + 'Error');

            if (field && errorElement) {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
                errorElement.textContent = message;
            }
        }

        function showFieldSuccess(fieldName) {
            const field = document.getElementById(fieldName);
            const errorElement = document.getElementById(fieldName + 'Error');

            if (field && errorElement) {
                field.classList.add('is-valid');
                field.classList.remove('is-invalid');
                errorElement.textContent = '';
            }
        }

        function resetFormValidation(form) {
            form.querySelectorAll('.form-control').forEach(field => {
                field.classList.remove('is-invalid', 'is-valid');
            });

            form.querySelectorAll('.invalid-feedback').forEach(error => {
                error.textContent = '';
            });
        }

        function showLoadingState(button) {
            const btnText = button.querySelector('.btn-text');
            const btnLoading = button.querySelector('.btn-loading');

            if (btnText && btnLoading) {
                btnText.style.display = 'none';
                btnLoading.style.display = 'inline-flex';
                button.disabled = true;
            }
        }

        function hideLoadingState(button) {
            const btnText = button.querySelector('.btn-text');
            const btnLoading = button.querySelector('.btn-loading');

            if (btnText && btnLoading) {
                btnText.style.display = 'inline-flex';
                btnLoading.style.display = 'none';
                button.disabled = false;
            }
        }

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>

    <%--<!-- Cart Modal -->
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
                                    Add some delicious items to get started!</p>
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
                </div>--%>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
    <script src="js/auth.js"></script>

    <%--<!-- Cute Login Notification -->
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
    <!-- Login Container -->
    <div class="login-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-7 col-sm-9">
                    <div class="login-card">
                        <div class="login-header">
                            <div class="mb-3">
                                <i class="bi bi-cup-hot-fill" style="font-size: 2.5rem;"></i>
                            </div>
                            <h2>Welcome Back!</h2>
                            <p class="mb-0">Sign in to your QuickBite account</p>
                        </div>

                        <div class="login-body">
                            <div id="alertContainer"></div>

                            <form id="loginForm" novalidate>
                                <div class="form-floating">
                                    <%--<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>--%>
                                    <asp:TextBox ID="txteml" runat="server" class="form-control" placeholder="Email Address"></asp:TextBox>
                                    <label for="email">
                                        <i class="bi bi-envelope me-2"></i>Email Address
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator3" runat="server" ErrorMessage="Email is required" ControlToValidate="txteml" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="regexemail" runat="server" ControlToValidate="txteml" Display="Dynamic" ErrorMessage="Please Enter Valid Email" CssClass="text-danger small" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                    </asp:RegularExpressionValidator>

                                </div>

                                <div class="form-floating position-relative">
                                    <%--                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>--%>
                                    <asp:TextBox ID="txtpwd" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                                    <label for="password">
                                        <i class="bi bi-lock me-2"></i>Password
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtpwd" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="regexPassword" runat="server" ErrorMessage="Password must be at least 8 characters long, contain at least 1 letter and 1 number." ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ControlToValidate="txtpwd" Display="Dynamic" CssClass="text-danger small">
                                    </asp:RegularExpressionValidator>

                                    <!-- Eye button added here -->
                                    <span class="position-absolute top-50 end-0 translate-middle-y me-3" style="cursor: pointer; z-index: 5;" onclick="togglePasswordVisibility()">
                                        <i class="bi bi-eye" id="passwordToggleIcon"></i>
                                    </span>
                                    <div class="invalid-feedback" id="passwordError"></div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="rememberMe">
                                        <label class="form-check-label" for="rememberMe">
                                            Remember me
                                        </label>
                                    </div>
                                    <a href="#" class="forgot-password">Forgot password?</a>
                                </div>

                                <%--<button type="submit" class="btn btn-login w-100 mb-3"> </button>--%>
                                <asp:Button ID="btnlogin" runat="server" Text="Sign In" class="btnlogin btn-login w-100 mb-3" OnClick="btnlogin_Click" />

                                <%-- <span class="btn-text">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                                    </span>
                                    <span class="btn-loading" style="display: none;">
                                        <span class="loading-spinner me-2"></span>Signing in...
                                    </span>--%>
                                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                <asp:Label ID="lblMessage" runat="server" Text="" Style="color: forestgreen; text-align: center"></asp:Label>


                                <div class="text-center">
                                    <p class="mb-0">Don't have an account?</p>
                                    <a href="Register.aspx" class="btn btn-outline-warning mt-2">
                                        <i class="bi bi-person-plus me-2"></i>Create Account
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

