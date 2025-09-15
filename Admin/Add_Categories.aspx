<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Add_Categories.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Add_Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" class="btn btn-sm btn-warning" OnClick="btnLogout_Click" />
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
                        <a href="Add_Categories.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-tags me-2"></i>Categories</a>
                        <a href="Users.aspx" class="list-group-item list-group-item-action"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h1 class="h4 mb-0">Categories</h1>
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#categoryModal">
                            <i class="bi bi-plus-circle me-1"></i>Add Category
                        </button>
                    </div>

                    <div class="card">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" 
                                    CssClass="table table-hover align-middle mb-0" DataKeyNames="CategoryId">
                                    <Columns>
                                        <asp:BoundField DataField="CategoryId" HeaderText="ID" ReadOnly="true" />
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Slug">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSlug" runat="server" Text='<%# Eval("Slug") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">No categories found</td>
                                        </tr>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                    <!-- Add Category Modal -->
                    <div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Add Category</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Name *</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Slug *</label>
                                        <asp:TextBox ID="txtSlug" runat="server" CssClass="form-control" placeholder="e.g., starters" required></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description *</label>
                                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" required></asp:TextBox>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <asp:Button ID="btnSave" runat="server" Text="Save Category" 
                                        CssClass="btn btn-warning" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

       <%-- <script>
            // Auto-generate slug from category name
            document.getElementById('<%= txtName.ClientID %>').addEventListener('input', function () {
                const name = this.value;
                const slug = name.toLowerCase()
                    .replace(/[^a-z0-9\s-]/g, '')
                    .replace(/\s+/g, '-')
                    .replace(/-+/g, '-')
                    .trim();
                document.getElementById('<%= txtSlug.ClientID %>').value = slug;
            });
        </script>--%>
    </body>
</asp:Content>