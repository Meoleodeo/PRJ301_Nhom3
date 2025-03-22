package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CardDAO {
    public static boolean processPayment(int sellerId,int  buyerId,int  quantity,double price, int orderId) {
         String sql = "{CALL PayOrder(?, ?, ?, ?, ?)}";

        try (Connection conn = DatabaseConfig.getConnection(); CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setInt(1, sellerId);
            stmt.setInt(2, buyerId);  // Bạn có thể hash nếu cần
            stmt.setInt(3, quantity);
            stmt.setDouble(4, price);
            stmt.setInt(5, orderId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }
        } catch (SQLException e) {
            
            e.printStackTrace();
        }
        return false;
    }
}
