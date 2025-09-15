<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
                   <%-- <button id="logoutBtn" class="btn btn-sm btn-warning">Logout</button>--%>
                    <asp:Button ID="Button1" runat="server" Text="Logout" class="btn btn-sm btn-warning" OnClick="Button1_Click" />
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <aside class="col-md-3 col-lg-2 bg-light sidebar p-0">
                    <div class="list-group list-group-flush">
                        <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                        <a href="Orders.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-receipt-cutoff me-2"></i>Orders</a>
                        <a href="Add_Menu.aspx" class="list-group-item list-group-item-action"><i class="bi bi-card-checklist me-2"></i>Menu Items</a>
                        <a href="Add_Categories.aspx" class="list-group-item list-group-item-action"><i class="bi bi-tags me-2"></i>Categories</a>
                        <a href="Users.aspx" class="list-group-item list-group-item-action"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h1 class="h4 mb-0">Orders</h1>
                        <div class="input-group" style="max-width: 320px;">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input id="orderSearch" type="text" class="form-control" placeholder="Search orders">
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Date</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="ordersTableBody">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">No orders to show</td>
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

