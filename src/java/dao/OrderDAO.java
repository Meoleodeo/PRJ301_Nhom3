package dao;

import model.Order;
import config.DatabaseConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Lấy đơn hàng theo người mua
    public static List<Order> getOrdersByBuyer(int buyerId) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "SELECT * FROM Orders WHERE buyer_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, buyerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("order_id"),
                        rs.getInt("buyer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Đặt hàng
    public static boolean placeOrder(int buyerId, int productId, int quantity) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "INSERT INTO Orders (buyer_id, product_id, quantity, status) VALUES (?, ?, ?, 'Pending')";
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
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "SELECT o.* FROM Orders o "
                    + "JOIN Products p ON o.product_id = p.product_id "
                    + "WHERE p.seller_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                        rs.getInt("order_id"),
                        rs.getInt("buyer_id"),
                        rs.getInt("product_id"),
                        rs.getInt("quantity"),
                        rs.getString("status"),
                        rs.getTimestamp("order_date")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
// Cập nhật trạng thái đơn hàng

    public static boolean updateOrderStatus(int orderId, String status) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "UPDATE Orders SET status = ? WHERE order_id = ?";
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
