/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatefulEjbClass.java to edit this template
 */
package ejb;

import jakarta.ejb.Stateful;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Ensure it is java.sql!
import java.sql.SQLException;

@Stateful
public class VisitTracker implements VisitTrackerLocal {

    // Database credentials (Update these to match your setup)
    private final String URL = "jdbc:mysql://localhost:3306/assignment_3";
    private final String USER = "root";
    private final String PASS = "root";

    @Override
    public int recordVisit(String ipAddress) {
        int count = 0;
        // Use try-with-resources to auto-close connections
        try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {
            
            // 1. Check if the IP exists
            String selectSQL = "SELECT visit_count FROM PageVisits WHERE ip_address = ?";
            try (PreparedStatement ps = conn.prepareStatement(selectSQL)) {
                ps.setString(1, ipAddress);
                try (ResultSet rs = ps.executeQuery()) { // Correct ResultSet used here
                    if (rs.next()) {
                        // 2. Update existing record
                        count = rs.getInt("visit_count") + 1;
                        updateRecord(conn, ipAddress, count);
                    } else {
                        // 3. Insert new record
                        count = 1;
                        insertRecord(conn, ipAddress, count);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    private void updateRecord(Connection conn, String ip, int count) throws SQLException {
        String sql = "UPDATE PageVisits SET visit_count = ? WHERE ip_address = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, count);
            ps.setString(2, ip);
            ps.executeUpdate();
        }
    }

    private void insertRecord(Connection conn, String ip, int count) throws SQLException {
        String sql = "INSERT INTO PageVisits (ip_address, visit_count) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ip);
            ps.setInt(2, count);
            ps.executeUpdate();
        }
    }
}