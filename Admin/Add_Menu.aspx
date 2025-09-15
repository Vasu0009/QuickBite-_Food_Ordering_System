<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/admin.Master" AutoEventWireup="true" CodeBehind="Add_Menu.aspx.cs" Inherits="QuickBite__Food_Ordering_System.Admin.Add_MenuAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <body>
        <nav class="navbar navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold" href="Dashboard.aspx">QuickBite Admin</a>
                <div class="d-flex align-items-center gap-3">
                    <a class="btn btn-sm btn-outline-light" href="../Home.aspx">View Site</a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" class="btn btn-sm btn-warning" />
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="row">
                <aside class="col-md-3 col-lg-2 bg-light sidebar p-0">
                    <div class="list-group list-group-flush">
                        <a href="Dashboard.aspx" class="list-group-item list-group-item-action"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                        <a href="Orders.aspx" class="list-group-item list-group-item-action"><i class="bi bi-receipt-cutoff me-2"></i>Orders</a>
                        <a href="Add_Menu.aspx" class="list-group-item list-group-item-action active"><i class="bi bi-card-checklist me-2"></i>Menu Items</a>
                        <a href="Add_Categories.aspx" class="list-group-item list-group-item-action"><i class="bi bi-tags me-2"></i>Categories</a>
                        <a href="Users.aspx" class="list-group-item list-group-item-action"><i class="bi bi-people me-2"></i>Users</a>
                        <a href="Reports.aspx" class="list-group-item list-group-item-action"><i class="bi bi-graph-up me-2"></i>Reports</a>
                    </div>
                </aside>
                <main class="col-md-9 col-lg-10 ms-sm-auto px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h1 class="h4 mb-0">Menu Items</h1>
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#menuModal">
                            <i class="bi bi-plus-circle me-1"></i>Add Menu Item
                        </button>
                    </div>

                    <div class="card">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <asp:GridView ID="gvMenuItems" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover align-middle mb-0" DataKeyNames="Id">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="true" />
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Price">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrice" runat="server" Text='<%# "₹" + Eval("Price") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Image">
                                            <ItemTemplate>
                                                <asp:Image ID="imgItem" runat="server" ImageUrl='<%# Eval("Image") %>'
                                                    CssClass="img-thumbnail" Width="60" Height="60" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-outline-primary me-1"
                                                    CommandArgument='<%# Eval("Id") %>' />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm btn-outline-danger"
                                                    CommandArgument='<%# Eval("Id") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this menu item?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">No menu items found</td>
                                        </tr>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                    <!-- Add Menu Item Modal -->
                    <div class="modal fade" id="menuModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">
                                        <asp:Label ID="lblModalTitle" runat="server" Text="Add Menu Item"></asp:Label>
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <asp:HiddenField ID="hdnItemId" runat="server" Value="0" />
                                    <div class="mb-3">
                                        <label class="form-label">Name *</label>
                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Price (₹) *</label>
                                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" step="0.01" min="0" required></asp:TextBox>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Category *</label>
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" required
                                            OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Image *</label>
                                        <asp:FileUpload ID="fldimg" runat="server" CssClass="form-control" required />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description *</label>
                                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" required></asp:TextBox>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <asp:Button ID="btnSave" runat="server" Text="Save Item"
                                        CssClass="btn btn-warning" OnClick="btnSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            // Function to show the modal
            function showModal() {
                var myModal = new bootstrap.Modal(document.getElementById('menuModal'));
                myModal.show();
            }

            // Function to close the modal
            function closeModal() {
                var myModalEl = document.getElementById('menuModal');
                var modal = bootstrap.Modal.getInstance(myModalEl);
                modal.hide();
            }
        </script>
    </body>
</asp:Content>
