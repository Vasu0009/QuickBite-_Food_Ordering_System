<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Users" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sidebar { min-height: 100vh; }
        .gridview-custom { width: 100%; }
        .gridview-custom th { background-color: #f8f9fa; font-weight: 600; }
    </style>
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
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
                        <a href="Users.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h1 class="h4 mb-0">Users Management</h1>
                        <div class="d-flex gap-2 align-items-center">
                            <asp:Label ID="lblTotalUsers" runat="server" CssClass="badge bg-primary fs-6" Text="Total Users: 0"></asp:Label>
                            <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click" />
                            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
                            <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="btn btn-sm btn-outline-primary" OnClick="btnRefresh_Click" />
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-body">
                            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-dismissible fade show" role="alert">
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </asp:Panel>
                            
                            <div class="table-responsive">
                                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-hover table-striped align-middle gridview-custom" EmptyDataText="No users registered yet." OnRowDeleting="gvUsers_RowDeleting" OnRowDataBound="gvUsers_RowDataBound" DataKeyNames="Id" AllowPaging="True"  PageSize="10"
                                    OnPageIndexChanging="gvUsers_PageIndexChanging">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="True" />
                                        <asp:BoundField DataField="First_Name" HeaderText="First Name" />
                                        <asp:BoundField DataField="Last_Name" HeaderText="Last Name" />
                                        <asp:BoundField DataField="Email_Address" HeaderText="Email" />
                                        <asp:BoundField DataField="Phone_Number" HeaderText="Phone" />
                                        <asp:BoundField DataField="Delivery_Address" HeaderText="Address" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />
                                    <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                                    <HeaderStyle BackColor="#f8f9fa" ForeColor="#212529" Font-Bold="True" />
                                    <RowStyle BackColor="White" />
                                    <AlternatingRowStyle BackColor="#f8f9fa" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</asp:Content>