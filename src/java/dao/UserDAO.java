package dao;

import model.User;
import java.sql.*;
import java.util.logging.Logger;

public class UserDAO {

    // Lấy thông tin người dùng theo username
    public static User getUserByUsername(String username) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT * FROM Users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public static boolean registerUser(User user) {
        String sql = "{CALL AddUserWithCard(?, ?, ?, ?, ?)}";

        try (Connection conn = DatabaseConfig.getConnection(); CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());  // Bạn có thể hash nếu cần
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());
            stmt.setInt(5, 1000); // Số dư mặc định cho thẻ

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                logger.info("Đăng ký thành công: " + user.getUsername());
                return true;
            }
        } catch (SQLException e) {
            logger.severe("Lỗi khi đăng ký: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra email có tồn tại không
    public static boolean isEmailExist(String email) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lưu token reset mật khẩu
    public static boolean storeResetToken(String email, String token) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "UPDATE Users SET reset_token = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, token);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static User getUserWithBalance(String username) {
        String sql = "SELECT u.id, u.username, u.role, c.blance "
                + "FROM Users u JOIN Cards c ON u.cardNumber = c.cardNumber "
                + "WHERE u.username = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setRole(rs.getString("role"));
                user.setBalance(rs.getInt("blance"));  
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
