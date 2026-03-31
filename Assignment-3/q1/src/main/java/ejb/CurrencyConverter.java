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

/**
 *
 * @author root
 */
@Stateless
public class CurrencyConverter implements CurrencyConverterLocal {
    
    String url = "jdbc:mysql://localhost:3306/assignment_3";
    String user = "root";
    String pass = "root";

    @Override
    public double convert(String from, String to, double amount) {
        double result = -1;

        try {
            // 1. Connect to MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);

            // 2. Prepare the SQL query using your table fields
            String sql = "SELECT rate FROM currency_rates WHERE currency_from = ? AND currency_to = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, from);
            pstmt.setString(2, to);

            // 3. Execute and Calculate
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                double rate = rs.getDouble("rate");
                result = amount * rate;
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result; 
    }
}
