<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>

<head>
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
        }
        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            background: #fff;
        }
        .thead-dark {
            background: #1a1a1a;
            color: #fff;
        }
        .table th, .table td {
            padding: 15px;
            vertical-align: middle;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #fafafa;
        }
        .table-striped tbody tr:hover {
            background-color: #f0f0f0;
        }
        .form-control {
            border-radius: 8px;
            padding: 8px;
            border: 1px solid #ddd;
        }
        .btn-primary {
            border-radius: 8px;
            padding: 8px 15px;
            background-color: #1a1a1a;
            border: none;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #ffd700;
            color: #1a1a1a;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center mt-5">Quản lý đơn hàng</h2>

        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Mã đơn</th>
                    <th>Mã sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
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
                            <span class="<%= "Completed".equals(order.getStatus()) ? "text-success" :
                                           "Cancelled".equals(order.getStatus()) ? "text-danger" :
                                           "text-warning" %>">
                                <%= order.getStatus() %>
                            </span>
                        </td>
                        <td>
                            <form action="ManageOrdersServlet" method="post">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <select name="status" class="form-control">
                                    <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Chờ xử lý</option>
                                    <option value="Completed" <%= "Completed".equals(order.getStatus()) ? "selected" : "" %>>Hoàn thành</option>
                                    <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Hủy</option>
                                </select>
                                <button type="submit" class="btn btn-primary mt-2">Cập nhật</button>
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
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
