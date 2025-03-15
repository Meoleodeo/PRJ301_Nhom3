package controller;

import dao.OrderDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"buyer".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean success = OrderDAO.placeOrder(user.getId(), productId, quantity);

        if (success) {
            response.sendRedirect("order.jsp");
        } else {
            request.setAttribute("error", "Đặt hàng thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
