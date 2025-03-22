<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<body>
    <div class="container">
        <h2 class="text-center mt-5">Đơn hàng của tôi</h2>
        <table class="table table-bordered">
            <tr>
                <th>Mã đơn hàng</th>
                <th>Mã sản phẩm</th>
                <th>Số lượng</th>
                <th>Trạng thái</th>
                <th>Thanh toán</th> <!-- Thêm cột Thanh toán -->
                <th>Ngày đặt</th>
                <th>Hành động</th>
            </tr>
            <%
            
                if (user != null && "buyer".equals(user.getRole())) {
                    List<Order> orders = OrderDAO.getOrdersByBuyer(user.getId());
                    for (Order order : orders) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getProductId() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getStatus() %></td>
                    <td>
                        <span class="<%= "Paid".equals(order.getPaymentStatus()) ? "text-success" : "text-danger" %>">
                            <%= order.getPaymentStatus() %>
                        </span>
                    </td>
                    <td><%= order.getOrderDate() %></td>
                    <td>
                        <% if ("Unpaid".equals(order.getPaymentStatus())) { %>
                            <form action="payOrder" method="post">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <input type="hidden" name="productId" value="<%= order.getProductId() %>">
                                <input type="hidden" name="buyerId" value="<%= user.getId() %>">
                                <button type="submit" class="btn btn-primary">Thanh toán</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
            <% 
                    }
                } 
            %>
        </table>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
