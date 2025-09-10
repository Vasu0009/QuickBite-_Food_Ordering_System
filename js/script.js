// QuickBite Food Ordering Website JavaScript

// Global Variables
let cart = [];
let cartTotal = 0;
let discountPercent = 0;

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    initializeCart();
    setupEventListeners();
    loadCartFromStorage();
    updateCartDisplay();
    handleNavbarScroll();
    
    // Initialize auth if auth.js is loaded
    if (typeof checkAuthStatus === 'function') {
        checkAuthStatus();
        updateNavigation();
    }
});

// Check authentication status
function isUserLoggedIn() {
    console.log('Checking authentication status...');
    
    // Check if auth variables are available
    if (typeof isLoggedIn !== 'undefined' && typeof currentUser !== 'undefined') {
        console.log('Auth variables found - isLoggedIn:', isLoggedIn, 'currentUser:', currentUser);
        return isLoggedIn && currentUser;
    }
    
    // Fallback: check localStorage directly
    const user = localStorage.getItem('quickbiteUser');
    console.log('Checking localStorage for user:', user);
    
    if (user) {
        try {
            const userData = JSON.parse(user);
            console.log('User data from localStorage:', userData);
            return userData && userData.email;
        } catch (e) {
            console.error('Error parsing user data:', e);
            return false;
        }
    }
    
    return false;
}

// Initialize cart functionality
function initializeCart() {
    // Load cart from localStorage if available
    const savedCart = localStorage.getItem('quickbiteCart');
    if (savedCart) {
        cart = JSON.parse(savedCart);
        calculateCartTotal();
    }
}

// Setup event listeners
function setupEventListeners() {
    // Contact form submission
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', handleContactForm);
    }

    // Menu category filters
    const categoryFilters = document.querySelectorAll('.category-filter');
    categoryFilters.forEach(filter => {
        filter.addEventListener('click', filterMenuItems);
    });

    // Cart modal events
    const cartModal = document.getElementById('cartModal');
    if (cartModal) {
        cartModal.addEventListener('show.bs.modal', updateCartDisplay);
    }
}

// Add item to cart
function addToCart(name, price, image) {
    // Check if user is logged in before adding to cart
    if (!isUserLoggedIn()) {
        console.log('User not logged in, showing cute notification for add to cart');
        showCuteLoginNotification('cart');
        return;
    }
    
    const existingItem = cart.find(item => item.name === name);
    
    if (existingItem) {
        existingItem.quantity += 1;
    } else {
        cart.push({
            name: name,
            price: price,
            image: image,
            quantity: 1
        });
    }
    
    calculateCartTotal();
    saveCartToStorage();
    updateCartDisplay();
    showAddToCartSuccess(name);
}

// Calculate cart total
function calculateCartTotal() {
    cartTotal = cart.reduce((total, item) => total + (item.price * item.quantity), 0);
}

// Update cart display
function updateCartDisplay() {
    const cartCount = document.getElementById('cart-count');
    const cartItems = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    const cartEmpty = document.getElementById('cart-empty');
    
    if (cartCount) {
        const totalItems = cart.reduce((total, item) => total + item.quantity, 0);
        cartCount.textContent = totalItems;
    }
    
    if (cartTotalElement) {
        cartTotalElement.textContent = cartTotal.toLocaleString('en-IN');
    }

    // Handle discount and grand total if on cart page
    const discountRow = document.getElementById('discount-row');
    const discountEl = document.getElementById('cart-discount');
    const grandTotalEl = document.getElementById('cart-grand-total');
    const totalSummaryEl = document.getElementById('cart-total-summary');
    const discountAmount = Math.round(cartTotal * (discountPercent / 100));
    const grandTotal = Math.max(cartTotal - discountAmount, 0);
    
    if (discountRow && discountEl) {
        if (discountPercent > 0) {
            discountRow.style.display = 'flex';
            discountEl.textContent = discountAmount.toLocaleString('en-IN');
        } else {
            discountRow.style.display = 'none';
        }
    }
    if (grandTotalEl) {
        grandTotalEl.textContent = grandTotal.toLocaleString('en-IN');
    }
    if (totalSummaryEl) {
        totalSummaryEl.textContent = grandTotal.toLocaleString('en-IN');
    }
    
    if (cartItems && cartEmpty) {
        if (cart.length === 0) {
            cartItems.style.display = 'none';
            cartEmpty.style.display = 'block';
        } else {
            cartItems.style.display = 'block';
            cartEmpty.style.display = 'none';
            renderCartItems();
        }
    }
}

