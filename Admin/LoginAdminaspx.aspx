<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="LoginAdminaspx.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.LoginAdminaspx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body class="admin-login-body">
        <!-- Fixed alert container (outside the form layout) -->
        <div class="login-wrap container py-5">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5 col-xl-4">
                    <div class="card login-card shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-center mb-3">
                                <div class="login-logo mb-2"><i class="bi bi-shield-lock"></i></div>
                                <h4 class="fw-bold mb-0">QuickBite Admin</h4>
                                <div class="text-muted small">Sign in to continue</div>
                            </div>
                            <form id="adminLoginForm" novalidate>
                                <div class="fixed-alert-container">
                                    <asp:Panel ID="adminLoginAlert" runat="server" CssClass="alert alert-danger fixed-alert alert-dismissible fade show"
                                        Visible="false" role="alert">
                                        <strong>Invalid credentials</strong>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </asp:Panel>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Username</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <asp:TextBox ID="admintxtunm" runat="server" CssClass="form-control" placeholder="Enter Username"></asp:TextBox>

                                    </div>
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Username" ControlToValidate="admintxtunm" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <asp:TextBox ID="admintxtpwd" runat="server" CssClass="form-control" placeholder="••••••••" TextMode="Password"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Password" ControlToValidate="admintxtpwd" CssClass="text-danger small" Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="d-grid gap-2">
                                    <asp:Button ID="adminLoginBtn" runat="server" Text="Login" CssClass="btn btn-warning" OnClick="adminLoginBtn_Click" />
                                    <a href="../Home.aspx" class="btn btn-light">Back to site</a>
                                </div>
                            </form>
                        </div>
                    </div>
                    <%--<div class="text-center text-muted small mt-3">Tip: admin@quickbite.com / admin123</div>--%>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('adminLoginForm').addEventListener('submit', function (e) {
                e.preventDefault();
                const email = document.getElementById('admintxtunm').value.trim();
                const pass = document.getElementById('admintxtpwd').value;
                const ok = (email === 'admin@quickbite.com' && pass === 'admin123');
                const alertEl = document.getElementById('adminLoginAlert');

                if (ok) {
                    localStorage.setItem('qb_auth_user', JSON.stringify({ role: 'admin', email }));
                    window.location.href = 'Dashboard.aspx';
                } else {
                    // Show the alert using Bootstrap's JavaScript
                    var bsAlert = new bootstrap.Alert(alertEl);
                    alertEl.classList.remove('d-none');
                    alertEl.style.display = 'block';

                    // Auto-dismiss after 5 seconds
                    setTimeout(function () {
                        var bsAlert = bootstrap.Alert.getInstance(alertEl);
                        if (bsAlert) {
                            bsAlert.close();
                        }
                    }, 5000);
                }
            });

            // Fix for the server-side button click
            document.getElementById('<%= adminLoginBtn.ClientID %>').addEventListener('click', function () {
                document.getElementById('adminLoginForm').submit();
            });
        </script>
    </body>
</asp:Content>
