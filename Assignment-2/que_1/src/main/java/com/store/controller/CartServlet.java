/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
//package com.store.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.HashMap;
//import java.util.Map;
//
///**
// *
// * @author root
// */
//@WebServlet("/CartServlet")
//public class CartServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        // Map<ProductID, Quantity>
//        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
//        if (cart == null) cart = new HashMap<>();
//
//        String action = request.getParameter("action");
//        int pId = Integer.parseInt(request.getParameter("p_id"));
//
//        if("add".equals(action)) {
//            cart.put(pId, cart.getOrDefault(pId, 0) + 1);
//        } else if ("update".equals(action)) {
//            int qty = Integer.parseInt(request.getParameter("qty"));
//            if (qty > 0) cart.put(pId, qty); else cart.remove(pId);
//        } else if ("delete".equals(action)) {
//            cart.remove(pId);
//        }
//
//        session.setAttribute("cart", cart);
//        response.sendRedirect("view_cart.jsp");
//    }
//}


//package com.store.controller;
//
//import com.store.util.DBConnection;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.sql.*;
//
//@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
//public class CartServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        String sessionId = session.getId();
//        
//        String action = request.getParameter("action");
//        int pId = Integer.parseInt(request.getParameter("p_id"));
//
//        try (Connection con = DBConnection.getConnection()) {
//            // 1. Ensure an 'order_master' exists for this session
//            int orderId = getOrCreateOrderId(con, sessionId);
//
//            if ("add".equals(action)) {
//                // Fetch product price/discount from product_master first
//                double price = 0;
//                double disc = 0;
//                try (PreparedStatement psP = con.prepareStatement("SELECT price, discount FROM product_master WHERE product_id=?")) {
//                    psP.setInt(1, pId);
//                    ResultSet rsP = psP.executeQuery();
//                    if(rsP.next()) { price = rsP.getDouble("price"); disc = rsP.getDouble("discount"); }
//                }
//
//                // Check if item already in order_details
//                String checkSql = "SELECT order_detail_id FROM order_details WHERE order_id=? AND product_id=?";
//                PreparedStatement psCheck = con.prepareStatement(checkSql);
//                psCheck.setInt(1, orderId);
//                psCheck.setInt(2, pId);
//                ResultSet rsCheck = psCheck.executeQuery();
//
//                if (rsCheck.next()) {
//                    // Update existing quantity (You might need a quantity column in order_details or treat one row as one item)
//                    // If your table doesn't have 'qty', you'd insert multiple rows. Assuming you want to update price/disc:
//                    updateDetail(con, orderId, pId, price, disc);
//                } else {
//                    // Insert new detail
//                    String insDetail = "INSERT INTO order_details (order_id, product_id, product_price, discount) VALUES (?, ?, ?, ?)";
//                    PreparedStatement psIns = con.prepareStatement(insDetail);
//                    psIns.setInt(1, orderId);
//                    psIns.setInt(2, pId);
//                    psIns.setDouble(3, price);
//                    psIns.setDouble(4, disc);
//                    psIns.executeUpdate();
//                }
//            } 
//            else if ("delete".equals(action)) {
//                String delSql = "DELETE FROM order_details WHERE order_id=? AND product_id=?";
//                PreparedStatement psDel = con.prepareStatement(delSql);
//                psDel.setInt(1, orderId);
//                psDel.setInt(2, pId);
//                psDel.executeUpdate();
//            }
//
//            // Update the master total after changes
//            updateMasterTotal(con, orderId);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        response.sendRedirect("view_cart.jsp");
//    }
//
//    private int getOrCreateOrderId(Connection con, String sessId) throws SQLException {
//        String sql = "SELECT order_id FROM order_master WHERE session_id=? AND order_status='Pending'";
//        PreparedStatement ps = con.prepareStatement(sql);
//        ps.setString(1, sessId);
//        ResultSet rs = ps.executeQuery();
//        if (rs.next()) return rs.getInt("order_id");
//
//        // Create new master record if none exists
//        String ins = "INSERT INTO order_master (order_datetime, session_id, order_status, total_amount, tax) VALUES (NOW(), ?, 'Pending', 0, 0)";
//        PreparedStatement psIns = con.prepareStatement(ins, Statement.RETURN_GENERATED_KEYS);
//        psIns.setString(1, sessId);
//        psIns.executeUpdate();
//        ResultSet keys = psIns.getGeneratedKeys();
//        keys.next();
//        return keys.getInt(1);
//    }
//
//    private void updateMasterTotal(Connection con, int orderId) throws SQLException {
//        // Calculate sum of (price - discount) from details
//        String sumSql = "SELECT SUM(product_price - discount) as total FROM order_details WHERE order_id=?";
//        PreparedStatement psSum = con.prepareStatement(sumSql);
//        psSum.setInt(1, orderId);
//        ResultSet rs = psSum.executeQuery();
//        double total = 0;
//        if(rs.next()) total = rs.getDouble("total");
//        
//        double tax = total * 0.05; // 5% tax example
//        
//        String upMaster = "UPDATE order_master SET total_amount=?, tax=? WHERE order_id=?";
//        PreparedStatement psUp = con.prepareStatement(upMaster);
//        psUp.setDouble(1, total + tax);
//        psUp.setDouble(2, tax);
//        psUp.setInt(3, orderId);
//        psUp.executeUpdate();
//    }
//
//    private void updateDetail(Connection con, int orderId, int pId, double price, double disc) {
//        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
//    }
//}