// Render cart items
function renderCartItems() {
    const cartItems = document.getElementById('cart-items');
    if (!cartItems) return;
    
    cartItems.innerHTML = '';
    
    cart.forEach((item, index) => {
        const cartItem = document.createElement('div');
        cartItem.className = 'cart-item d-flex align-items-center justify-content-between';
        cartItem.innerHTML = `
            <div class="d-flex align-items-center flex-grow-1">
                <img src="${item.image}" alt="${item.name}" class="me-4">
                <div class="flex-grow-1">
                    <h6 class="mb-2 fw-bold text-dark">${item.name}</h6>
                    <p class="mb-0 cart-item-price">₹${item.price.toLocaleString('en-IN')} each</p>
                </div>
            </div>
            <div class="d-flex align-items-center gap-4">
                <div class="quantity-controls">
                    <button class="quantity-btn" onclick="updateQuantity(${index}, -1)" title="Decrease quantity">
                        <i class="bi bi-dash"></i>
                    </button>
                    <span class="quantity-display">${item.quantity}</span>
                    <button class="quantity-btn" onclick="updateQuantity(${index}, 1)" title="Increase quantity">
                        <i class="bi bi-plus"></i>
                    </button>
                </div>
                <div class="text-end">
                    <p class="mb-2 cart-item-total">₹${(item.price * item.quantity).toLocaleString('en-IN')}</p>
                    <button class="remove-btn" onclick="removeFromCart(${index})" title="Remove item">
                        <i class="bi bi-trash me-1"></i>Remove
                    </button>
                </div>
            </div>
        `;
        cartItems.appendChild(cartItem);
    });
}

// Update item quantity
function updateQuantity(index, change) {
    const item = cart[index];
    const newQuantity = item.quantity + change;
    
    if (newQuantity <= 0) {
        removeFromCart(index);
    } else {
        item.quantity = newQuantity;
        calculateCartTotal();
        saveCartToStorage();
        updateCartDisplay();
    }
}

// Remove item from cart
function removeFromCart(index) {
    cart.splice(index, 1);
    calculateCartTotal();
    saveCartToStorage();
    updateCartDisplay();
}

// Show add to cart success message
function showAddToCartSuccess(itemName) {
    // Create a temporary success message
    const successMessage = document.createElement('div');
    successMessage.className = 'alert alert-success position-fixed';
    successMessage.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    successMessage.innerHTML = `
        <i class="bi bi-check-circle-fill me-2"></i>
        ${itemName} added to cart!
    `;
    
    document.body.appendChild(successMessage);
    
    // Remove after 3 seconds
    setTimeout(() => {
        successMessage.remove();
    }, 3000);
}

// Show error message (fallback if auth.js not loaded)
function showErrorMessage(message) {
    // Check if auth.js showErrorMessage is available
    if (typeof window.showErrorMessage === 'function' && window.showErrorMessage !== showErrorMessage) {
        window.showErrorMessage(message);
        return;
    }
    
    // Fallback implementation
    const errorMessage = document.createElement('div');
    errorMessage.className = 'alert alert-danger position-fixed';
    errorMessage.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    errorMessage.innerHTML = `
        <i class="bi bi-exclamation-triangle-fill me-2"></i>
        ${message}
    `;
    
    document.body.appendChild(errorMessage);
    
    // Remove after 4 seconds
    setTimeout(() => {
        errorMessage.remove();
    }, 4000);
}

