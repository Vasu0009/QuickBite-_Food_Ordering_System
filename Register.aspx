<%@ Page Title="" Language="C#" MasterPageFile="~/QuickBite.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Register" %>

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
        function togglePasswordVisibility(inputId, iconId) {
            const passwordInput = document.getElementById(inputId);
            const passwordToggleIcon = document.getElementById(iconId);

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                passwordToggleIcon.className = 'bi bi-eye-slash';
            } else {
                passwordInput.type = 'password';
                passwordToggleIcon.className = 'bi bi-eye';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            const form = document.getElementById('registerForm');

            // Form submission
            form.addEventListener('submit', handleRegister);

            // Password strength indicator
            const passwordField = document.getElementById('password');
            if (passwordField) {
                passwordField.addEventListener('input', validatePassword);
            }
        });

        function handleRegister(event) {
            event.preventDefault();

            const form = event.target;
            const formData = new FormData(form);

            // Reset validation
            resetFormValidation(form);

            // Show loading state
            showLoadingState(form.querySelector('button[type="submit"]'));

            // Create user object
            const newUser = {
                id: Date.now().toString(),
                firstName: (formData.get('firstName') || '').trim(),
                lastName: (formData.get('lastName') || '').trim(),
                email: (formData.get('email') || '').trim(),
                phone: (formData.get('phone') || '').trim(),
                address: (formData.get('address') || '').trim(),
                password: formData.get('password'),
                preferences: {
                    marketing: formData.get('marketing') === 'on'
                },
                createdAt: new Date().toISOString()
            };

            // Save to localStorage
            const users = JSON.parse(localStorage.getItem('quickbiteUsers') || '[]');
            users.push(newUser);
            localStorage.setItem('quickbiteUsers', JSON.stringify(users));

            // Auto login the user
            const currentUser = {
                id: newUser.id,
                firstName: newUser.firstName,
                lastName: newUser.lastName,
                email: newUser.email,
                phone: newUser.phone,
                address: newUser.address,
                preferences: newUser.preferences,
                lastLogin: new Date().toISOString()
            };

            localStorage.setItem('quickbiteCurrentUser', JSON.stringify(currentUser));

            // Show success message
            showAlert('success', 'Account created successfully! Redirecting to home...');

            // Redirect after delay
            setTimeout(() => {
                window.location.href = 'Home.aspx';
            }, 2000);
        }

        function validatePassword() {
            const password = document.getElementById('password').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');

            if (!password) {
                strengthBar.className = 'strength-fill';
                strengthText.textContent = 'Password strength will appear here';
                strengthText.className = 'text-muted';
                return;
            }

            let strength = 0;
            let feedback = [];

            // Length check
            if (password.length >= 8) strength++;
            else feedback.push('at least 8 characters');

            // Lowercase check
            if (/[a-z]/.test(password)) strength++;
            else feedback.push('lowercase letter');

            // Uppercase check
            if (/[A-Z]/.test(password)) strength++;
            else feedback.push('uppercase letter');

            // Number check
            if (/\d/.test(password)) strength++;
            else feedback.push('number');

            // Special character check
            if (/[!@#$%^&*(),.?":{}|<>]/.test(password)) strength++;
            else feedback.push('special character');

            // Update strength bar
            if (strength <= 2) {
                strengthBar.className = 'strength-fill strength-weak';
                strengthText.textContent = 'Weak password';
                strengthText.className = 'text-danger';
            } else if (strength === 3) {
                strengthBar.className = 'strength-fill strength-fair';
                strengthText.textContent = 'Fair password';
                strengthText.className = 'text-warning';
            } else if (strength === 4) {
                strengthBar.className = 'strength-fill strength-good';
                strengthText.textContent = 'Good password';
                strengthText.className = 'text-info';
            } else {
                strengthBar.className = 'strength-fill strength-strong';
                strengthText.textContent = 'Strong password';
                strengthText.className = 'text-success';
            }
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

            setTimeout(() => {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 5000);
        }

        function resetFormValidation(form) {
            form.querySelectorAll('.form-control, .form-check-input').forEach(field => {
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
    </script>

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

  <%--  <!-- Cute Login Notification -->
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
    <!-- Register Container -->
    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10 col-sm-12">
                    <div class="register-card">
                        <div class="register-header">
                            <div class="mb-3">
                                <i class="bi bi-cup-hot-fill" style="font-size: 2.5rem;"></i>
                            </div>
                            <h2>Create Account</h2>
                            <p class="mb-0">Join QuickBite and start ordering delicious meals</p>
                        </div>

                        <div class="register-body">
                            <div id="alertContainer"></div>

                            <form id="registerForm" novalidate>
                                <!-- Name Fields -->
                                <div class="form-row">
                                    <div class="form-floating">
                                        <%--<input type="text" class="form-control" id="firstName" name="firstName"
                                            placeholder="First Name" required>
                                        <label for="firstName">
                                            <i class="bi bi-person me-2"></i>First Name
                                        </label>--%>
                                        <asp:TextBox ID="txtfnm" runat="server" class="form-control" placeholder="First Name"></asp:TextBox>
                                        <label for="txtfnm"><i class="bi bi-person me-2"></i>First Name</label>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator1" runat="server" ErrorMessage="First Name is required" ControlToValidate="txtfnm" CssClass="text-danger small" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </div>

                                    <div class="form-floating">
                                        <%--<input type="text" class="form-control" id="lastName" name="lastName"
                                            placeholder="Last Name" required>
                                        <label for="lastName">
                                            <i class="bi bi-person me-2"></i>Last Name
                                        </label>--%>
                                        <asp:TextBox ID="txtlnm" runat="server" class="form-control" placeholder="Last Name"></asp:TextBox>
                                        <label for="txtlnm"><i class="bi bi-person me-2"></i>Last Name</label>
                                        <asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator2" runat="server" ErrorMessage="Last Name is required" ControlToValidate="txtlnm" CssClass="text-danger small" Display="Dynamic">
                                        </asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <!-- Email Field -->
                                <div class="form-floating">
                                    <%-- <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                        required>--%>

                                    <asp:TextBox ID="txteml" runat="server" class="form-control" placeholder="Email Address"></asp:TextBox>
                                    <label for="eml">
                                        <i class="bi bi-envelope me-2"></i>Email Address
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator3" runat="server" ErrorMessage="Email is required" ControlToValidate="txteml" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="regexemail" runat="server" ControlToValidate="txteml" Display="Dynamic" ErrorMessage="Please Enter Valid Email" CssClass="text-danger small" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                    </asp:RegularExpressionValidator>

                                </div>

                                <!-- Phone Field -->
                                <div class="form-floating">
                                    <%-- <input type="tel" class="form-control" id="phone" name="phone" placeholder="Phone"
                                        required>--%>

                                    <asp:TextBox ID="txtphone" runat="server" class="form-control" placeholder="First Name"></asp:TextBox>
                                    <label for="txtphone">
                                        <i class="bi bi-telephone me-2"></i>Phone Number
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="rfvPhoneNumber" runat="server" ErrorMessage="Phone Number is required" ControlToValidate="txtphone" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>

                                    <asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtphone" ErrorMessage="Please enter a valid 10-digit phone number" ValidationExpression="^\d{10}$" Display="Dynamic" CssClass="text-danger small">
                                    </asp:RegularExpressionValidator>
                                </div>

                                <!-- Address Field -->
                                <div class="form-floating">
                                    <%-- <textarea class="form-control" id="address" name="address" placeholder="Address"
                                        style="height: 100px" required></textarea>--%>
                                    <asp:TextBox ID="txtadd" runat="server" class="form-control" placeholder="Address" Style="height: 100px"></asp:TextBox>
                                    <label for="address">
                                        <i class="bi bi-geo-alt me-2"></i>Address
                                    </label>

                                </div>

                                <!-- Password Row -->
                                <div style="display: flex; gap: 30px; margin-bottom: 30px;">
                                    <!-- Password Field -->
                                    <div style="flex: 1;">
                                        <label for="password"
                                            style="display: block; margin-bottom: 10px; font-weight: 500; color: #333; font-size: 16px;">
                                        </label>
                                        <div style="display: flex; gap: 10px; align-items: center;">
                                            <div style="position: relative; flex: 1;">
                                                <%--<input type="password" class="form-control" id="password" name="password" placeholder="Password" required style="width: 100%; padding: 12px 15px 12px 40px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; box-sizing: border-box; background-color: #fff;"
                                                    required placeholder="Password" class="form-control"
                                                    aria-label="Password" aria-required="true"
                                                    aria-describedby="passwordError" aria-invalid="false">--%>
                                                <asp:TextBox ID="txtpwd" runat="server" class="form-control" placeholder="Password" Style="width: 100%; padding: 12px 15px 12px 40px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; box-sizing: border-box; background-color: #fff;"></asp:TextBox>
                                                <i class="bi bi-lock"
                                                    style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #999; font-size: 16px;"></i>

                                                <asp:RequiredFieldValidator
                                                    ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtpwd" CssClass="text-danger small" Display="Dynamic">
                                                </asp:RequiredFieldValidator>

                                                <asp:RegularExpressionValidator
                                                    ID="regexPassword" runat="server" ErrorMessage="Password must be at least 8 characters long, contain at least 1 letter and 1 number." ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ControlToValidate="txtpwd" Display="Dynamic" CssClass="text-danger small">
                                                </asp:RegularExpressionValidator>

                                            </div>
                                            <button type="button"
                                                onclick="togglePasswordVisibility('password', 'passwordToggleIcon')"
                                                style="padding: 12px 14px; border: 1px solid #ddd; border-radius: 6px; background-color: #fff; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 44px;">
                                                <i class="bi bi-eye" id="passwordToggleIcon"
                                                    style="font-size: 16px; color: #666;"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <!-- Confirm Password Field -->
                                    <div style="flex: 1;">
                                        <label for="confirmPassword"
                                            style="display: block; margin-bottom: 10px; font-weight: 500; color: #333; font-size: 16px;">
                                        </label>
                                        <div style="display: flex; gap: 10px; align-items: center;">
                                            <div style="position: relative; flex: 1;">
                                                <%--<input type="password" id="confirmPassword" name="confirmPassword"
                                                    style="width: 100%; padding: 12px 15px 12px 40px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; box-sizing: border-box; background-color: #fff;"
                                                    required placeholder="Confirm Password" class="form-control"
                                                    aria-label="Confirm Password" aria-required="true"
                                                    aria-describedby="confirmPasswordError" aria-invalid="false">--%>
                                                <asp:TextBox ID="txtcfpwd" runat="server" class="form-control" Style="width: 100%; padding: 12px 15px 12px 40px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; box-sizing: border-box; background-color: #fff;"></asp:TextBox>
                                                <asp:CompareValidator
                                                    ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match" ControlToValidate="txtcfpwd" ControlToCompare="txtpwd" CssClass="text-danger small" Display="Dynamic">
                                                </asp:CompareValidator>
                                                <i class="bi bi-lock"
                                                    style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #999; font-size: 16px;"></i>
                                            </div>
                                            <button type="button"
                                                onclick="togglePasswordVisibility('confirmPassword', 'confirmPasswordToggleIcon')"
                                                style="padding: 12px 14px; border: 1px solid #ddd; border-radius: 6px; background-color: #fff; cursor: pointer; display: flex; align-items: center; justify-content: center; min-width: 44px;">
                                                <i class="bi bi-eye" id="confirmPasswordToggleIcon"
                                                    style="font-size: 16px; color: #666;"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Terms and Conditions -->
                                <div class="form-check mb-3">
                                    <input class="form-check-input" type="checkbox" id="terms" name="terms" required>
                                    <label class="form-check-label" for="terms">
                                        I agree to the <a href="#" class="terms-link">Terms of Service</a> and <a
                                            href="#" class="terms-link">Privacy Policy</a>
                                    </label>
                                    <div class="invalid-feedback" id="termsError"></div>
                                </div>

                                <!-- Marketing Consent -->
                                <div class="form-check mb-4">
                                    <input class="form-check-input" type="checkbox" id="marketing" name="marketing">
                                    <label class="form-check-label" for="marketing">
                                        I would like to receive promotional emails and special offers
                                    </label>
                                </div>

                                <%--<button type="submit" class="btn btn-register w-100 mb-3">
                                    <span class="btn-text">
                                        <i class="bi bi-person-plus me-2"></i>Create Account
                                    </span>
                                    <span class="btn-loading" style="display: none;">
                                        <span class="loading-spinner me-2"></span>Creating account...
                                    </span>
                                </button>--%>
                                <asp:Label ID="lblMessage" runat="server" Style="color: forestgreen; text-align: center"></asp:Label>
                                <asp:Button ID="btnregister" runat="server" class="btnregister btn-register w-100 mb-3" Text="Create Account" OnClick="btnregister_Click" />

                                <div class="text-center">
                                    <p class="mb-0">Already have an account?</p>
                                    <a href="Login.aspx" class="btn btn-outline-warning mt-2">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
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
