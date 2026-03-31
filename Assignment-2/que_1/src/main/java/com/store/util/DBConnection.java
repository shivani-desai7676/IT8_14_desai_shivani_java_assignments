/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.store.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/fashion_store";
    private static final String USER = "root"; // Default phpMyAdmin user
    private static final String PASS = "root";     // Default phpMyAdmin password is empty

    public static Connection getConnection() {
        Connection con = null;
        try {
            // 1. Load the MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 2. Establish connection
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.out.println("Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
        return con;
    }
    
//    public static void main(String[] args) {
//        getConnection();
//        
//        if(getConnection()!= null){
//            System.out.println("connection succesfully");
//        }
//        else{
//            System.out.println("error");
//        }
//        
//    }
}


