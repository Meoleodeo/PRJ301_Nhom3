package controller;

import dao.CardDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;
import java.io.IOException;
import model.Product;

public class PayOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"buyer".equals(user.getRole())) {
            response.sendRedirect("LoginServlet");
            return;
        }
        int productId = Integer.parseInt(request.getParameter("productId"));
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int buyerId = Integer.parseInt(request.getParameter("buyerId"));

        Order ord = OrderDAO.getOrderById(orderId);
        int quantity = ord.getQuantity();
        Product prd = ProductDAO.getProductById(productId);
        int sellerId = prd.getSellerId();
        double price = prd.getPrice();

        int result = CardDAO.processPayment(sellerId, buyerId, quantity, price, orderId);

        if (result == 0) {
            OrderDAO.updatePaymentStatus(orderId, "Paid");
            response.sendRedirect("OrderServlet?success=true");
        } else if (result == 1) {
            response.sendRedirect("OrderServlet?error=insufficient_balance");
        } else if (result == 2) {
            response.sendRedirect("OrderServlet?error=out_of_stock");
        } else if (result == -1) {
            response.sendRedirect("OrderServlet?error=buyer_not_found");
        } else if (result == -2) {
            response.sendRedirect("OrderServlet?error=seller_not_found");
        } else {
            response.sendRedirect("OrderServlet?error=unknown_error");
        }
    }
}
