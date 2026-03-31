/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
//package com.store.controller;
//
//import com.store.util.DBConnection;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.sql.*;
//
//@WebServlet("/BillingServlet")
//public class BillingServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Integer userId = (Integer) session.getAttribute("user_id");
//        String payMode = request.getParameter("pay_mode");
//        
//        if (userId == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        try (Connection con = DBConnection.getConnection()) {
//            // 1. Find the current Pending order for this user
//            String findSql = "SELECT order_id FROM order_master WHERE user_id=? AND order_status='Pending'";
//            PreparedStatement psFind = con.prepareStatement(findSql);
//            psFind.setInt(1, userId);
//            ResultSet rs = psFind.executeQuery();
//
//            if (rs.next()) {
//                int orderId = rs.getInt("order_id");
//
//                // 2. Update status to 'Paid' and set payment mode
//                // This "stores the bill with status of payment" as per your requirement
//                String updateSql = "UPDATE order_master SET order_status='Paid', payment_mode=?, order_datetime=NOW() WHERE order_id=?";
//                PreparedStatement psUp = con.prepareStatement(updateSql);
//                psUp.setString(1, payMode);
//                psUp.setInt(2, orderId);
//                psUp.executeUpdate();
//
//                // 3. Redirect to the Invoice/Bill Preparation page
//                response.sendRedirect("invoice.jsp?oid=" + orderId);
//            } else {
//                // If no pending order found, user might have refreshed or cart is empty
//                response.sendRedirect("shop.jsp");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendRedirect("view_cart.jsp?err=billing_failed");
//        }
//    }
//}

package com.store.controller;

import com.store.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 1. Get User ID from Session
        Object userIdObj = session.getAttribute("user_id");
        if (userIdObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = (int) userIdObj;
        String payMode = request.getParameter("pay_mode");

        try (Connection con = DBConnection.getConnection()) {
            // 2. Find the Pending Order
            // Double check: Is your column name 'user_id' and status 'Pending'?
            String findSql = "SELECT order_id FROM order_master WHERE user_id=? AND order_status='Pending'";
            PreparedStatement psFind = con.prepareStatement(findSql);
            psFind.setInt(1, userId);
            ResultSet rs = psFind.executeQuery();

            if (rs.next()) {
                int orderId = rs.getInt("order_id");

                // 3. Finalize the Order
                // We change status to 'Paid' so it no longer appears in the Cart
                String updateSql = "UPDATE order_master SET order_status='Paid', payment_mode=?, order_datetime=NOW() WHERE order_id=?";
                PreparedStatement psUp = con.prepareStatement(updateSql);
                psUp.setString(1, payMode);
                psUp.setInt(2, orderId);
                int rowsUpdated = psUp.executeUpdate();

                if (rowsUpdated > 0) {
                    // SUCCESS: Move to Invoice
                    response.sendRedirect("invoice.jsp?oid=" + orderId);
                } else {
                    // Update failed
                    response.sendRedirect("view_cart.jsp?err=update_failed");
                }
            } else {
                // If the code reaches here, no 'Pending' order was found for this user
                // CHECK: Did you accidentally set the status to 'Completed' in CartServlet?
                response.sendRedirect("shop.jsp?msg=no_pending_order");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_cart.jsp?err=db_error");
        }
    }
}