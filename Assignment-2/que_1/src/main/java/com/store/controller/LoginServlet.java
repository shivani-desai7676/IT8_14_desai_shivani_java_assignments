/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

//package com.store.controller;
//
//import com.store.dao.UserDAO;
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
//public class LoginServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        String login = request.getParameter("txt_login");
//        String pass = request.getParameter("txt_pass");
//        String remember = request.getParameter("chk_remember");
//
//        UserDAO dao = new UserDAO();
//
//        try {
//            // MODIFICATION: Instead of boolean, we get the role string
//            String role = dao.getUserRole(login, pass); 
//
//            if (role != null) {
//                HttpSession session = request.getSession();
//                session.setAttribute("user", login);
//                session.setAttribute("role", role); // Store role for security filters
//
//                // COOKIE LOGIC
//                if (remember != null) {
//                    Cookie c = new Cookie("user_id", login);
//                    c.setMaxAge(60 * 60 * 24);
//                    response.addCookie(c);
//                }
//
//                // MODIFICATION: Redirection based on role
//                if (role.equalsIgnoreCase("admin")) {
//                    response.sendRedirect("admin_dashboard.jsp");
//                } else {
//                    response.sendRedirect("shop.jsp");
//                }
//                
//            } else {
//                // Scenario: Credentials don't match
//                response.sendRedirect("login.jsp?err=invalid");
//            }
//        } catch (Exception e) {
//            // Scenario: Database error
//            System.out.println("LOG Error: " + e.getMessage());
//            response.sendRedirect("login.jsp?err=db");
//        }
//    }
//}

package com.store.controller;

import com.store.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String login = request.getParameter("txt_login");
        String pass = request.getParameter("txt_pass");
        String remember = request.getParameter("chk_remember");

        UserDAO dao = new UserDAO();

        try {
            /* IMPORTANT: I recommend updating your DAO to return a 'User' object 
               that contains the ID, Name, and Role in one go. 
               If your DAO still only returns a String role, use the logic below:
            */
            String role = dao.getUserRole(login, pass); 

            if (role != null) {
                HttpSession session = request.getSession();
                
                // 1. Store the Login ID (String)
                session.setAttribute("user", login);
                
                // 2. Store the Role for security
                session.setAttribute("role", role); 

                // 3. FETCH & STORE USER ID (Crucial for Persistent Cart)
                // This ensures CartServlet always finds the right items in the DB
                int userId = dao.getUserIdByLogin(login); 
                session.setAttribute("user_id", userId);

                // 4. FETCH & STORE USER NAME (For the "Welcome" Header)
                String fullName = dao.getUserNameByLogin(login);
                session.setAttribute("userName", fullName);

                // COOKIE LOGIC
                if (remember != null) {
                    Cookie c = new Cookie("user_id_cookie", login);
                    c.setMaxAge(60 * 60 * 24);
                    response.addCookie(c);
                }

                // Redirection based on role
                if (role.equalsIgnoreCase("admin")) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("shop.jsp");
                }
                
            } else {
                // Credentials don't match
                response.sendRedirect("login.jsp?err=invalid");
            }
        } catch (Exception e) {
            // Database error
            System.out.println("LOG Error: " + e.getMessage());
            response.sendRedirect("login.jsp?err=db");
        }
    }
}