<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, java.util.List" %>

<body>
    <div id="carouselExampleIndicators" class="carousel slide carousel-container" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="assets/image/banner1.png" class="d-block w-100 carousel-image" alt="Banner 1">
            </div>
            <div class="carousel-item">
                <img src="assets/image/banner2.png" class="d-block w-100 carousel-image" alt="Banner 2">
            </div>
            <div class="carousel-item">
                <img src="assets/image/banner3.png" class="d-block w-100 carousel-image" alt="Banner 3">
            </div>
            <div class="carousel-item">
                <img src="assets/image/banner4.png" class="d-block w-100 carousel-image" alt="Banner 4">
            </div>
        </div>
    </div>

    <div class="container content-container">
        <h2 class="text-center mt-5 section-title">Danh sách sản phẩm</h2>
        <div class="row product-list">
            <%
                List<Product> products = ProductDAO.getAllProducts();
                for (Product product : products) {
                System.out.println(product.toString());
            %>
                <div class="col-md-4 product-item">
                    <div class="card mb-3 card-custom">
                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "assets/image/laptop.jpg" %>" class="card-img-top product-image">
                        <div class="card-body product-info">
                            <h5 class="card-title product-name"><%= product.getName() %></h5>
                            <p class="card-text product-description"><%= product.getDescription() %></p>
                            <p class="card-text product-quantity"><strong>Số lượng: </strong>
                                <%= product.getQuantity() > 0 ? product.getQuantity() : "<span class='text-danger out-of-stock'>Hết hàng</span>" %>
                            </p>
                            <p class="card-text product-price"><strong>price: </strong>
                                <%= product.getPrice() %> $
                            </p>
                            <% if (user != null && "buyer".equals(user.getRole())) { %>
                                <form action="OrderServlet" method="post" class="order-form">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <input type="number" name="quantity" min="1" max="<%= product.getQuantity() %>" required class="form-control mb-2 order-quantity">
                                    <button type="submit" class="btn btn-primary order-button">Đặt hàng</button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
    <%@ include file="includes/chat.jsp" %>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
