<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Orders" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-sm btn-warning" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
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

                <!-- Main content -->
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h1 class="h4 mb-0">Orders</h1>
                        <asp:Button ID="btnReport" runat="server" Text="Report Orders" OnClick="btnReport_Click" />     
                        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
                    </div>

                    <!-- Message Label -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>

                    <div class="card mt-3">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover align-middle mb-0"
                                    AutoGenerateColumns="False" DataKeyNames="Order_Id"
                                    OnRowCommand="GridView1_RowCommand"
                                    EmptyDataText="No orders found.">
                                    <HeaderStyle CssClass="table-light" />
                                    <Columns>
                                        <asp:BoundField DataField="Order_Id" HeaderText="Order ID" />
                                        <asp:BoundField DataField="User_Id" HeaderText="User ID" />
                                        <asp:BoundField DataField="Total_Amount" HeaderText="Total" DataFormatString="₹{0:0.00}" />
                                        <asp:BoundField DataField="Order_Status" HeaderText="Status" />
                                        <asp:BoundField DataField="Order_Date" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteOrder"
                                                    CommandArgument='<%# Eval("Order_Id") %>'
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    OnClientClick="return confirm('Are you sure you want to delete this order?');">
                                                    <i class="bi bi-trash"></i> Delete
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</asp:Content>