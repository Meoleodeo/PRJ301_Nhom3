<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, java.util.List" %>

<body>
    <div class="container">
        <h2 class="text-center mt-5">Danh sách sản phẩm</h2>
        <div class="row">
            <%
                List<Product> products = ProductDAO.getAllProducts();
                for (Product product : products) {
            %>
                <div class="col-md-4">
                    <div class="card mb-3">
                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "assets/no-image.jpg" %>" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getName() %></h5>
                            <p class="card-text"><%= product.getDescription() %></p>
                            <p class="card-text"><strong>Số lượng: </strong>
                                <%= product.getQuantity() > 0 ? product.getQuantity() : "<span class='text-danger'>Hết hàng</span>" %>
                            </p>
                            <% if (user != null && "buyer".equals(user.getRole())) { %>
                                <a href="order.jsp?productId=<%= product.getId() %>" class="btn btn-primary">Đặt hàng</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
