package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Lấy tất cả sản phẩm
    public static List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT * FROM Products";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                productList.add(new Product(
                    rs.getInt("id"),
                    rs.getInt("sellerId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getInt("quantity"),
                    rs.getString("imageUrl")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Lấy sản phẩm theo người bán
    public static List<Product> getProductsBySeller(int sellerId) {
        List<Product> productList = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "SELECT * FROM Products WHERE sellerId = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                productList.add(new Product(
                    rs.getInt("id"),
                    rs.getInt("sellerId"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getInt("quantity"),
                    rs.getString("imageUrl")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    // Thêm sản phẩm mới
    public static boolean addProduct(int sellerId, String name, String description, int quantity, String imageUrl) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            String sql = "INSERT INTO Products (sellerId, name, description, quantity, imageUrl) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, sellerId);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setInt(4, quantity);
            stmt.setString(5, imageUrl);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
      // Cập nhật sản phẩm
    public static boolean updateProduct(int productId, int sellerId, String name, String description, int quantity, String imageUrl) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            // Kiểm tra sản phẩm có thuộc về seller không
            String checkSql = "SELECT id FROM Products WHERE id = ? AND sellerId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, productId);
            checkStmt.setInt(2, sellerId);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                return false; // Không có quyền cập nhật sản phẩm này
            }

            // Cập nhật sản phẩm
            String updateSql = "UPDATE Products SET name = ?, description = ?, quantity = ?, imageUrl = ? WHERE id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, name);
            updateStmt.setString(2, description);
            updateStmt.setInt(3, quantity);
            updateStmt.setString(4, imageUrl);
            updateStmt.setInt(5, productId);

            return updateStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa sản phẩm
    public static boolean deleteProduct(int productId, int sellerId) {
        try (Connection conn = DriverManager.getConnection(DatabaseConfig.URL, DatabaseConfig.USER, DatabaseConfig.PASSWORD)) {
            // Kiểm tra xem sản phẩm có thuộc về seller không
            String checkSql = "SELECT id FROM Products WHERE id = ? AND sellerId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, productId);
            checkStmt.setInt(2, sellerId);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                return false; // Không có quyền xóa sản phẩm này
            }

            // Xóa sản phẩm
            String deleteSql = "DELETE FROM Products WHERE id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, productId);

            return deleteStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        List<Product> products = getAllProducts();
        for (Product product : products) {
            System.out.println(product.toString());
        }
    }
}
