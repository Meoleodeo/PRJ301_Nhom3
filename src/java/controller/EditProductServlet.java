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

        boolean success = ProductDAO.updateProduct(productId, user.getId(), name, description, quantity, imageUrl);

        if (success) {
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Cập nhật sản phẩm thất bại!");
            request.getRequestDispatcher("editProduct.jsp?id=" + productId).forward(request, response);
        }
    }
}
