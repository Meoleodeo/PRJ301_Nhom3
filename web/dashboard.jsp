<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, model.User, java.util.List" %>

<body>
    <div class="container product-manage-wrapper">
        <h2 class="text-center mt-5 product-manage-title">Quản lý sản phẩm</h2>
        <div class="d-flex justify-content-between mb-3 product-manage-actions">
            <a href="AddProductServlet" class="btn btn-success product-add-btn">+ Thêm sản phẩm</a>
            <a href="ManageOrdersServlet" class="btn btn-primary product-order-btn">Quản lý đơn hàng</a>
        </div>

        <table class="table table-striped product-manage-table">
            <tr class="product-table-header">
                <th>Mã</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Hành động</th>
            </tr>
            <%
                if (user != null && "seller".equals(user.getRole())) {
                    List<Product> products = ProductDAO.getProductsBySeller(user.getId());
                    for (Product product : products) {
            %>
            <tr class="product-table-row">
                <td><%= product.getId()%></td>
                <td><%= product.getName()%></td>
                <td><%= product.getDescription()%></td>
                <td><%= product.getQuantity() > 0 ? product.getQuantity() : "<span class='text-danger product-out-of-stock'>Hết hàng</span>"%></td>
                <td><%= String.format("%,.2f", product.getPrice())%> $</td> 
                <td>
                    <a href="EditProductServlet?id=<%= product.getId()%>" class="btn btn-warning product-edit-btn">Sửa</a>
                    <a href="#" onclick="confirmDelete(<%= product.getId()%>)" class="btn btn-danger product-delete-btn">Xóa</a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
    <%@ include file="includes/footer.jsp" %>
    <script>
        function confirmDelete(productId) {
            if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
                window.location.href = "DeleteProductServlet?id=" + productId;
            }
        }
    </script>

</body>
</html>
