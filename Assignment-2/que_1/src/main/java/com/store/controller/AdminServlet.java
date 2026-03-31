/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.store.controller;

import com.store.util.DBConnection;
import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id"); 
        
        // Check if ID is actually present for Update logic
        boolean isUpdate = (idStr != null && !idStr.trim().isEmpty() && !idStr.equals("null"));

        try (Connection con = DBConnection.getConnection()) {
            if ("upsertCategory".equals(action)) {
                String name = request.getParameter("cat_name");
                int parent = Integer.parseInt(request.getParameter("parent_id"));

                String sql = isUpdate 
                    ? "UPDATE category_master SET category_name=?, parent_category_id=? WHERE category_id=?"
                    : "INSERT INTO category_master (category_name, parent_category_id) VALUES (?, ?)";
                
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, name);
                    ps.setInt(2, parent);
                    if (isUpdate) ps.setInt(3, Integer.parseInt(idStr));
                    ps.executeUpdate();
                }
            } 
            else if ("upsertProduct".equals(action)) {
                String name = request.getParameter("p_name");
                double price = Double.parseDouble(request.getParameter("p_price"));
                String unit = request.getParameter("p_unit");
                double disc = Double.parseDouble(request.getParameter("p_disc"));
                String img = request.getParameter("p_img");
                int catId = Integer.parseInt(request.getParameter("p_cat"));
                int stock = Integer.parseInt(request.getParameter("p_stock"));

                String sql = isUpdate
                    ? "UPDATE product_master SET product_name=?, price=?, unit=?, discount=?, image=?, category_id=?, stock=? WHERE product_id=?"
                    : "INSERT INTO product_master (product_name, price, unit, discount, image, category_id, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, name); ps.setDouble(2, price); ps.setString(3, unit);
                    ps.setDouble(4, disc); ps.setString(5, img); ps.setInt(6, catId); ps.setInt(7, stock);
                    if (isUpdate) ps.setInt(8, Integer.parseInt(idStr));
                    ps.executeUpdate();
                }
            }
            response.sendRedirect("admin_dashboard.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=" + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if (id != null) {
            try (Connection con = DBConnection.getConnection()) {
                String sql = "delProd".equals(action) ? 
                             "DELETE FROM product_master WHERE product_id = ?" : 
                             "DELETE FROM category_master WHERE category_id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, Integer.parseInt(id));
                    ps.executeUpdate();
                }
            } catch (Exception e) { e.printStackTrace(); }
        }
        response.sendRedirect("admin_dashboard.jsp");
    }
}