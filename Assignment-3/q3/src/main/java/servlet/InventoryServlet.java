/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;
import ejb.InventoryLocal;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/InventoryServlet")
public class InventoryServlet extends HttpServlet {

    @EJB
    private InventoryLocal inventoryBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        try {
            if ("addProduct".equals(action)) {
                int id = Integer.parseInt(request.getParameter("pid"));
                String name = request.getParameter("pname");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                int catId = Integer.parseInt(request.getParameter("cid"));
                inventoryBean.addProduct(id, name, price, stock, catId);

            } else if ("updateProduct".equals(action)) {
                int id = Integer.parseInt(request.getParameter("pid"));
                String name = request.getParameter("pname");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock = Integer.parseInt(request.getParameter("stock"));
                inventoryBean.updateProduct(id, name, price, stock);

            } else if ("deleteProduct".equals(action)) {
                int id = Integer.parseInt(request.getParameter("pid"));
                inventoryBean.deleteProduct(id);

            } else if ("addCategory".equals(action)) {
                int id = Integer.parseInt(request.getParameter("cid"));
                String name = request.getParameter("cname");
                inventoryBean.addCategory(id, name);

            } else if ("deleteCategory".equals(action)) {
                int id = Integer.parseInt(request.getParameter("cid"));
                inventoryBean.deleteCategory(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // After any operation, redirect to the display page (index.jsp)
        response.sendRedirect("index.jsp");
    }

    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) 
                throws ServletException, IOException {

            // Fetch both products AND categories for the UI
            request.setAttribute("products", inventoryBean.getAllProducts());
            request.setAttribute("categories", inventoryBean.getAllCategories());

            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        // Fetch all products to display on the page
//        List<String> productList = inventoryBean.getAllProducts();
//        request.setAttribute("products", productList);
//        request.getRequestDispatcher("index.jsp").forward(request, response);
//    }
}