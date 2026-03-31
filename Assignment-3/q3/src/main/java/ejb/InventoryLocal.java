/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/SessionLocal.java to edit this template
 */
package ejb;

import jakarta.ejb.Local;
import java.util.List;

/**
 *
 * @author root
 */
@Local
public interface InventoryLocal {
   void addCategory(int id, String name);
    void deleteCategory(int id);
    
    // Product CRUD
    void addProduct(int id, String name, double price, int stock, int catId);
    void updateProduct(int id, String name, double price, int stock);
    void deleteProduct(int id);
    List<String> getAllProducts();
     List<String> getAllCategories();
}
