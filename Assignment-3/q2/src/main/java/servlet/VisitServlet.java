/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package servlet;

import ejb.VisitTrackerLocal;
import jakarta.ejb.EJB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VisitServlet", urlPatterns = {"/VisitServlet"})
public class VisitServlet extends HttpServlet {

    @EJB
    private VisitTrackerLocal tracker;

    // Use this as your primary logic handler
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String ipAddress = request.getRemoteAddr();
        
        // 1. Call your EJB logic
        int visitCount = tracker.recordVisit(ipAddress);

        // 2. Prepare the HTML response
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Visit Tracker</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Page Visit Tracker</h1>");
            out.println("<p>IP Address: <strong>" + ipAddress + "</strong></p>");
            out.println("<h3>Total Visits from this IP: " + visitCount + "</h3>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Stateful Visit Counter Servlet";
    }
}