// Checkout function
function checkout() {
    console.log('Checkout function called');
    console.log('Cart length:', cart.length);
    console.log('User logged in:', isUserLoggedIn());
    
    // Get checkout button and add loading state
    const checkoutBtn = document.getElementById('checkout-btn');
    if (checkoutBtn) {
        const originalText = checkoutBtn.innerHTML;
        checkoutBtn.innerHTML = '<span class="loading-spinner"></span> Processing...';
        checkoutBtn.disabled = true;
        
        // Reset button after a short delay
        setTimeout(() => {
            checkoutBtn.innerHTML = originalText;
            checkoutBtn.disabled = false;
        }, 1000);
    }
    
    if (cart.length === 0) {
        showErrorMessage('Your cart is empty! Please add some items before checkout.');
        return;
    }
    
    // Check if user is logged in
    if (!isUserLoggedIn()) {
        console.log('User not logged in, showing cute notification');
        // Show cute login notification
        showCuteLoginNotification('checkout');
        return;
    }
    
    console.log('User is logged in, proceeding with checkout');
    // User is logged in, proceed with checkout
    proceedWithCheckout();
}

// Proceed with checkout for logged-in users
function proceedWithCheckout() {
    // Show checkout modal if present
    const checkoutModalEl = document.getElementById('checkoutModal');
    if (checkoutModalEl) {
        const checkoutModal = new bootstrap.Modal(checkoutModalEl);
        checkoutModal.show();
    }
    
    // Create modern order confirmation modal
    showOrderConfirmationModal();
}

