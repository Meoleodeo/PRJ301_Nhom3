package controller;

import dao.ProductDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class EditProductServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("editProduct.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"seller".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imageUrl = request.getParameter("imageUrl");
        double price = Double.parseDouble(request.getParameter("price")); // Lấy giá sản phẩm

        boolean success = ProductDAO.updateProduct(productId, user.getId(), name, description, quantity, imageUrl, price);

        if (success) {
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại!");
            request.getRequestDispatcher("EditProductServet?id=" + productId).forward(request, response);
        }
    }
}
