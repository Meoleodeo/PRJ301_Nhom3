package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import model.User;
import model.Product;
import model.Order;
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

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Kiểm tra sản phẩm có tồn tại không
            Product product = ProductDAO.getProductById(productId);
            if (product == null) {
                request.setAttribute("error", "Sản phẩm không tồn tại.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            // Kiểm tra số lượng đặt hàng
            if (quantity <= 0 || quantity > product.getQuantity()) {
                request.setAttribute("error", "Số lượng đặt không hợp lệ.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }

            // Thực hiện đặt hàng
            boolean newOrder = OrderDAO.placeOrder(user.getId(), productId, quantity);
            if (newOrder) {                
                request.setAttribute("success", "Đơn hàng đã đặt thành công!");
                request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đặt hàng thất bại, vui lòng thử lại.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
