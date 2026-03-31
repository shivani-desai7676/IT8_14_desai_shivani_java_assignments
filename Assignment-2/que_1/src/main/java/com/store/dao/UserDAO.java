/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.store.dao;

import com.store.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public boolean registerUser(String name, String login, String pass, String email, String phone, String address, String city, String state,String country, String pin) {
        // SQL query matching your table structure
        String sql = "INSERT INTO user_master (username, login_id, password, email, phone, address, city, state, country , pin) VALUES (?,?,?,?,?,?,?,?,?,?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, name);
            pst.setString(2, login);
            pst.setString(3, pass);
            pst.setString(4, email);
            pst.setString(5, phone);
            pst.setString(6, address);
            pst.setString(7, city);
            pst.setString(8, state);
            pst.setString(9, country);
            pst.setString(10, pin);

            int result = pst.executeUpdate();
            return result > 0; // Returns true if record inserted
            
        } catch (SQLException e) {
            // This will print the error in NetBeans "Output" tab
        System.out.println("SQL Error: " + e.getMessage());
        return false;
        }
    }
    
    public boolean checkLogin(String loginId, String password) throws Exception {
        String sql = "SELECT * FROM user_master WHERE login_id = ? AND password = ?";
        
        // Connection is wrapped in try-with-resources
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            if (con == null) throw new Exception("Database Connection Failed");

            pst.setString(1, loginId);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();
            
            return rs.next(); 
        } catch (SQLException e) {
            // Throwing the error up to the Servlet to handle display
            throw new Exception("SQL Error: " + e.getMessage());
        }
    }
    
        public String getUserRole(String login, String pass) {
        String role = null;
        String sql = "SELECT role FROM user_master WHERE login_id = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, login);
            pst.setString(2, pass);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return role; // returns 'admin', 'customer', or null if login fails
    }
        
        
    public String getUserNameByLogin(String login) {
        String name = "Guest";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT user_name FROM users WHERE login_id = ?")) {
            ps.setString(1, login);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) name = rs.getString("user_name");
        } catch (Exception e) { e.printStackTrace(); }
        return name;
    }

   public int getUserIdByLogin(String login) {
    int id = 0;
    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT user_id FROM users WHERE login_id = ?")) {
        ps.setString(1, login);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) id = rs.getInt("user_id");
    } catch (Exception e) { e.printStackTrace(); }
    return id;
}
}

