/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatelessEjbClass.java to edit this template
 */
package ejb;

import jakarta.ejb.Stateless;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author root
 */
@Stateless
public class Inventory implements InventoryLocal {
    
   private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_3", "root", "root");
    }

    // --- CATEGORY OPERATIONS ---

    @Override
    public void addCategory(int id, String name) {
        try (Connection conn = getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO CategoryMaster VALUES (?, ?)");
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void deleteCategory(int id) {
        try (Connection conn = getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM CategoryMaster WHERE cat_id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // --- PRODUCT OPERATIONS ---

   @Override
        public void addProduct(int id, String name, double price, int stock, int catId) {
            try (Connection conn = getConnection()) {
                String query = "INSERT INTO ProductMaster (p_id, p_name, price, stock, cat_id) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                ps.setString(2, name);
                ps.setDouble(3, price);
                ps.setInt(4, stock);
                ps.setInt(5, catId);
                ps.executeUpdate(); // CRITICAL: This pushes data to DB
            } catch (Exception e) { e.printStackTrace(); }
        }

    @Override
    public void updateProduct(int id, String name, double price, int stock) {
        try (Connection conn = getConnection()) {
            String sql = "UPDATE ProductMaster SET p_name=?, price=?, stock=? WHERE p_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDouble(2, price);
            ps.setInt(3, stock);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void deleteProduct(int id) {
        try (Connection conn = getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM ProductMaster WHERE p_id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public List<String> getAllProducts() {
        List<String> products = new ArrayList<>();
        try (Connection conn = getConnection()) {
            // Join query to show Category Name instead of just ID
            String sql = "SELECT p.p_id, p.p_name, p.price, p.stock, c.cat_name " +
                         "FROM ProductMaster p JOIN CategoryMaster c ON p.cat_id = c.cat_id";
            ResultSet rs = conn.createStatement().executeQuery(sql);
            while (rs.next()) {
                products.add(rs.getInt("p_id") + " | " + rs.getString("p_name") + 
                             " | $" + rs.getDouble("price") + " | Stock: " + 
                             rs.getInt("stock") + " | Cat: " + rs.getString("cat_name"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return products;
    }
    
    @Override
        public List<String> getAllCategories() {
            List<String> categories = new ArrayList<>();
            try (Connection conn = getConnection()) {
                ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM CategoryMaster");
                while (rs.next()) {
                    categories.add(rs.getInt("cat_id") + ":" + rs.getString("cat_name"));
                }
            } catch (Exception e) { e.printStackTrace(); }
            return categories;
        }
}
