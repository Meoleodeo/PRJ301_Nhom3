<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>

<body class="wrapper">
    <div class="main-content">
        <div class="container order-container">
            <h2 class="order-title">Quản lý đơn hàng</h2>

            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("success") %></div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <table class="order-table">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Mã sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Trạng thái</th>
                        <th>Thanh toán</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        User user1 = (User) session.getAttribute("user");
                        if (user1 != null && "seller".equals(user1.getRole())) {
                            List<Order> orders = OrderDAO.getOrdersBySeller(user1.getId());
                            for (Order order : orders) {
                    %>
                        <tr>
                            <td><%= order.getOrderId() %></td>
                            <td><%= order.getProductId() %></td>
                            <td><%= order.getQuantity() %></td>
                            <td>
                                <span class="<%= "Completed".equals(order.getStatus()) ? "status-completed" :
                                               "Cancelled".equals(order.getStatus()) ? "status-cancelled" :
                                               "status-pending" %>">
                                    <%= order.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <span class="<%= "Paid".equals(order.getPaymentStatus()) ? "payment-paid" : "payment-unpaid" %>">
                                    <%= order.getPaymentStatus() %>
                                </span>
                            </td>
                            <td>
                                <form action="ManageOrdersServlet" method="post">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <select name="status" class="status-dropdown">
                                        <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Chờ xử lý</option>
                                        <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Hủy</option>
                                    </select>
                                    <button type="submit" class="update-button mt-2">Cập nhật</button>
                                </form>
                            </td>
                        </tr>
                    <% 
                            }
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
