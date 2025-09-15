<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
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
                        <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                        <a href="Orders.aspx" class="list-group-item list-group-item-action"><i class="bi bi-receipt-cutoff me-2"></i>Orders</a>
                        <a href="Add_Menu.aspx" class="list-group-item list-group-item-action"><i class="bi bi-card-checklist me-2"></i>Menu Items</a>
                        <a href="Add_Categories.aspx" class="list-group-item list-group-item-action"><i class="bi bi-tags me-2"></i>Categories</a>
                        <a href="Users.aspx" class="list-group-item list-group-item-action"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                        <a href="Settings.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-gear me-2"></i>Settings</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <h1 class="h4 mb-4">Business Settings</h1>
                    <div class="card">
                        <div class="card-body">
                            <form id="settingsForm">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Business Name</label>
                                        <input id="setName" type="text" class="form-control" placeholder="QuickBite">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Support Email</label>
                                        <input id="setEmail" type="email" class="form-control" placeholder="support@quickbite.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Phone</label>
                                        <input id="setPhone" type="text" class="form-control" placeholder="+91 99999 55555">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Business Hours</label>
                                        <input id="setHours" type="text" class="form-control" placeholder="Mon-Sun 10:00 AM - 11:00 PM">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Address</label>
                                        <textarea id="setAddress" class="form-control" rows="2" placeholder="Street, City, State, ZIP"></textarea>
                                    </div>
                                </div>
                                <div class="mt-4 d-flex gap-2">
                                    <button id="saveSettingsBtn" type="button" class="btn btn-warning">Save Settings</button>
                                    <div id="settingsSavedMsg" class="text-success d-none">Saved!</div>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>
</asp:Content>

