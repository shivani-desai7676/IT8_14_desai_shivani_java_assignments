<%-- 
    Document   : shop
    Created on : 22-Jan-2026, 11:15:37 am
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.store.util.DBConnection, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fashion Store | Collection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --accent-color: #dc3545; }
        body { background-color: #f8f9fa; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { background: #212529; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .product-card { border: none; border-radius: 15px; transition: transform 0.3s; box-shadow :0.3s; overflow: hidden; height: 100%; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        .product-img { height: 250px; object-fit: cover; background: #fff; }
        .badge-cart { position: absolute; top: -5px; right: -10px; font-size: 0.7rem; }
        .btn-add-cart { border-radius: 20px;font-size: 15px; font-weight: 400; text-transform: uppercase; letter-spacing: 1px; }
        .user-greeting { color: #adb5bd; font-size: 0.9rem; margin-right: 15px; }
    </style>
</head>
<body>

<%
    // Fetch user info from session (assuming "userName" was set during login)
   
    // Get cart count
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.values().stream().mapToInt(Integer::intValue).sum() : 0;
%>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-danger" href="shop.jsp">FASHION<span class="text-white">HUB</span></a>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <span class="user-greeting">Welcome, <span class="text-warning fw-bold"><%= session.getAttribute("user") %></span></span>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link position-relative btn btn-outline-secondary border-0" href="view_cart.jsp">
                        <i class="fas fa-shopping-bag fs-5 text-white"></i>
                        <% if(cartCount > 0) { %>
                            <span class="badge rounded-pill bg-danger badge-cart"><%= cartCount %></span>
                        <% } %>
                    </a>
                </li>
                <li class="nav-item">
                     <a href="${pageContext.request.contextPath}/LogoutServlet" class="nav-link text-warning">
                    Logout
                </a>
                    <!--<a class="btn btn-sm btn-outline-danger" href="LogoutServlet">Logout</a>-->
                </li>
            </ul>
        </div>
    </div>
</nav>

<header class="bg-dark text-white text-center py-5 mb-5" style="background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1350&q=80'); background-size: cover; background-position: center;">
    <div class="container py-4">
        <h1 class="display-4 fw-bold">Summer Collection 2026</h1>
        <p class="lead">Upgrade your style with our latest arrivals</p>
    </div>
</header>

<div class="container">
    <div class="row g-4">
        <% 
            try (Connection con = DBConnection.getConnection(); 
                 Statement st = con.createStatement(); 
                 ResultSet rs = st.executeQuery("SELECT * FROM product_master")) {
                while(rs.next()){ 
                    double price = rs.getDouble("price");
                    int pid = rs.getInt("product_id");
        %>
        <div class="col-sm-6 col-md-4 col-lg-3">
            <div class="card product-card">
                <img src="<%= rs.getString("image") %>" class="card-img-top product-img" alt="<%= rs.getString("product_name") %>" 
                     onerror="this.src='https://via.placeholder.com/250x250?text=No+Image'">
                <div class="card-body d-flex flex-column">
                    <h6 class="card-title fw-bold text-dark mb-1"><%= rs.getString("product_name") %></h6>
                    <!--<p class="text-muted small mb-2">Category ID: <%= rs.getInt("category_id") %></p>-->
                    <div class="mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="h5 mb-0 text-danger fw-bold">$<%= String.format("%.2f", price) %></span>
                            <span class="badge bg-light text-dark border"><%= rs.getInt("stock") %> left</span>
                        </div>
                        <form action="CartServlet" method="POST">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="p_id" value="<%= pid %>">
                            <button type="submit" class="btn btn-dark w-100 btn-add-cart">
                                <i class="fas fa-cart-plus me-2"></i> Add Cart
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% } } catch(Exception e) { out.print("<div class='alert alert-danger'>Error loading products.</div>"); } %>
    </div>
</div>

<footer class="py-5 bg-dark mt-5">
    <div class="container text-center">
        <p class="text-muted mb-0">&copy; 2026 Fashion Hub Store. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>