package com.store.controller;

import com.store.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Use user_id for persistence
        Object userIdObj = session.getAttribute("user_id");
        if (userIdObj == null) {
            response.sendRedirect("login.jsp?err=session");
            return;
        }
        int userId = (int) userIdObj;
        
        String action = request.getParameter("action");
        String pIdStr = request.getParameter("p_id");
        if (pIdStr == null) { response.sendRedirect("shop.jsp"); return; }
        int pId = Integer.parseInt(pIdStr);

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);
            
            // 1. Get or Create the 'Pending' order for this USER
            int orderId = getOrCreateOrderId(con, userId);

            if ("add".equals(action)) {
                // Fetch price/discount from product_master
                double price = 0, disc = 0;
                try (PreparedStatement psP = con.prepareStatement("SELECT price, discount FROM product_master WHERE product_id=?")) {
                    psP.setInt(1, pId);
                    ResultSet rsP = psP.executeQuery();
                    if(rsP.next()) {
                        price = rsP.getDouble("price");
                        disc = rsP.getDouble("discount");
                    }
                }

                // Insert into order_details (One row per 'Add to Cart' click)
                String insDetail = "INSERT INTO order_details (order_id, product_id, product_price, discount) VALUES (?, ?, ?, ?)";
                try (PreparedStatement psIns = con.prepareStatement(insDetail)) {
                    psIns.setInt(1, orderId);
                    psIns.setInt(2, pId);
                    psIns.setDouble(3, price);
                    psIns.setDouble(4, disc);
                    psIns.executeUpdate();
                }
            } 
            else if ("delete".equals(action)) {
                // Remove ONLY ONE instance of the product from the cart
                String delSql = "DELETE FROM order_details WHERE order_id=? AND product_id=? LIMIT 1";
                try (PreparedStatement psDel = con.prepareStatement(delSql)) {
                    psDel.setInt(1, orderId);
                    psDel.setInt(2, pId);
                    psDel.executeUpdate();
                }
            }

            updateMasterTotal(con, orderId);
            con.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("view_cart.jsp");
    }


    private void updateMasterTotal(Connection con, int orderId) throws SQLException {
        String sumSql = "SELECT SUM(product_price - discount) as total FROM order_details WHERE order_id=?";
        try (PreparedStatement psSum = con.prepareStatement(sumSql)) {
            psSum.setInt(1, orderId);
            ResultSet rs = psSum.executeQuery();
            double total = 0;
            if(rs.next()) total = rs.getDouble("total");
            
            double tax = total * 0.05; 
            String upMaster = "UPDATE order_master SET total_amount=?, tax=? WHERE order_id=?";
            try (PreparedStatement psUp = con.prepareStatement(upMaster)) {
                psUp.setDouble(1, total + tax);
                psUp.setDouble(2, tax);
                psUp.setInt(3, orderId);
                psUp.executeUpdate();
            }
        }
    }
    
    // Inside CartServlet.java
    private int getOrCreateOrderId(Connection con, int userId) throws SQLException {
        // 1. Search for existing pending order for THIS specific user
        String sql = "SELECT order_id FROM order_master WHERE user_id=? AND order_status='Pending'";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) return rs.getInt("order_id");

        // 2. If not found, create it with the userId
        String ins = "INSERT INTO order_master (order_datetime, user_id, order_status, total_amount, tax) VALUES (NOW(), ?, 'Pending', 0, 0)";
        PreparedStatement psIns = con.prepareStatement(ins, Statement.RETURN_GENERATED_KEYS);
        psIns.setInt(1, userId); // <--- THIS LINE IS CRITICAL
        psIns.executeUpdate();

        ResultSet keys = psIns.getGeneratedKeys();
        keys.next();
        return keys.getInt(1);
    }
}