// Show modern order confirmation modal
function showOrderConfirmationModal() {
    const orderSummary = cart.map(item => 
        `${item.name} x${item.quantity} - ₹${(item.price * item.quantity).toLocaleString('en-IN')}`
    ).join('\n');
    const discountAmount = Math.round(cartTotal * (discountPercent / 100));
    const finalTotal = Math.max(cartTotal - discountAmount, 0);
    
    // Create and show custom order confirmation modal
    const orderModal = document.createElement('div');
    orderModal.className = 'modal fade';
    orderModal.id = 'orderConfirmationModal';
    orderModal.innerHTML = `
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header border-0 pb-0">
                    <div class="w-100 text-center">
                        <div class="order-success-icon mb-3">
                            <i class="bi bi-check-circle-fill text-success"></i>
                        </div>
                        <h4 class="modal-title fw-bold text-dark">Order Confirmed!</h4>
                    </div>
                </div>
                <div class="modal-body text-center px-4 pb-4">
                    <p class="text-muted mb-4">Thank you for your order! We're preparing your delicious meal.</p>
                    
                    <div class="order-summary-card bg-light rounded-3 p-4 mb-4">
                        <h6 class="fw-bold text-dark mb-3">Order Summary</h6>
                        <div class="order-items text-start">
                            ${cart.map(item => `
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-dark">${item.name} x${item.quantity}</span>
                                    <span class="fw-bold text-dark">₹${(item.price * item.quantity).toLocaleString('en-IN')}</span>
                                </div>
                            `).join('')}
                            ${discountAmount > 0 ? `
                                <div class="d-flex justify-content-between align-items-center mb-2 text-success">
                                    <span>Discount (${discountPercent}%)</span>
                                    <span class="fw-bold">-₹${discountAmount.toLocaleString('en-IN')}</span>
                                </div>
                            ` : ''}
                            <hr class="my-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="h6 fw-bold text-dark">Total</span>
                                <span class="h5 fw-bold text-warning">₹${finalTotal.toLocaleString('en-IN')}</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="order-info mb-4">
                        <div class="row g-3">
                            <div class="col-6">
                                <div class="info-item">
                                    <i class="bi bi-clock text-primary me-2"></i>
                                    <small class="text-muted">Estimated delivery: 30-45 mins</small>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="info-item">
                                    <i class="bi bi-truck text-success me-2"></i>
                                    <small class="text-muted">Free delivery</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-warning btn-lg py-3 fw-bold" onclick="closeOrderModal()">
                            <i class="bi bi-house me-2"></i>Continue Shopping
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    document.body.appendChild(orderModal);
    const modal = new bootstrap.Modal(orderModal);
    modal.show();
    
    // Clear cart after successful checkout
    cart = [];
    calculateCartTotal();
    saveCartToStorage();
    updateCartDisplay();
    
    // Close cart modal if present
    const cartModalEl = document.getElementById('cartModal');
    if (cartModalEl) {
        const cartModal = bootstrap.Modal.getInstance(cartModalEl);
        if (cartModal) {
            cartModal.hide();
        }
    }
}

// Close order confirmation modal
function closeOrderModal() {
    const orderModal = document.getElementById('orderConfirmationModal');
    if (orderModal) {
        const modal = bootstrap.Modal.getInstance(orderModal);
        if (modal) {
            modal.hide();
        }
        // Remove modal from DOM after hiding
        orderModal.addEventListener('hidden.bs.modal', function() {
            orderModal.remove();
        });
    }
}

// Apply promo code
function applyPromoCode() {
    const input = document.getElementById('promo-code');
    if (!input) return;
    const code = (input.value || '').trim().toUpperCase();
    if (!code) {
        if (typeof showErrorMessage === 'function') showErrorMessage('Please enter a promo code');
        else alert('Please enter a promo code');
        return;
    }
    if (code === 'QUICK10') {
        discountPercent = 10;
        if (typeof showSuccessMessage === 'function') showSuccessMessage('Promo applied: 10% off');
        else alert('Promo applied: 10% off');
    } else {
        discountPercent = 0;
        if (typeof showErrorMessage === 'function') showErrorMessage('Invalid promo code');
        else alert('Invalid promo code');
    }
    updateCartDisplay();
}

// Save cart to localStorage
function saveCartToStorage() {
    localStorage.setItem('quickbiteCart', JSON.stringify(cart));
}

// Load cart from localStorage
function loadCartFromStorage() {
    const savedCart = localStorage.getItem('quickbiteCart');
    if (savedCart) {
        cart = JSON.parse(savedCart);
        calculateCartTotal();
    }
}

// Filter menu items by category
function filterMenuItems(event) {
    const category = event.target.getAttribute('data-category');
    const menuItems = document.querySelectorAll('.menu-item');
    const filterButtons = document.querySelectorAll('.category-filter');
    
    // Update active button
    filterButtons.forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filter items
    menuItems.forEach(item => {
        const itemCategory = item.getAttribute('data-category');
        
        if (category === 'all' || itemCategory === category) {
            item.style.display = 'block';
            item.classList.add('fade-in');
        } else {
            item.style.display = 'none';
        }
    });
}


// Search menu items
function searchMenuItems() {
    const searchTerm = document.getElementById('menuSearch').value.toLowerCase();
    const menuItems = document.querySelectorAll('.menu-item');
    const filterButtons = document.querySelectorAll('.category-filter');
    const activeFilter = document.querySelector('.category-filter.active');
    const activeCategory = activeFilter ? activeFilter.getAttribute('data-category') : 'all';
    
    menuItems.forEach(item => {
        const itemName = item.querySelector('.card-title').textContent.toLowerCase();
        const itemDescription = item.querySelector('.card-text').textContent.toLowerCase();
        const itemCategory = item.getAttribute('data-category');
        
        const matchesSearch = itemName.includes(searchTerm) || itemDescription.includes(searchTerm);
        const matchesCategory = activeCategory === 'all' || itemCategory === activeCategory;
        
        if (matchesSearch && matchesCategory) {
            item.style.display = 'block';
            item.classList.add('fade-in');
        } else {
            item.style.display = 'none';
        }
    });
    
    // Show no results message if needed
    const visibleItems = Array.from(menuItems).filter(item => item.style.display !== 'none');
    showNoResultsMessage(visibleItems.length === 0 && searchTerm.length > 0);
}

// Show no results message
function showNoResultsMessage(show) {
    let noResultsDiv = document.getElementById('no-results-message');
    
    if (show && !noResultsDiv) {
        noResultsDiv = document.createElement('div');
        noResultsDiv.id = 'no-results-message';
        noResultsDiv.className = 'col-12 text-center py-5';
        noResultsDiv.innerHTML = `
            <div class="no-results-content">
                <i class="bi bi-search text-muted mb-3" style="font-size: 3rem;"></i>
                <h4 class="text-muted mb-3">No dishes found</h4>
                <p class="text-muted">Try searching with different keywords or browse our categories</p>
                <button class="btn btn-outline-warning" onclick="clearSearch()">
                    <i class="bi bi-arrow-clockwise me-2"></i>Clear Search
                </button>
            </div>
        `;
        document.getElementById('menu-items').appendChild(noResultsDiv);
    } else if (!show && noResultsDiv) {
        noResultsDiv.remove();
    }
}

// Clear search
function clearSearch() {
    document.getElementById('menuSearch').value = '';
    searchMenuItems();
}


// Handle contact form submission
function handleContactForm(event) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    let isValid = true;
    
    // Reset validation
    form.querySelectorAll('.form-control, .form-select').forEach(field => {
        field.classList.remove('is-invalid', 'is-valid');
    });
    
    // Validate required fields
    const requiredFields = ['name', 'email', 'subject', 'message'];
    requiredFields.forEach(fieldName => {
        const field = form.querySelector(`[name="${fieldName}"]`);
        const value = field.value.trim();
        
        if (!value) {
            field.classList.add('is-invalid');
            isValid = false;
        } else {
            field.classList.add('is-valid');
        }
    });
    
    // Validate email format
    const emailField = form.querySelector('[name="email"]');
    const emailValue = emailField.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    
    if (emailValue && !emailRegex.test(emailValue)) {
        emailField.classList.add('is-invalid');
        isValid = false;
    }
    
    // Validate phone number (optional)
    const phoneField = form.querySelector('[name="phone"]');
    const phoneValue = phoneField.value.trim();
    const phoneRegex = /^[\+]?[0-9\s\-\(\)]{10,}$/;
    
    if (phoneValue && !phoneRegex.test(phoneValue)) {
        phoneField.classList.add('is-invalid');
        isValid = false;
    }
    
    if (isValid) {
        // Show success message
        const successModal = new bootstrap.Modal(document.getElementById('successModal'));
        successModal.show();
        
        // Reset form
        form.reset();
        form.querySelectorAll('.form-control, .form-select').forEach(field => {
            field.classList.remove('is-valid');
        });
        
        // Simulate form submission
        console.log('Form submitted:', Object.fromEntries(formData));
    }
}

// Smooth scrolling for anchor links (exclude Bootstrap components like dropdowns/modals)
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        const isBootstrapToggle = this.hasAttribute('data-bs-toggle') || this.hasAttribute('data-bs-target');

        // Ignore pure hash links and Bootstrap component toggles (e.g., dropdowns, modals)
        if (!href || href === '#' || isBootstrapToggle) {
            return;
        }

        e.preventDefault();
        try {
            const target = document.querySelector(href);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        } catch (err) {
            // Invalid selector (e.g., '#'), safely ignore
        }
    });
});

// Add loading animation to buttons
document.querySelectorAll('.btn').forEach(button => {
    button.addEventListener('click', function() {
        if (this.type === 'submit' || this.classList.contains('btn-warning')) {
            const originalText = this.innerHTML;
            this.innerHTML = '<span class="loading-spinner"></span> Loading...';
            this.disabled = true;
            
            setTimeout(() => {
                this.innerHTML = originalText;
                this.disabled = false;
            }, 2000);
        }
    });
});

// Add fade-in animation to elements on scroll
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('fade-in');
        }
    });
}, observerOptions);

// Observe elements for animation
document.querySelectorAll('.feature-card, .dish-card, .menu-card').forEach(el => {
    observer.observe(el);
});

// Handle image loading errors
document.querySelectorAll('img').forEach(img => {
    img.addEventListener('error', function() {
        this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjhmOWZhIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzZjNzU3ZCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlPC90ZXh0Pjwvc3ZnPg==';
        this.alt = 'Image not available';
    });
});

// Add keyboard navigation support
document.addEventListener('keydown', function(event) {
    // ESC key to close modals
    if (event.key === 'Escape') {
        const openModals = document.querySelectorAll('.modal.show');
        openModals.forEach(modal => {
            const modalInstance = bootstrap.Modal.getInstance(modal);
            if (modalInstance) {
                modalInstance.hide();
            }
        });
    }
    
    // Enter key to submit forms
    if (event.key === 'Enter' && event.target.tagName === 'INPUT') {
        const form = event.target.closest('form');
        if (form && form.id === 'contactForm') {
            event.preventDefault();
            handleContactForm(new Event('submit'));
        }
    }
});

// Add touch support for mobile devices
if ('ontouchstart' in window) {
    document.querySelectorAll('.btn, .quantity-btn').forEach(button => {
        button.addEventListener('touchstart', function() {
            this.style.transform = 'scale(0.95)';
        });
        
        button.addEventListener('touchend', function() {
            this.style.transform = '';
        });
    });
}

// Performance optimization: Debounce scroll events
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Optimize scroll performance
const optimizedScrollHandler = debounce(() => {
    // Add any scroll-based functionality here
}, 16);

window.addEventListener('scroll', optimizedScrollHandler);

// Navbar elevation on scroll
function handleNavbarScroll() {
    const navbar = document.querySelector('.navbar');
    const toggleClass = () => {
        if (!navbar) return;
        if (window.scrollY > 8) navbar.classList.add('is-scrolled');
        else navbar.classList.remove('is-scrolled');
    };
    toggleClass();
    window.addEventListener('scroll', debounce(toggleClass, 50));
}

// Add service worker for offline functionality (basic implementation)
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/sw.js')
            .then(registration => {
                console.log('SW registered: ', registration);
            })
            .catch(registrationError => {
                console.log('SW registration failed: ', registrationError);
            });
    });
}

//// Cute notification functions
//function showCuteLoginNotification(type = 'cart') {
//    const notification = document.getElementById('cuteLoginNotification');
//    if (!notification) return;
    
//    // Update notification content based on type
//    const title = notification.querySelector('.notification-title');
//    const message = notification.querySelector('.notification-message');
//    const icon = notification.querySelector('.notification-icon i');
    
//    if (type === 'checkout') {
//        title.textContent = 'Almost there! 🛒';
//        message.textContent = 'Please login first to complete your order and enjoy exclusive benefits!';
//        icon.className = 'bi bi-cart-check-fill';
//        notification.classList.add('checkout-notification');
//    } else {
//        title.textContent = 'Hey there! 👋';
//        message.textContent = 'Please login first to add items to your cart and enjoy a personalized shopping experience!';
//        icon.className = 'bi bi-heart-fill';
//        notification.classList.remove('checkout-notification');
//    }
    
//    // Show notification
//    notification.style.display = 'block';
    
//    // Auto hide after 5 seconds
//    setTimeout(() => {
//        hideCuteNotification();
//    }, 5000);
//}

function hideCuteNotification() {
    const notification = document.getElementById('cuteLoginNotification');
    if (!notification) return;
    
    notification.classList.add('hide');
    
    // Remove from DOM after animation
    setTimeout(() => {
        notification.style.display = 'none';
        notification.classList.remove('hide');
    }, 300);
}

// Test function to add sample items to cart (for testing purposes)
function addTestItems() {
    // Clear existing cart
    cart = [];
    
    // Add test items
    addToCart('Veg Spring Roll', 149, 'assets/images/1.jpg');
    addToCart('Aloo Tikki', 149, 'assets/images/2.jpg');
    
    console.log('Test items added to cart');
    updateCartDisplay();
}

// Export functions for global access
window.addToCart = addToCart;
window.updateQuantity = updateQuantity;
window.removeFromCart = removeFromCart;
window.checkout = checkout;
window.filterMenuItems = filterMenuItems;
window.closeOrderModal = closeOrderModal;
window.addTestItems = addTestItems;
window.isUserLoggedIn = isUserLoggedIn;
window.showCuteLoginNotification = showCuteLoginNotification;
window.hideCuteNotification = hideCuteNotification;
window.searchMenuItems = searchMenuItems;
window.clearSearch = clearSearch; 