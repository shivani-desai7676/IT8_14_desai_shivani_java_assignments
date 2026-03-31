<%-- 
    Document   : invoice
    Created on : 03-Feb-2026, 11:26:12 am
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.store.util.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice | Fashion Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .invoice-box { padding: 30px; border: 1px solid #eee; background: #fff; border-radius: 10px; margin-top: 50px; }
        .paid-stamp { color: green; border: 3px solid green; display: inline-block; padding: 5px 15px; font-weight: bold; transform: rotate(-10deg); }
    </style>
</head>
<body class="bg-light">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 invoice-box shadow">
            <div class="d-flex justify-content-between">
                <div>
                    <h2 class="text-danger fw-bold">FASHION HUB</h2>
                    <p class="text-muted">Invoice No: #<%= request.getParameter("oid") %></p>
                </div>
                <div class="text-end">
                    <div class="paid-stamp">PAID</div>
                    <p class="mt-2 text-muted">Date: <%= new java.util.Date() %></p>
                </div>
            </div>
            <hr>
            <table class="table table-borderless">
                <thead>
                    <tr class="border-bottom">
                        <th>Description</th>
                        <th class="text-end">Price</th>
                        <th class="text-end">Discount</th>
                        <th class="text-end">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int oid = Integer.parseInt(request.getParameter("oid"));
                        double subTotal = 0;
                        try (Connection con = DBConnection.getConnection()) {
                            String sql = "SELECT d.*, p.product_name FROM order_details d JOIN product_master p ON d.product_id = p.product_id WHERE d.order_id = ?";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setInt(1, oid);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()) {
                                double lineTotal = rs.getDouble("product_price") - rs.getDouble("discount");
                                subTotal += lineTotal;
                    %>
                    <tr>
                        <td><%= rs.getString("product_name") %></td>
                        <td class="text-end">$<%= rs.getDouble("product_price") %></td>
                        <td class="text-end">-$<%= rs.getDouble("discount") %></td>
                        <td class="text-end">$<%= lineTotal %></td>
                    </tr>
                    <%      }
                        } catch(Exception e) {} %>
                </tbody>
            </table>
            <div class="row justify-content-end">
                <div class="col-md-4 text-end">
                    <p>Subtotal: <strong>$<%= subTotal %></strong></p>
                    <p>Tax (5%): <strong>$<%= subTotal * 0.05 %></strong></p>
                    <h4 class="text-danger">Total: $<%= subTotal * 1.05 %></h4>
                </div>
            </div>
            <hr>
            <div class="text-center mt-4 no-print">
                <button onclick="window.print()" class="btn btn-dark">Print Bill</button>
                <a href="shop.jsp" class="btn btn-outline-danger">Back to Shop</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>