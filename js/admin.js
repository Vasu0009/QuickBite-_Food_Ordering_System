// Minimal client-side demo logic for admin pages (no backend)
(function() {
    document.addEventListener('DOMContentLoaded', function() {
        // Fake data in localStorage namespaces
        const demo = window.localStorage.getItem('qb_demo_seeded');
        if (!demo) seedDemoData();

        guardAdmin();
        renderDashboardStats();
        renderRecentOrders();
        initOrdersPage();
        initUsersPage();
        initMenuPage();
        initCategoriesPage();
        initSettingsPage();
        initCouponsPage();
        initBannersPage();

        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', function() {
                // Clear a hypothetical auth token
                localStorage.removeItem('qb_auth_user');
                window.location.href = '../login.html';
            });
        }
    });

    function seedDemoData() {
        const users = [
            { id: 'u1', name: 'Admin User', email: 'admin@quickbite.com', role: 'admin', active: true },
            { id: 'u2', name: 'John Doe', email: 'john@example.com', role: 'customer', active: true },
            { id: 'u3', name: 'Jane Smith', email: 'jane@example.com', role: 'customer', active: false }
        ];
        const categories = [
            { id: 'c1', name: 'Starters', slug: 'starters', description: 'Light bites to begin' },
            { id: 'c2', name: 'Mains', slug: 'mains', description: 'Hearty and filling' },
            { id: 'c3', name: 'Desserts', slug: 'desserts', description: 'Sweet treats' }
        ];
        const menu = [
            { id: 'm1', name: 'Chinese Noodles', price: 299, image: 'assets/images/food1.jpg', categoryId: 'c2' },
            { id: 'm2', name: 'Indian Pakoras', price: 399, image: 'assets/images/food2.jpg', categoryId: 'c1' },
            { id: 'm3', name: 'Paneer Tikka', price: 199, image: 'assets/images/food3.jpg', categoryId: 'c2' }
        ];
        const orders = [
            { id: 'o1001', customer: 'John Doe', total: 698, status: 'Pending', date: new Date().toLocaleDateString() },
            { id: 'o1002', customer: 'Jane Smith', total: 199, status: 'Delivered', date: new Date().toLocaleDateString() }
        ];
        const coupons = [ { id: 'cp1', code: 'WELCOME10', value: 10, type: 'percent', till: '' } ];
        const banners = [
            { id: 'b1', image: 'assets/images/hero1.jpg', title: 'Fresh & Fast', subtitle: 'Taste the best' }
        ];
        localStorage.setItem('qb_users', JSON.stringify(users));
        localStorage.setItem('qb_categories', JSON.stringify(categories));
        localStorage.setItem('qb_menu', JSON.stringify(menu));
        localStorage.setItem('qb_orders', JSON.stringify(orders));
        localStorage.setItem('qb_coupons', JSON.stringify(coupons));
        localStorage.setItem('qb_banners', JSON.stringify(banners));
        localStorage.setItem('qb_demo_seeded', '1');
    }

    function get(key, fallback) {
        try {
            const raw = localStorage.getItem(key);
            return raw ? JSON.parse(raw) : fallback;
        } catch (_) { return fallback; }
    }
    function set(key, value) {
        localStorage.setItem(key, JSON.stringify(value));
    }

    function guardAdmin() {
        // Only guard admin pages (not admin/login.html)
        const path = (location.pathname || '').toLowerCase();
        const isLogin = path.endsWith('/admin/login.html') || path.endsWith('admin/login.html');
        if (isLogin) return;
        const userRaw = localStorage.getItem('qb_auth_user');
        if (!userRaw) return; // allow viewing without strict auth, but can be toggled
        try {
            const user = JSON.parse(userRaw);
            if (user && user.role !== 'admin') {
                window.location.href = 'login.html';
            }
        } catch (_) {}
    }

    // Dashboard
    function renderDashboardStats() {
        const orders = get('qb_orders', []);
        const menu = get('qb_menu', []);
        const users = get('qb_users', []);
        const categories = get('qb_categories', []);

        const revenue = orders.reduce((sum, o) => sum + (o.total || 0), 0);
        assignText('statOrders', orders.length);
        assignText('statRevenue', `₹${revenue}`);
        assignText('statMenu', menu.length);
        assignText('statUsers', users.length);
        assignText('statCategories', categories.length);
    }

    function renderRecentOrders() {
        const tbody = document.getElementById('recentOrdersBody');
        if (!tbody) return;
        const orders = get('qb_orders', []);
        tbody.innerHTML = '';
        if (orders.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No orders yet</td></tr>';
            return;
        }
        orders.slice(0, 5).forEach(o => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${o.id}</td>
                <td>${o.customer}</td>
                <td>₹${o.total}</td>
                <td><span class="badge bg-${statusColor(o.status)}">${o.status}</span></td>
                <td>${o.date}</td>
            `;
            tbody.appendChild(tr);
        });
    }

    // Orders page
    function initOrdersPage() {
        const tbody = document.getElementById('ordersTableBody');
        if (!tbody) return;
        const search = document.getElementById('orderSearch');
        function render(filter) {
            const orders = get('qb_orders', []);
            const list = (filter ? orders.filter(o => Object.values(o).join(' ').toLowerCase().includes(filter.toLowerCase())) : orders);
            tbody.innerHTML = '';
            if (list.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">No orders to show</td></tr>';
                return;
            }
            list.forEach(o => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${o.id}</td>
                    <td>${o.customer}</td>
                    <td>₹${o.total}</td>
                    <td><span class="badge bg-${statusColor(o.status)}">${o.status}</span></td>
                    <td>${o.date}</td>
                    <td class="text-end">
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-outline-secondary" data-action="mark" data-id="${o.id}">Mark Delivered</button>
                            <button class="btn btn-outline-danger" data-action="delete" data-id="${o.id}">Delete</button>
                        </div>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        render();
        if (search) search.addEventListener('input', e => render(e.target.value));
        tbody.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const orders = get('qb_orders', []);
            const idx = orders.findIndex(o => o.id === id);
            if (idx === -1) return;
            if (action === 'delete') { orders.splice(idx, 1); }
            if (action === 'mark') { orders[idx].status = 'Delivered'; }
            set('qb_orders', orders);
            render(search && search.value);
            renderDashboardStats();
            renderRecentOrders();
        });
    }

    // Users page
    function initUsersPage() {
        const tbody = document.getElementById('usersTableBody');
        if (!tbody) return;
        const search = document.getElementById('userSearch');
        function render(filter) {
            const users = get('qb_users', []);
            const list = (filter ? users.filter(u => Object.values(u).join(' ').toLowerCase().includes(filter.toLowerCase())) : users);
            tbody.innerHTML = '';
            if (list.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No users to show</td></tr>';
                return;
            }
            list.forEach(u => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${u.name}</td>
                    <td>${u.email}</td>
                    <td><span class="badge bg-${u.role === 'admin' ? 'warning text-dark' : 'secondary'}">${u.role}</span></td>
                    <td>${u.active ? '<span class="badge bg-success">Active</span>' : '<span class="badge bg-secondary">Inactive</span>'}</td>
                    <td class="text-end">
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-outline-secondary" data-action="toggle" data-id="${u.id}">${u.active ? 'Deactivate' : 'Activate'}</button>
                            <button class="btn btn-outline-danger" data-action="delete" data-id="${u.id}">Delete</button>
                        </div>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }
        render();
        if (search) search.addEventListener('input', e => render(e.target.value));
        tbody.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const users = get('qb_users', []);
            const idx = users.findIndex(u => u.id === id);
            if (idx === -1) return;
            if (action === 'delete') { users.splice(idx, 1); }
            if (action === 'toggle') { users[idx].active = !users[idx].active; }
            set('qb_users', users);
            render(search && search.value);
            renderDashboardStats();
        });
    }

    // Menu page
    function initMenuPage() {
        const grid = document.getElementById('menuItemsGrid');
        const saveBtn = document.getElementById('saveItemBtn');
        const modalEl = document.getElementById('itemModal');
        const categorySelect = document.getElementById('itemCategory');
        const categoryFilter = document.getElementById('itemCategoryFilter');
        const searchInput = document.getElementById('menuSearch');
        if (!grid) return;
        function render() {
            const menu = get('qb_menu', []);
            const filterId = categoryFilter ? categoryFilter.value : '';
            const q = (searchInput && searchInput.value || '').toLowerCase();
            grid.innerHTML = '';
            let list = filterId ? menu.filter(m => (m.categoryId || '') === filterId) : menu;
            if (q) list = list.filter(m => [m.name, String(m.price)].join(' ').toLowerCase().includes(q));
            if (list.length === 0) {
                grid.innerHTML = '<div class="col-12 text-center text-muted">No items yet. Click Add Item.</div>';
                return;
            }
            list.forEach(item => {
                const col = document.createElement('div');
                col.className = 'col-sm-6 col-md-4 col-lg-3 mb-3';
                col.innerHTML = `
                    <div class="card h-100">
                        <img src="../${item.image || 'assets/images/food1.jpg'}" class="card-img-top" alt="${item.name}">
                        <div class="card-body d-flex flex-column">
                            <h6 class="fw-bold mb-1">${item.name}</h6>
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span class="badge bg-warning text-dark">₹${item.price}</span>
                                <span class="badge bg-light text-dark">${categoryName(item.categoryId)}</span>
                                ${item.available === false ? '<span class="badge bg-secondary">Unavailable</span>' : ''}
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" ${item.available === false ? '' : 'checked'} data-action="toggle-availability" data-id="${item.id}">
                                <label class="form-check-label">Available</label>
                            </div>
                            <div class="mt-auto d-flex gap-2">
                                <button class="btn btn-sm btn-outline-secondary" data-action="edit" data-id="${item.id}">Edit</button>
                                <button class="btn btn-sm btn-outline-danger" data-action="delete" data-id="${item.id}">Delete</button>
                            </div>
                        </div>
                    </div>`;
                grid.appendChild(col);
            });
        }
        render();
        populateCategorySelect();
        populateCategoryFilter();
        if (categoryFilter) categoryFilter.addEventListener('change', render);
        if (searchInput) searchInput.addEventListener('input', render);

        grid.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const menu = get('qb_menu', []);
            const idx = menu.findIndex(m => m.id === id);
            if (action === 'delete' && idx !== -1) {
                menu.splice(idx, 1);
                set('qb_menu', menu);
                render();
                renderDashboardStats();
                return;
            }
            if (action === 'edit' && idx !== -1) {
                fillItemForm(menu[idx]);
                showModal(modalEl);
            }
        });
        grid.addEventListener('change', function(e) {
            const input = e.target.closest('input[data-action="toggle-availability"]');
            if (!input) return;
            const id = input.getAttribute('data-id');
            const menu = get('qb_menu', []);
            const idx = menu.findIndex(m => m.id === id);
            if (idx === -1) return;
            menu[idx].available = !!input.checked;
            set('qb_menu', menu);
        });

        if (saveBtn) {
            saveBtn.addEventListener('click', function() {
                const id = val('itemId');
                const name = val('itemName');
                const price = Number(val('itemPrice')) || 0;
                const image = val('itemImage') || 'assets/images/food1.jpg';
                const categoryId = val('itemCategory') || '';
                if (!name) return;
                const menu = get('qb_menu', []);
                if (id) {
                    const idx = menu.findIndex(m => m.id === id);
                    if (idx !== -1) menu[idx] = { id, name, price, image, categoryId };
                } else {
                    const newId = 'm' + (Date.now());
                    menu.push({ id: newId, name, price, image, categoryId });
                }
                set('qb_menu', menu);
                render();
                renderDashboardStats();
                hideModal(modalEl);
                clearItemForm();
            });
        }
        function populateCategorySelect() {
            if (!categorySelect) return;
            const categories = get('qb_categories', []);
            categorySelect.innerHTML = categories.map(c => `<option value="${c.id}">${c.name}</option>`).join('');
        }
        function populateCategoryFilter() {
            if (!categoryFilter) return;
            const categories = get('qb_categories', []);
            const options = ['<option value="">All Categories</option>'].concat(categories.map(c => `<option value="${c.id}">${c.name}</option>`));
            categoryFilter.innerHTML = options.join('');
        }

        const openAddBtn = document.getElementById('openAddItemBtn');
        if (openAddBtn && categoryFilter && categorySelect) {
            openAddBtn.addEventListener('click', function() {
                // Preselect modal category to current filter
                const current = categoryFilter.value;
                if (current) setValue('itemCategory', current);
            });
        }
    }

    // Settings page
    function initSettingsPage() {
        const saveBtn = document.getElementById('saveSettingsBtn');
        if (!saveBtn) return;
        const nameEl = document.getElementById('setName');
        const emailEl = document.getElementById('setEmail');
        const phoneEl = document.getElementById('setPhone');
        const hoursEl = document.getElementById('setHours');
        const addressEl = document.getElementById('setAddress');
        const savedMsg = document.getElementById('settingsSavedMsg');
        const settings = get('qb_settings', {});
        nameEl.value = settings.name || 'QuickBite';
        emailEl.value = settings.email || 'support@quickbite.com';
        phoneEl.value = settings.phone || '+91 99999 55555';
        hoursEl.value = settings.hours || 'Mon-Sun 10:00 AM - 11:00 PM';
        addressEl.value = settings.address || '';
        saveBtn.addEventListener('click', function() {
            const next = {
                name: nameEl.value.trim(),
                email: emailEl.value.trim(),
                phone: phoneEl.value.trim(),
                hours: hoursEl.value.trim(),
                address: addressEl.value.trim()
            };
            set('qb_settings', next);
            if (savedMsg) { savedMsg.classList.remove('d-none'); setTimeout(() => savedMsg.classList.add('d-none'), 1200); }
        });
    }

    // Coupons page
    function initCouponsPage() {
        const tbody = document.getElementById('couponsTableBody');
        const saveBtn = document.getElementById('saveCouponBtn');
        const modalEl = document.getElementById('couponModal');
        if (!tbody) return;
        function render() {
            const list = get('qb_coupons', []);
            tbody.innerHTML = '';
            if (list.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No coupons</td></tr>';
                return;
            }
            list.forEach(c => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td><code>${c.code}</code></td>
                    <td>${c.value}</td>
                    <td>${c.type}</td>
                    <td>${c.till || '-'}</td>
                    <td class="text-end">
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-outline-secondary" data-action="edit" data-id="${c.id}">Edit</button>
                            <button class="btn btn-outline-danger" data-action="delete" data-id="${c.id}">Delete</button>
                        </div>
                    </td>`;
                tbody.appendChild(tr);
            });
        }
        render();
        tbody.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const list = get('qb_coupons', []);
            const idx = list.findIndex(x => x.id === id);
            if (idx === -1) return;
            if (action === 'delete') { list.splice(idx, 1); set('qb_coupons', list); render(); return; }
            if (action === 'edit') {
                setValue('couponId', list[idx].id);
                setValue('couponCode', list[idx].code);
                setValue('couponValue', list[idx].value);
                setValue('couponType', list[idx].type);
                setValue('couponTill', list[idx].till || '');
                showModal(modalEl);
            }
        });
        if (saveBtn) {
            saveBtn.addEventListener('click', function() {
                const id = val('couponId');
                const code = val('couponCode');
                const value = Number(val('couponValue')) || 0;
                const type = val('couponType') || 'percent';
                const till = val('couponTill') || '';
                if (!code) return;
                const list = get('qb_coupons', []);
                if (id) {
                    const idx = list.findIndex(x => x.id === id);
                    if (idx !== -1) list[idx] = { id, code, value, type, till };
                } else {
                    const newId = 'cp' + Date.now();
                    list.push({ id: newId, code, value, type, till });
                }
                set('qb_coupons', list);
                hideModal(modalEl);
                setValue('couponId', ''); setValue('couponCode', ''); setValue('couponValue', ''); setValue('couponTill', '');
                render();
            });
        }
    }

    // Banners page
    function initBannersPage() {
        const grid = document.getElementById('bannersGrid');
        const saveBtn = document.getElementById('saveBannerBtn');
        const modalEl = document.getElementById('bannerModal');
        if (!grid) return;
        function render() {
            const list = get('qb_banners', []);
            grid.innerHTML = '';
            if (list.length === 0) {
                grid.innerHTML = '<div class="col-12 text-center text-muted">No banners yet</div>';
                return;
            }
            list.forEach(b => {
                const col = document.createElement('div');
                col.className = 'col-sm-6 col-md-4 col-lg-3';
                col.innerHTML = `
                    <div class="card h-100">
                        <img src="../${b.image}" class="card-img-top" alt="banner">
                        <div class="card-body d-flex flex-column">
                            <div class="fw-semibold mb-1">${b.title || ''}</div>
                            <div class="text-muted small mb-3">${b.subtitle || ''}</div>
                            <div class="mt-auto d-flex gap-2">
                                <button class="btn btn-sm btn-outline-secondary" data-action="edit" data-id="${b.id}">Edit</button>
                                <button class="btn btn-sm btn-outline-danger" data-action="delete" data-id="${b.id}">Delete</button>
                            </div>
                        </div>
                    </div>`;
                grid.appendChild(col);
            });
        }
        render();
        grid.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const list = get('qb_banners', []);
            const idx = list.findIndex(x => x.id === id);
            if (idx === -1) return;
            if (action === 'delete') { list.splice(idx, 1); set('qb_banners', list); render(); return; }
            if (action === 'edit') {
                setValue('bannerId', list[idx].id);
                setValue('bannerImage', list[idx].image);
                setValue('bannerTitle', list[idx].title || '');
                setValue('bannerSubtitle', list[idx].subtitle || '');
                showModal(modalEl);
            }
        });
        if (saveBtn) {
            saveBtn.addEventListener('click', function() {
                const id = val('bannerId');
                const image = val('bannerImage') || 'assets/images/hero1.jpg';
                const title = val('bannerTitle') || '';
                const subtitle = val('bannerSubtitle') || '';
                const list = get('qb_banners', []);
                if (id) {
                    const idx = list.findIndex(x => x.id === id);
                    if (idx !== -1) list[idx] = { id, image, title, subtitle };
                } else {
                    const newId = 'b' + Date.now();
                    list.push({ id: newId, image, title, subtitle });
                }
                set('qb_banners', list);
                hideModal(modalEl);
                setValue('bannerId', ''); setValue('bannerImage', ''); setValue('bannerTitle', ''); setValue('bannerSubtitle', '');
                render();
            });
        }
    }

    // Categories page
    function initCategoriesPage() {
        const tbody = document.getElementById('categoriesTableBody');
        const saveBtn = document.getElementById('saveCategoryBtn');
        const modalEl = document.getElementById('categoryModal');
        if (!tbody) return;
        function render() {
            const cats = get('qb_categories', []);
            tbody.innerHTML = '';
            if (cats.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">No categories yet</td></tr>';
                return;
            }
            cats.forEach(c => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${c.name}</td>
                    <td><code>${c.slug || ''}</code></td>
                    <td>${c.description || ''}</td>
                    <td class="text-end">
                        <div class="btn-group btn-group-sm">
                            <button class="btn btn-outline-secondary" data-action="edit" data-id="${c.id}">Edit</button>
                            <button class="btn btn-outline-danger" data-action="delete" data-id="${c.id}">Delete</button>
                        </div>
                    </td>`;
                tbody.appendChild(tr);
            });
        }
        render();
        tbody.addEventListener('click', function(e) {
            const btn = e.target.closest('button[data-action]');
            if (!btn) return;
            const id = btn.getAttribute('data-id');
            const action = btn.getAttribute('data-action');
            const cats = get('qb_categories', []);
            const idx = cats.findIndex(c => c.id === id);
            if (idx === -1) return;
            if (action === 'delete') {
                // prevent delete if used by menu
                const hasUse = get('qb_menu', []).some(m => m.categoryId === id);
                if (hasUse) { alert('Category in use by menu items. Remove usage first.'); return; }
                cats.splice(idx, 1);
            }
            if (action === 'edit') {
                fillCategoryForm(cats[idx]);
                showModal(modalEl);
                return;
            }
            set('qb_categories', cats);
            render();
            renderDashboardStats();
        });
        if (saveBtn) {
            saveBtn.addEventListener('click', function() {
                const id = val('categoryId');
                const name = val('categoryName');
                const slug = val('categorySlug');
                const description = val('categoryDescription');
                if (!name) return;
                const cats = get('qb_categories', []);
                if (id) {
                    const idx = cats.findIndex(c => c.id === id);
                    if (idx !== -1) cats[idx] = { id, name, slug, description };
                } else {
                    const newId = 'c' + (Date.now());
                    cats.push({ id: newId, name, slug, description });
                }
                set('qb_categories', cats);
                hideModal(modalEl);
                clearCategoryForm();
                render();
                renderDashboardStats();
            });
        }
    }

    // Helpers
    function assignText(id, text) {
        const el = document.getElementById(id);
        if (el) el.textContent = text;
    }
    function statusColor(status) {
        const s = (status || '').toLowerCase();
        if (s === 'pending') return 'warning text-dark';
        if (s === 'delivered') return 'success';
        if (s === 'cancelled') return 'secondary';
        return 'light text-dark';
    }
    function val(id) {
        const el = document.getElementById(id);
        return el ? el.value : '';
    }
    function fillItemForm(item) {
        setValue('itemId', item.id);
        setValue('itemName', item.name);
        setValue('itemPrice', item.price);
        setValue('itemImage', item.image);
        setValue('itemCategory', item.categoryId || '');
    }
    function clearItemForm() {
        setValue('itemId', '');
        setValue('itemName', '');
        setValue('itemPrice', '');
        setValue('itemImage', '');
        setValue('itemCategory', '');
    }
    function setValue(id, value) {
        const el = document.getElementById(id);
        if (el) el.value = value;
    }

    function categoryName(id) {
        const cats = get('qb_categories', []);
        const c = cats.find(x => x.id === id);
        return c ? c.name : 'Uncategorized';
    }

    function fillCategoryForm(c) {
        setValue('categoryId', c.id);
        setValue('categoryName', c.name);
        setValue('categorySlug', c.slug || '');
        setValue('categoryDescription', c.description || '');
    }
    function clearCategoryForm() {
        setValue('categoryId', '');
        setValue('categoryName', '');
        setValue('categorySlug', '');
        setValue('categoryDescription', '');
    }

    function showModal(modalEl) {
        if (!modalEl) return;
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.show();
    }
    function hideModal(modalEl) {
        if (!modalEl) return;
        const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
        modal.hide();
    }
})();


