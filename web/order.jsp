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
                <th>Ngày đặt</th>
            </tr>
            <%
                User user = (User) session.getAttribute("user");
                if (user != null && "buyer".equals(user.getRole())) {
                    List<Order> orders = OrderDAO.getOrdersByBuyer(user.getId());
                    for (Order order : orders) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getProductId() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getStatus() %></td>
                    <td><%= order.getOrderDate() %></td>
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
