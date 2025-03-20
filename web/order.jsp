<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>
<html>
<head>
    <title>Đơn hàng của tôi - BlackShope</title>
<!--    <link rel="stylesheet" href="assets/bootstrap.min.css">-->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1a1a1a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            text-align: center;
        }
        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            background: #fff;
        }
        .table th {
            background: linear-gradient(90deg, #1a1a1a, #333);
            color: #fff;
            font-weight: 600;
        }
        .table th, .table td {
            padding: 15px;
            vertical-align: middle;
            text-align: center; /* Căn giữa nội dung trong ô */
        }
        .table-bordered td, .table-bordered th {
            border: 1px solid #ddd;
        }
        .table tbody tr:nth-of-type(odd) {
            background-color: #fafafa;
        }
        .table tbody tr:hover {
            background-color: #f0f0f0;
            transition: background-color 0.3s;
        }
        /* Tùy chỉnh trạng thái đơn hàng */
        .status-pending {
            color: #ffc107;
            font-weight: 500;
        }
        .status-completed {
            color: #28a745;
            font-weight: 500;
        }
        .status-cancelled {
            color: #dc3545;
            font-weight: 500;
        }
    </style>
</head>
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
</body>
</html>
