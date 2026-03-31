<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory Zen | Smart Edit</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --accent: #6366f1; --bg: #f8fafc; --border: #e2e8f0; }
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--bg); margin: 0; display: flex; min-height: 100vh; }
        .sidebar { width: 300px; background: white; border-right: 1px solid var(--border); padding: 30px; }
        .main-view { flex: 1; padding: 40px; }
        .card { background: white; border: 1px solid var(--border); border-radius: 20px; padding: 24px; margin-bottom: 24px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .input-group { margin-bottom: 15px; display: flex; flex-direction: column; gap: 5px; }
        label { font-size: 0.75rem; font-weight: 700; color: #64748b; }
        input, select { padding: 10px; border: 1px solid var(--border); border-radius: 10px; outline: none; }
        .btn { padding: 12px; border-radius: 10px; border: none; font-weight: 600; cursor: pointer; width: 100%; }
        .btn-primary { background: var(--accent); color: white; }
        .btn-update { background: #10b981; color: white; display: none; } /* Hidden by default */
        table { width: 100%; border-collapse: collapse; }
        td, th { padding: 15px; text-align: left; border-bottom: 1px solid #f1f5f9; }
        .icon-btn { cursor: pointer; background: none; border: none; font-size: 1.2rem; margin-right: 10px; }
    </style>

    <script>
        // FUNCTION: Fill form when Edit icon is clicked
        function fillForm(id, name, price, stock, catId) {
            document.getElementById("form-pid").value = id;
            document.getElementById("form-pname").value = name;
            document.getElementById("form-price").value = price;
            document.getElementById("form-stock").value = stock;
            document.getElementById("form-cid").value = catId;

            // Switch buttons: Hide 'Save', Show 'Update'
            document.getElementById("btn-save").style.display = "none";
            document.getElementById("btn-update").style.display = "block";
            
            // Set action to update
            document.getElementById("form-action").value = "updateProduct";
            
            // Scroll to form
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        window.onload = function() {
            <% if (request.getAttribute("products") == null) { %>
                window.location.href = "InventoryServlet";
            <% } %>
        };
    </script>
</head>
<body>

    <div class="sidebar">
        <h3>Categories</h3>
        <form action="InventoryServlet" method="post">
            <input type="hidden" name="action" value="addCategory">
            <div class="input-group"><label>ID</label><input type="number" name="cid" required></div>
            <div class="input-group"><label>Name</label><input type="text" name="cname" required></div>
            <button type="submit" class="btn btn-primary">Add Category</button>
        </form>
    </div>

    <div class="main-view">
        <div class="card">
            <h3 id="form-title">Product Details</h3>
            <form id="productForm" action="InventoryServlet" method="post">
                <input type="hidden" name="action" id="form-action" value="addProduct">
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;">
                    <div class="input-group"><label>Product ID</label><input type="number" name="pid" id="form-pid" required></div>
                    <div class="input-group"><label>Name</label><input type="text" name="pname" id="form-pname" required></div>
                    <div class="input-group">
                        <label>Category</label>
                        <select name="cid" id="form-cid">
                            <% List<String> cats = (List<String>) request.getAttribute("categories");
                               if(cats != null) for(String c : cats) {
                                   String[] d = c.split(":");
                                   out.println("<option value='"+d[0]+"'>"+d[1]+"</option>");
                               } %>
                        </select>
                    </div>
                    <div class="input-group"><label>Price</label><input type="number" step="0.01" name="price" id="form-price" required></div>
                    <div class="input-group"><label>Stock</label><input type="number" name="stock" id="form-stock" required></div>
                    <div class="input-group" style="justify-content: flex-end;">
                        <button type="submit" id="btn-save" class="btn btn-primary">Save Product</button>
                        <button type="submit" id="btn-update" class="btn btn-update">Update Product</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="card">
            <h3>Inventory List</h3>
            <table>
                <thead>
                    <tr><th>Product</th><th>Price</th><th>Stock</th><th>Category</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <% List<String> prods = (List<String>) request.getAttribute("products");
                       if (prods != null) {
                           for (String p : prods) {
                               String[] parts = p.split("\\|");
                               String id = parts[0].trim();
                               String name = parts[1].trim();
                               String price = parts[2].trim().replace("$", "");
                               String stock = parts[3].trim().split(" ")[0];
                               String cat = parts[4].trim();
                    %>
                    <tr>
                        <!--<td>#<%= id %></td>-->
                        <td><strong><%= name %></strong></td>
                        <td>$<%= price %></td>
                        <td><%= stock %></td>
                        <td><%= cat %></td>
                        <td>
                            <button class="icon-btn" onclick="fillForm('<%=id%>','<%=name%>','<%=price%>','<%=stock%>','1')">✏️</button>
                            
                            <form action="InventoryServlet" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="deleteProduct">
                                <input type="hidden" name="pid" value="<%= id %>">
                                <button type="submit" class="icon-btn">🗑️</button>
                            </form>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>