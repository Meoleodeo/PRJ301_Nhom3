package dao;

import model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Lấy đơn hàng theo người mua
    public static List<Order> getOrdersByBuyer(int buyerId) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT * FROM Orders WHERE buyerId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, buyerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("buyerId"),
                        rs.getInt("productId"),
                        rs.getInt("quantity"),
                        rs.getString("status"),
                        rs.getTimestamp("orderDate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Đặt hàng
    public static boolean placeOrder(int buyerId, int productId, int quantity) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "INSERT INTO Orders (buyerId, productId, quantity, status) VALUES (?, ?, ?, 'Pending')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, buyerId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Lấy đơn hàng theo người bán

    public static List<Order> getOrdersBySeller(int sellerId) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT o.* FROM Orders o "
                    + "JOIN Products p ON o.productId = p.id "
                    + "WHERE p.sellerId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("buyerId"),
                        rs.getInt("productId"),
                        rs.getInt("quantity"),
                        rs.getString("status"),
                        rs.getTimestamp("orderDate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
// Cập nhật trạng thái đơn hàng
    
    public static boolean updateOrderStatus(int orderId, String status) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "UPDATE Orders SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
}
