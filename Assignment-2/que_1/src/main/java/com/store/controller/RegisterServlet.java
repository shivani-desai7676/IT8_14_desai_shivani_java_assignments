/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
*/
package com.store.controller;

import com.store.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * RegisterServlet handles the registration of new users for the Fashion Store.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    /**
     * Handles the HTTP GET method.
     * Redirects users to the registration page if they try to access this servlet directly via URL.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    /**
     * Handles the HTTP POST method.
     * Receives data from register.jsp and saves it to the database.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Capture all fields from the registration form
        String name = request.getParameter("txt_name");
        String login = request.getParameter("txt_login");
        String pass = request.getParameter("txt_pass");
        String email = request.getParameter("txt_email");
        String phone = request.getParameter("txt_phone");
        String address = request.getParameter("txt_address");
        String city = request.getParameter("txt_city");
        String state = request.getParameter("txt_state");
        String country = request.getParameter("txt_country");
        String pin = request.getParameter("txt_pin");
        
//        // CAPTCHA LOGIC (Requirement check)
//        String userEnteredCaptcha = request.getParameter("txt_captcha");
//        HttpSession session = request.getSession();
//        String actualCaptcha = (String) session.getAttribute("captcha");
//
//        // Validate Captcha first
//        if (actualCaptcha == null || !actualCaptcha.equals(userEnteredCaptcha)) {
//            response.sendRedirect("register.jsp?msg=invalid_captcha");
//            return; // Stop further execution
//        }

            // Get user input and session value
        String userEntered = request.getParameter("txt_captcha");
        HttpSession session = request.getSession();
        String actual = (String) session.getAttribute("captcha");

        // DEBUG: Print these to your NetBeans Output window to see what's happening
        System.out.println("User entered: " + userEntered);
        System.out.println("Actual Captcha: " + actual);

        if (actual == null || !actual.equalsIgnoreCase(userEntered)) {
            response.sendRedirect("register.jsp?msg=invalid_captcha");
            return; // This STOPs the code from reaching the Database part
        }

        // 2. Call DAO to interact with the database
        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(name, login, pass, email, phone, address, city, state, country,pin);

        // 3. Redirect based on success or failure
        if (success) {
            // Registration successful - Go to login
            response.sendRedirect("login.jsp?reg=success");
        } else {
            // Registration failed (Database error or duplicate ID) - Stay on register
            response.sendRedirect("register.jsp?reg=fail");
        }
    }

    @Override
    public String getServletInfo() {
        return "Fashion Store Registration Controller";
    }
}