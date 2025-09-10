
// Enhanced Authentication System for QuickBite
// Professional user management with profile functionality

// Authentication state
let isLoggedIn = false;
let currentUser = null;

// Initialize authentication on page load
document.addEventListener('DOMContentLoaded', function() {
    initializeAuth();
    updateNavigation();
    setupProfileDropdown();
});

// Initialize authentication system
function initializeAuth() {
    // Check if user is already logged in
    const userData = localStorage.getItem('quickbiteCurrentUser');
    if (userData) {
        try {
            currentUser = JSON.parse(userData);
            isLoggedIn = true;
            
            // Update last activity
            currentUser.lastActivity = new Date().toISOString();
            localStorage.setItem('quickbiteCurrentUser', JSON.stringify(currentUser));
            
            console.log('User authenticated:', currentUser.firstName + ' ' + currentUser.lastName);
        } catch (error) {
            console.error('Error parsing user data:', error);
            clearAuthData();
        }
    }
}

// Update navigation based on authentication status
function updateNavigation() {
    const loginLink = document.querySelector('.auth-link.login-link');
    const userInfo = document.querySelector('.user-info');
    
    if (!loginLink || !userInfo) return;

    if (isLoggedIn && currentUser) {
        // Hide login/register dropdown
        loginLink.style.display = 'none';
        
        // Show user profile dropdown
        userInfo.style.display = 'block';
        userInfo.innerHTML = createUserDropdown();
    } else {
        // Show login/register dropdown
        loginLink.style.display = 'block';
        
        // Hide user profile dropdown
        userInfo.style.display = 'none';
    }
}

// Create user profile dropdown HTML
function createUserDropdown() {
    const userInitials = getUserInitials();
    const profileImage = currentUser.profileImage;
    
    return `
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" 
               data-bs-toggle="dropdown" aria-expanded="false" id="userDropdown">
                <div class="profile-avatar me-2">
                    ${profileImage 
                        ? `<img src="${profileImage}" alt="${currentUser.firstName}" class="profile-img">` 
                        : `<span class="profile-initials">${userInitials}</span>`
                    }
                </div>
                <span class="profile-name d-none d-md-inline">${currentUser.firstName}</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-end profile-dropdown">
                <li class="dropdown-header">
                    <div class="user-info-header">
                        <div class="profile-avatar-large mb-2">
                            ${profileImage 
                                ? `<img src="${profileImage}" alt="${currentUser.firstName}" class="profile-img-large">` 
                                : `<span class="profile-initials-large">${userInitials}</span>`
                            }
                        </div>
                        <h6 class="mb-1">${currentUser.firstName} ${currentUser.lastName}</h6>
                        <small class="text-muted">${currentUser.email}</small>
                    </div>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item" href="#" onclick="showProfile()">
                        <i class="bi bi-person me-2"></i>My Profile
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#" onclick="showOrderHistory()">
                        <i class="bi bi-clock-history me-2"></i>Order History
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="#" onclick="showSettings()">
                        <i class="bi bi-gear me-2"></i>Settings
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item text-danger" href="#" onclick="logout()">
                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                    </a>
                </li>
            </ul>
        </li>
    `;
}

// Get user initials for profile avatar
function getUserInitials() {
    if (!currentUser) return 'U';
    const firstName = currentUser.firstName || '';
    const lastName = currentUser.lastName || '';
    return (firstName.charAt(0) + lastName.charAt(0)).toUpperCase() || 'U';
}

// Setup profile dropdown styling
function setupProfileDropdown() {
    // Add dynamic CSS for profile dropdown
    const style = document.createElement('style');
    style.textContent = `
        .profile-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ffc107, #e0a800);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 2px solid rgba(255, 193, 7, 0.3);
            transition: all 0.3s ease;
        }
        
        .profile-avatar:hover {
            border-color: #ffc107;
            transform: scale(1.05);
        }
        
        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }
        
        .profile-initials {
            font-size: 0.8rem;
            font-weight: 600;
            color: #000;
        }
        
        .profile-name {
            font-weight: 500;
            color: #fff;
            text-transform: capitalize;
        }
        
        .profile-dropdown {
            min-width: 280px;
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            padding: 0.5rem 0;
        }
        
        .profile-dropdown .dropdown-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 1.5rem;
            text-align: center;
            border-radius: 12px 12px 0 0;
            margin: -0.5rem -0rem 0 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .profile-avatar-large {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ffc107, #e0a800);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin: 0 auto;
            border: 3px solid #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .profile-img-large {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-initials-large {
            font-size: 1.5rem;
            font-weight: 700;
            color: #000;
        }
        
        .user-info-header h6 {
            margin-bottom: 0.25rem;
            font-weight: 600;
            color: #212529;
        }
        
        .user-info-header small {
            font-size: 0.8rem;
        }
        
        .profile-dropdown .dropdown-item {
            padding: 0.75rem 1.5rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        
        .profile-dropdown .dropdown-item:hover {
            background-color: #f8f9fa;
            transform: translateX(5px);
        }
        
        .profile-dropdown .dropdown-item.text-danger:hover {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .profile-dropdown .dropdown-divider {
            margin: 0.5rem 0;
        }
    `;
    document.head.appendChild(style);
}

