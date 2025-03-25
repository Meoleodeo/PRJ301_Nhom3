<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, java.util.List" %>
<%@ page import="java.util.stream.Collectors" %>

<body>
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
        <ol class="carousel-indicators">
            <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
            <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="assets\image\banner\GundamSeedBanner.png" alt="First slide">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="assets\image\banner\MobileBanner.png" alt="Second slide">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="assets\image\banner\GunprimerBanner.png" alt="Third slide">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>

        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>

        </a>
    </div>

    <div class="container content">
        <div class="row">
            <div class="col-md-3">
                <h3 class="my-4" style="color: #F4B315;">Danh mục sản phẩm</h3>
                <div class="list-group">
                    <a href="index.jsp" class="list-group-item list-group-item-action">Tất cả sản phẩm</a>
                    <a href="?category=SD" class="list-group-item list-group-item-action">Mô hình SD</a>
                    <a href="?category=HG" class="list-group-item list-group-item-action">Mô hình HG</a>
                    <a href="?category=FM" class="list-group-item list-group-item-action">Mô hình FM</a>
                    <a href="?category=MG" class="list-group-item list-group-item-action">Mô hình MG</a>
                    <a href="?category=PG" class="list-group-item list-group-item-action">Mô hình PG</a>
                    <a href="?category=METAL BUILD" class="list-group-item list-group-item-action">Metal Build</a>
                    <a href="?category=Dụng cụ" class="list-group-item list-group-item-action">Dụng cụ lắp ráp</a>
                </div>
            </div>
            <div class="col-md-9">
                <h2 class="text-center mt-5" style="color: #F4B315;">Danh sách sản phẩm</h2>
                <div class="row">
                    <%
                        String category = request.getParameter("category");
                        List<Product> products = ProductDAO.getAllProducts();
                        if (category != null) {
                            products = products.stream()
                                .filter(p -> p.getName().contains(category))
                                .collect(Collectors.toList());
                        }
                        for (Product product : products) {
                        System.out.println(product.toString());
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
                                <p class="card-text"><strong>Price: </strong>
                                    <%= product.getPrice() %> $
                                </p>
                                <% if (user != null && "buyer".equals(user.getRole())) { %>
                                    <form action="OrderServlet" method="post">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <input type="number" name="quantity" min="1" max="<%= product.getQuantity() %>" required class="form-control mb-2">
                                        <button type="submit" class="btn btn-primary order-btn">Đặt hàng</button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="includes/chat.jsp" %>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
