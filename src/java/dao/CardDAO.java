package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Card;

public class CardDAO {

    public static int processPayment(int sellerId, int buyerId, int quantity, double price, int orderId) {
        String sql = "{? = CALL PayOrder(?, ?, ?, ?, ?)}"; // chú ý dấu ? đầu tiên là OUTPUT return

        try (Connection conn = DatabaseConfig.getConnection(); CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.registerOutParameter(1, java.sql.Types.INTEGER); // Return value
            stmt.setInt(2, sellerId);
            stmt.setInt(3, buyerId);
            stmt.setInt(4, quantity);
            stmt.setDouble(5, price);
            stmt.setInt(6, orderId);

            stmt.execute();

            int resultCode = stmt.getInt(1);
            System.out.println(resultCode);// lấy giá trị return từ procedure
            return resultCode;

        } catch (SQLException e) {
            e.printStackTrace();
            return -999; // Unknown error
        }
    }

    public static int getBalance(int userId, long cardNumber) {
        String sql = "SELECT c.blance "
                + "FROM Users u JOIN Cards c ON u.cardNumber = c.cardNumber "
                + "WHERE u.id = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Card c = new Card();
                c.setBalance(rs.getInt("blance"));
                return c.getBalance();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
