package controller;

import dao.OrderDAO;
import model.User;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ManageOrdersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"seller".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> orders = OrderDAO.getOrdersBySeller(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("managerOrders.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        boolean success = OrderDAO.updateOrderStatus(orderId, status);

        if (success) {
            response.sendRedirect("ManageOrdersServlet");
        } else {
            request.setAttribute("error", "Cập nhật trạng thái thất bại!");
            request.getRequestDispatcher("managerOrders.jsp").forward(request, response);
        }
    }
}
