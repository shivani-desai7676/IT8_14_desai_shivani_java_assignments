/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import jakarta.ejb.EJB; 
import ejb.CurrencyConverterLocal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Currency", urlPatterns = {"/Currency"})
public class Currency extends HttpServlet {

    // Injecting your EJB logic
    @EJB
    private CurrencyConverterLocal converter;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get parameters from the JSP form
        String amountStr = request.getParameter("amount");
        String from = request.getParameter("currency_from");
        String to = request.getParameter("currency_to");

        // 2. Perform the conversion if data is present
        if (amountStr != null && from != null && to != null) {
            try {
                double amount = Double.parseDouble(amountStr);
                
                // Call EJB method
                double result = converter.convert(from.toUpperCase(), to.toUpperCase(), amount);

                if (result != -1.0) {
                    request.setAttribute("result", amount + " " + from.toUpperCase() + " = " + result + " " + to.toUpperCase());
                } else {
                    request.setAttribute("result", "Error: Conversion rate not found in database.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("result", "Error: Invalid amount entered.");
            }
        }

        // 3. Forward back to index.jsp to show the result within the styled UI
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        return "Currency Converter Controller Servlet";
    }
}