// Show user profile modal
function showProfile() {
    if (!currentUser) return;
    
    const profileModal = document.createElement('div');
    profileModal.className = 'modal fade';
    profileModal.id = 'profileModal';
    profileModal.innerHTML = `
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-person me-2"></i>My Profile
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row">
                        <div class="col-md-4 text-center mb-4">
                            <div class="profile-avatar-xl mb-3">
                                ${currentUser.profileImage 
                                    ? `<img src="${currentUser.profileImage}" alt="${currentUser.firstName}" class="profile-img-xl">` 
                                    : `<span class="profile-initials-xl">${getUserInitials()}</span>`
                                }
                            </div>
                            <h5 class="mb-1">${currentUser.firstName} ${currentUser.lastName}</h5>
                            <p class="text-muted mb-3">${currentUser.email}</p>
                            <button class="btn btn-outline-warning btn-sm" onclick="editProfile()">
                                <i class="bi bi-pencil me-2"></i>Edit Profile
                            </button>
                        </div>
                        <div class="col-md-8">
                            <div class="card border-0 bg-light">
                                <div class="card-body">
                                    <h6 class="card-title mb-3">
                                        <i class="bi bi-info-circle me-2"></i>Profile Information
                                    </h6>
                                    <div class="row g-3">
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">First Name</label>
                                            <p class="fw-medium">${currentUser.firstName}</p>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">Last Name</label>
                                            <p class="fw-medium">${currentUser.lastName}</p>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">Email</label>
                                            <p class="fw-medium">${currentUser.email}</p>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">Phone</label>
                                            <p class="fw-medium">${currentUser.phone || 'Not provided'}</p>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label text-muted">Address</label>
                                            <p class="fw-medium">${currentUser.address || 'Not provided'}</p>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">Member Since</label>
                                            <p class="fw-medium">${new Date(currentUser.createdAt || currentUser.lastLogin).toLocaleDateString()}</p>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="form-label text-muted">Last Login</label>
                                            <p class="fw-medium">${new Date(currentUser.lastLogin).toLocaleDateString()}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-warning" onclick="editProfile()">
                        <i class="bi bi-pencil me-2"></i>Edit Profile
                    </button>
                </div>
            </div>
        </div>
    `;
    
    // Add extra styling for profile modal
    const profileStyle = document.createElement('style');
    profileStyle.textContent = `
        .profile-avatar-xl {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ffc107, #e0a800);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            margin: 0 auto;
            border: 4px solid #fff;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .profile-img-xl {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .profile-initials-xl {
            font-size: 2.5rem;
            font-weight: 700;
            color: #000;
        }
    `;
    document.head.appendChild(profileStyle);
    
    document.body.appendChild(profileModal);
    const modal = new bootstrap.Modal(profileModal);
    modal.show();
    
    // Remove modal from DOM when closed
    profileModal.addEventListener('hidden.bs.modal', function() {
        profileModal.remove();
        profileStyle.remove();
    });
}

// Edit profile function
function editProfile() {
    showAlert('info', 'Profile editing feature coming soon!');
}

// Show order history
function showOrderHistory() {
    showAlert('info', 'Order history feature coming soon!');
}

// Show settings
function showSettings() {
    showAlert('info', 'Settings feature coming soon!');
}

// Logout function
function logout() {
    if (confirm('Are you sure you want to logout?')) {
        // Clear authentication data
        clearAuthData();
        
        // Update UI
        isLoggedIn = false;
        currentUser = null;
        updateNavigation();
        
        // Clear cart if needed
        localStorage.removeItem('quickbiteCart');
        
        // Update cart display if on a page with cart
        if (typeof updateCartDisplay === 'function') {
            updateCartDisplay();
        }
        
        // Show logout success message
        showSuccessMessage('You have been logged out successfully.');
        
        // Redirect to home page after a short delay
        setTimeout(() => {
            if (window.location.pathname !== '/Home.aspx' && window.location.pathname !== '/') {
                window.location.href = 'Home.aspx';
            }
        }, 1000);
    }
}

