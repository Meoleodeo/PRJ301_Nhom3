package dao;

import model.User;
import java.sql.*;
import java.util.logging.Logger;

public class UserDAO {

    // Lấy thông tin người dùng theo username
    public static User getUserByUsername(String username) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
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
        String sql = "INSERT INTO Users (username, password, email, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); // Lưu mật khẩu trực tiếp
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());

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
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
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
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
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
}
