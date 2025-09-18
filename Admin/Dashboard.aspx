<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
                    <%--<button id="logoutBtn" class="btn btn-sm btn-warning">Logout</button>--%>
                    <asp:Button ID="Button1" runat="server" Text="Logout" class="btn btn-sm btn-warning" OnClick="Button1_Click" />
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <aside class="col-md-3 col-lg-2 bg-light sidebar p-0">
                    <div class="list-group list-group-flush">
                        <a href="Dashboard.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                        <a href="Orders.aspx" class="list-group-item list-group-item-action"><i class="bi bi-receipt-cutoff me-2"></i>Orders</a>
                        <a href="Add_Menu.aspx" class="list-group-item list-group-item-action"><i class="bi bi-card-checklist me-2"></i>Menu Items</a>
                        <a href="Add_Categories.aspx" class="list-group-item list-group-item-action"><i class="bi bi-tags me-2"></i>Categories</a>
                        <a href="Users.aspx" class="list-group-item list-group-item-action"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <h1 class="h3 mb-4">Dashboard</h1>
                    <div class="row g-3">
                        <div class="col-sm-6 col-lg-3">
                            <div class="card stat-card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="text-muted small">Today Orders</div>
                                            <div id="statOrders" class="h4 mb-0">0</div>
                                        </div>
                                        <i class="bi bi-bag-check fs-2 text-warning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <div class="card stat-card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="text-muted small">Revenue</div>
                                            <div id="statRevenue" class="h4 mb-0">₹0</div>
                                        </div>
                                        <i class="bi bi-currency-rupee fs-2 text-success"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <div class="card stat-card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="text-muted small">Menu Items</div>
                                            <div id="statMenu" class="h4 mb-0">0</div>
                                        </div>
                                        <i class="bi bi-list-ul fs-2 text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <div class="card stat-card">
                                <div class="card-body">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <div class="text-muted small">Users</div>
                                            <div id="statUsers" class="h4 mb-0">0</div>
                                        </div>
                                        <i class="bi bi-people fs-2 text-danger"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mt-4">
                        <div class="card-header">Recent Orders</div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-striped mb-0">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Customer</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody id="recentOrdersBody">
                                        <tr>
                                            <td colspan="5" class="text-center text-muted">No orders yet</td>
                                                     
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
</asp:Content>

