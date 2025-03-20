<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, model.User, java.util.List" %>

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
        .table th {
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
        .btn-success, .btn-warning, .btn-danger {
            border-radius: 8px;
            padding: 8px 15px;
            transition: background-color 0.3s;
        }
        .btn-success {
            background-color: #28a745;
            border: none;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .btn-warning {
            background-color: #ffc107;
            border: none;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center mt-5">Quản lý sản phẩm</h2>
        <div class="d-flex justify-content-between mb-3">
            <a href="addProduct.jsp" class="btn btn-success">+ Thêm sản phẩm</a>
            <a href="ManageOrdersServlet" class="btn btn-primary">Quản lý đơn hàng</a>
        </div>

        <table class="table table-striped">
            <tr>
                <th>Mã</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Số lượng</th>
                <th>Hành động</th>
            </tr>
            <%
                if (user != null && "seller".equals(user.getRole())) {
                    List<Product> products = ProductDAO.getProductsBySeller(user.getId());
                    for (Product product : products) {
            %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td><%= product.getQuantity() > 0 ? product.getQuantity() : "<span class='text-danger'>Hết hàng</span>" %></td>
                    <td>
                        <a href="editProduct.jsp?id=<%= product.getId() %>" class="btn btn-warning">Sửa</a>
                        <a href="#" onclick="confirmDelete(<%= product.getId() %>)" class="btn btn-danger">Xóa</a>
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
