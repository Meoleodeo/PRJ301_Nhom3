<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, model.User, java.util.List" %>

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
