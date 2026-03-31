<%-- 
    Document   : view_cart
    Created on : 29-Jan-2026, 11:53:44 am
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.store.util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fashion Hub | My Bag</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .navbar { background: #212529; }
        .cart-container { background: white; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        .price-tag { color: #dc3545; font-weight: bold; }
        .summary-card { border: none; border-radius: 15px; background: #212529; color: white; }
        .remove-btn { transition: all 0.2s; color: #adb5bd; }
        .remove-btn:hover { color: #dc3545 !important; transform: scale(1.1); }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark mb-5">
    <div class="container">
        <a class="navbar-brand fw-bold text-danger" href="shop.jsp">FASHION<span class="text-white">HUB</span></a>
        <div class="ms-auto">
            <a href="shop.jsp" class="btn btn-outline-light btn-sm">Continue Shopping</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="p-4 cart-container">
                <h4 class="mb-4 fw-bold">Your Bag</h4>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr class="text-muted small">
                                <th>Product</th>
                                <th>Price</th>
                                <th>Discount</th>
                                <th>Total</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                Object userIdObj = session.getAttribute("user_id");
                                double grandTotal = 0;
                                boolean hasItems = false;
                                
                                if (userIdObj != null) {
                                    int userId = (int) userIdObj;
                                    String sql = "SELECT d.*, p.product_name FROM order_details d " +
                                                 "JOIN order_master m ON d.order_id = m.order_id " +
                                                 "JOIN product_master p ON d.product_id = p.product_id " +
                                                 "WHERE m.user_id = ? AND m.order_status = 'Pending'";

                                    try (Connection con = DBConnection.getConnection();
                                         PreparedStatement ps = con.prepareStatement(sql)) {
                                        ps.setInt(1, userId);
                                        ResultSet rs = ps.executeQuery();
                                        while(rs.next()) {
                                            hasItems = true;
                                            double sub = rs.getDouble("product_price") - rs.getDouble("discount");
                                            grandTotal += sub;
                            %>
                            <tr>
                                <td><strong><%= rs.getString("product_name") %></strong></td>
                                <td>$<%= rs.getDouble("product_price") %></td>
                                <td class="text-danger">-$<%= rs.getDouble("discount") %></td>
                                <td class="price-tag">$<%= String.format("%.2f", sub) %></td>
                                <td class="text-center">
                                    <form action="CartServlet" method="POST">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="p_id" value="<%= rs.getInt("product_id") %>">
                                        <button type="submit" class="btn btn-link remove-btn shadow-none">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%      }
                                    if(!hasItems) { %>
                                        <tr><td colspan="5" class="text-center py-5">Your bag is empty.</td></tr>
                            <%      }
                                    } catch(Exception e) { e.printStackTrace(); }
                                } else { response.sendRedirect("login.jsp"); } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card summary-card p-4">
                <h5 class="mb-4">Order Summary</h5>
                <div class="d-flex justify-content-between mb-3">
                    <span>Subtotal</span>
                    <span>$<%= String.format("%.2f", grandTotal) %></span>
                </div>
                <hr>
                <div class="d-flex justify-content-between mb-4 h5">
                    <span>Total (Inc. Tax)</span>
                    <span class="price-tag">$<%= String.format("%.2f", grandTotal * 1.05) %></span>
                </div>
                <form action="BillingServlet" method="POST">
                    <select name="pay_mode" class="form-select mb-3 bg-dark text-white border-secondary">
                        <option value="Cash">Cash on Delivery</option>
                        <option value="Card">Credit Card</option>
                    </select>
                    <button type="submit" class="btn btn-danger w-100 py-3 fw-bold" <%= !hasItems?"disabled":"" %>>
                        PROCEED TO CHECKOUT
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>