// Clear authentication data
function clearAuthData() {
    localStorage.removeItem('quickbiteCurrentUser');
    localStorage.removeItem('quickbiteRememberMe');
}

// Check authentication status (for other scripts to use)
function checkAuthStatus() {
    return isLoggedIn && currentUser !== null;
}

// Get current user (for other scripts to use)
function getCurrentUser() {
    return currentUser;
}

// Show success message
function showSuccessMessage(message) {
    showAlert('success', message);
}

// Show error message
function showErrorMessage(message) {
    showAlert('danger', message);
}

// Show info message
function showInfoMessage(message) {
    showAlert('info', message);
}

// Generic alert function
function showAlert(type, message) {
    // Remove existing alerts
    const existingAlerts = document.querySelectorAll('.auth-alert');
    existingAlerts.forEach(alert => alert.remove());
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed auth-alert`;
    alertDiv.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 300px; max-width: 400px;';
    alertDiv.innerHTML = `
        <i class="bi bi-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-triangle' : 'info-circle'} me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(alertDiv);
    
    // Auto remove after 4 seconds
    setTimeout(() => {
        if (alertDiv.parentNode) {
            alertDiv.remove();
        }
    }, 4000);
}

// Authentication required check
function requireAuth(action = 'perform this action') {
    if (!isLoggedIn) {
        showErrorMessage(`Please login to ${action}`);
        return false;
    }
    return true;
}

// Update user data in localStorage
function updateUserData(updatedData) {
    if (!currentUser) return false;
    
    // Merge updated data with current user
    currentUser = { ...currentUser, ...updatedData };
    
    // Update in localStorage
    localStorage.setItem('quickbiteCurrentUser', JSON.stringify(currentUser));
    
    // Update in users array
    const users = JSON.parse(localStorage.getItem('quickbiteUsers') || '[]');
    const userIndex = users.findIndex(u => u.id === currentUser.id);
    if (userIndex !== -1) {
        users[userIndex] = { ...users[userIndex], ...updatedData };
        localStorage.setItem('quickbiteUsers', JSON.stringify(users));
    }
    
    // Update navigation
    updateNavigation();
    
    return true;
}

// Initialize demo user (for testing purposes)
function createDemoUser() {
    const demoUser = {
        id: 'demo-user-1',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+91 98765 43210',
        address: 'Demo Address, Rajkot, Gujarat',
        password: 'demo123',
        profileImage: null,
        preferences: {
            marketing: true
        },
        createdAt: new Date().toISOString(),
        lastLogin: new Date().toISOString()
    };
    
    const users = JSON.parse(localStorage.getItem('quickbiteUsers') || '[]');
    if (!users.find(u => u.email === demoUser.email)) {
        users.push(demoUser);
        localStorage.setItem('quickbiteUsers', JSON.stringify(users));
        console.log('Demo user created: john.doe@example.com / demo123');
    }
}

// Auto-login demo user (for testing)
function loginDemoUser() {
    const users = JSON.parse(localStorage.getItem('quickbiteUsers') || '[]');
    const demoUser = users.find(u => u.email === 'john.doe@example.com');
    
    if (demoUser) {
        currentUser = {
            id: demoUser.id,
            firstName: demoUser.firstName,
            lastName: demoUser.lastName,
            email: demoUser.email,
            phone: demoUser.phone,
            address: demoUser.address,
            profileImage: demoUser.profileImage,
            preferences: demoUser.preferences,
            lastLogin: new Date().toISOString()
        };
        
        isLoggedIn = true;
        localStorage.setItem('quickbiteCurrentUser', JSON.stringify(currentUser));
        updateNavigation();
        showSuccessMessage('Demo user logged in successfully!');
        
        return true;
    }
    return false;
}

// Export functions for global use
window.isLoggedIn = () => isLoggedIn;
window.currentUser = () => currentUser;
window.checkAuthStatus = checkAuthStatus;
window.getCurrentUser = getCurrentUser;
window.requireAuth = requireAuth;
window.showProfile = showProfile;
window.showOrderHistory = showOrderHistory;
window.showSettings = showSettings;
window.editProfile = editProfile;
window.logout = logout;
window.showSuccessMessage = showSuccessMessage;
window.showErrorMessage = showErrorMessage;
window.showInfoMessage = showInfoMessage;
window.updateUserData = updateUserData;
window.createDemoUser = createDemoUser;
window.loginDemoUser = loginDemoUser;

// Initialize demo user on load (for testing)
// createDemoUser(); // Uncomment this for testing

console.log('Enhanced authentication system loaded successfully!');