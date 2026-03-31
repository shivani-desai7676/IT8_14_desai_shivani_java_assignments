<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.store.util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Fashion Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; }
        .sidebar { min-height: 100vh; background: #212529; color: white; padding-top: 20px; }
        .nav-link { color: #adb5bd; border: none; width: 100%; text-align: left; margin-bottom: 5px; }
        .nav-link.active { background-color: #dc3545 !important; color: white !important; }
        .master-card { border: none; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); background: white; }
        .scroll-table { max-height: 450px; overflow-y: auto; }
        .search-box { margin-bottom: 15px; border-radius: 20px; border: 1px solid #dc3545; padding-left: 15px; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <h5 class="text-center fw-bold mb-4 text-danger">FASHION ADMIN</h5>
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist">
                <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#cat-tab">Category Master</button>
                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#prod-tab">Product Master</button>
                <hr>
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-link text-warning">
                    Logout
                </a>
                <!--<a href="LogoutServlet" class="nav-link text-warning">Logout</a>-->
            </div>
        </div>

        <div class="col-md-10 p-4">
            <div class="tab-content">
                
                <div class="tab-pane fade show active" id="cat-tab">
                    <h4 class="mb-4">Category Management</h4>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card master-card p-4">
                                <h6 class="fw-bold text-primary" id="cat-form-title">Add New Category</h6>
                                <form action="AdminServlet" method="POST" id="catForm">
                                    <input type="hidden" name="action" value="upsertCategory">
                                    <input type="hidden" name="id" id="cat_id" value=""> 
                                    
                                    <div class="mb-3">
                                        <label class="small fw-bold">Category Name</label>
                                        <input type="text" name="cat_name" id="cat_name" class="form-control" placeholder="e.g. Footwear" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="small fw-bold">Parent Category ID</label>
                                        <input type="number" name="parent_id" id="parent_id" class="form-control" value="0">
                                    </div>
                                    <button type="submit" class="btn btn-dark w-100">Save Category</button>
                                    <button type="button" onclick="resetCatForm()" class="btn btn-outline-secondary btn-sm w-100 mt-2">Clear / Add New</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control search-box" id="catSearch" onkeyup="filterTable('catSearch', 'catTable')" placeholder="Search Category by Name...">
                            <div class="card master-card p-4 scroll-table">
                                <table class="table table-hover align-middle" id="catTable">
                                    <thead class="table-light"><tr><th>ID</th><th>Name</th><th>Parent</th><th class="text-center">Action</th></tr></thead>
                                    <tbody>
                                        <% try (Connection con = DBConnection.getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery("SELECT * FROM category_master")) {
                                            while(rs.next()){ %>
                                        <tr>
                                            <td><%= rs.getInt(1) %></td>
                                            <td class="search-target"><%= rs.getString(2) %></td>
                                            <td><%= rs.getInt(3) %></td>
                                            <td class="text-center">
                                                <button title="Edit" class="btn btn-sm btn-info text-white me-1" onclick="editCategory('<%=rs.getInt(1)%>','<%=rs.getString(2)%>','<%=rs.getInt(3)%>')"><i class="fas fa-edit"></i></button>
                                                <a title="Delete" href="AdminServlet?action=delCat&id=<%= rs.getInt(1) %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this category?')"><i class="fas fa-trash"></i></a>
                                            </td>
                                        </tr>
                                        <% } } catch(Exception e) { out.print("Error: " + e.getMessage()); } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="prod-tab">
                    <h4 class="mb-4">Product Management</h4>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card master-card p-4">
                                <h6 class="fw-bold text-danger" id="prod-form-title">Add New Product</h6>
                                <form action="AdminServlet" method="POST" id="prodForm">
                                    <input type="hidden" name="action" value="upsertProduct">
                                    <input type="hidden" name="id" id="p_id" value="">
                                    
                                    <div class="mb-2"><label class="small fw-bold">Product Name</label><input type="text" name="p_name" id="p_name" class="form-control" required></div>
                                    <div class="mb-2">
                                        <label class="small fw-bold">Category</label>
                                        <select name="p_cat" id="p_cat" class="form-select" required>
                                            <option value="">-- Select Category --</option>
                                            <% try (Connection con = DBConnection.getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery("SELECT * FROM category_master")) {
                                                while(rs.next()){ out.print("<option value='"+rs.getInt(1)+"'>"+rs.getString(2)+"</option>"); }
                                            } catch(Exception e) { } %>
                                        </select>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 mb-2"><label class="small fw-bold">Price</label><input type="number" step="0.01" name="p_price" id="p_price" class="form-control" required></div>
                                        <div class="col-6 mb-2"><label class="small fw-bold">Unit</label><input type="text" name="p_unit" id="p_unit" class="form-control" placeholder="pcs"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6 mb-2"><label class="small fw-bold">Discount %</label><input type="number" name="p_disc" id="p_disc" class="form-control" value="0"></div>
                                        <div class="col-6 mb-2"><label class="small fw-bold">Stock</label><input type="number" name="p_stock" id="p_stock" class="form-control" required></div>
                                    </div>
                                    <div class="mb-3"><label class="small fw-bold">Image URL</label><input type="text" name="p_img" id="p_img" class="form-control"></div>
                                    <button type="submit" class="btn btn-danger w-100">Save Product</button>
                                    <button type="button" onclick="resetProdForm()" class="btn btn-outline-secondary btn-sm w-100 mt-2">Clear / Add New</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" class="form-control search-box" id="prodSearch" onkeyup="filterTable('prodSearch', 'prodTable')" placeholder="Search Product by Name...">
                            <div class="card master-card p-4 scroll-table">
                                <table class="table table-hover align-middle small" id="prodTable">
                                    <thead class="table-dark"><tr><th>Name</th><th>Price</th><th>Stock</th><th class="text-center">Action</th></tr></thead>
                                    <tbody>
                                        <% try (Connection con = DBConnection.getConnection(); Statement st = con.createStatement(); ResultSet rs = st.executeQuery("SELECT * FROM product_master")) {
                                            while(rs.next()){ %>
                                        <tr>
                                            <td class="search-target"><%= rs.getString("product_name") %></td>
                                            <td>$<%= rs.getDouble("price") %></td>
                                            <td><%= rs.getInt("stock") %></td>
                                            <td class="text-center">
                                                <button class="btn btn-sm btn-info text-white me-1" onclick="editProduct('<%=rs.getInt(1)%>','<%=rs.getString(2)%>','<%=rs.getDouble(3)%>','<%=rs.getString(4)%>','<%=rs.getDouble(5)%>','<%=rs.getInt(7)%>','<%=rs.getInt(8)%>','<%=rs.getString(6)%>')"><i class="fas fa-edit"></i></button>
                                                <a href="AdminServlet?action=delProd&id=<%= rs.getInt(1) %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this product?')"><i class="fas fa-trash"></i></a>
                                            </td>
                                        </tr>
                                        <% } } catch(Exception e) { } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script>
    // FIND / FILTER Logic
    function filterTable(inputId, tableId) {
        let input = document.getElementById(inputId).value.toUpperCase();
        let rows = document.getElementById(tableId).getElementsByTagName("tr");
        
        for (let i = 1; i < rows.length; i++) {
            // Searches within the specific 'search-target' column (Name column)
            let cell = rows[i].querySelector(".search-target");
            if (cell) {
                let textValue = cell.textContent || cell.innerText;
                rows[i].style.display = textValue.toUpperCase().indexOf(input) > -1 ? "" : "none";
            }
        }
    }

    // UPDATE Logic (Load Data into Form)
    function editCategory(id, name, parent) {
        document.getElementById('cat-form-title').innerText = "Update Category (ID: " + id + ")";
        document.getElementById('cat_id').value = id;
        document.getElementById('cat_name').value = name;
        document.getElementById('parent_id').value = parent;
        window.scrollTo(0,0); // Scroll up to show form
    }

    function editProduct(id, name, price, unit, disc, cat, stock, img) {
        document.getElementById('prod-form-title').innerText = "Update Product (ID: " + id + ")";
        document.getElementById('p_id').value = id;
        document.getElementById('p_name').value = name;
        document.getElementById('p_price').value = price;
        document.getElementById('p_unit').value = unit;
        document.getElementById('p_disc').value = disc;
        document.getElementById('p_cat').value = cat;
        document.getElementById('p_stock').value = stock;
        document.getElementById('p_img').value = img;
        // Switch tab if necessary and scroll
        document.querySelector('[data-bs-target="#prod-tab"]').click();
        window.scrollTo(0,0);
    }

    // RESET / INSERT Mode Logic
    function resetCatForm() {
        document.getElementById('cat-form-title').innerText = "Add New Category";
        document.getElementById('cat_id').value = ""; // Crucial for Insert
        document.getElementById('catForm').reset();
    }

    function resetProdForm() {
        document.getElementById('prod-form-title').innerText = "Add New Product";
        document.getElementById('p_id').value = ""; // Crucial for Insert
        document.getElementById('prodForm').reset();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>