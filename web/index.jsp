<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, java.util.List" %>

<body>
    <!-- <div class="slider">
        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner ">
              <div class="carousel-item active">
                <img src="https://www.bing.com/th?id=OIP.n2J-te2edVD91F8w6udMmgHaHa&w=206&h=206&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2" class="d-block w-100" alt="...">
              </div>
              <div class="carousel-item active">
                <img src="https://www.bing.com/th?id=OIP.h_REyr4IhtYw-7Zk-aJeLQHaE8&w=144&h=100&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2" class="d-block w-100" alt="...">
              </div>
              <div class="carousel-item active">
                <img src="https://www.bing.com/th?id=OIP.xqYunaXLEIiIBgbHGncjBQHaHa&w=93&h=104&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2" class="d-block w-100" alt="...">
              </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </button>
          </div>
    </div> -->

    <div class="container content">
        <h2 class="text-center mt-5">Danh sách sản phẩm</h2>
        <div class="row">
            <%
                List<Product> products = ProductDAO.getAllProducts();
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
                            <p class="card-text"><strong>price: </strong>
                                <%= product.getPrice() %> $
                            </p>
                            <% if (user != null && "buyer".equals(user.getRole())) { %>
                                <form action="OrderServlet" method="post">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <input type="number" name="quantity" min="1" max="<%= product.getQuantity() %>" required class="form-control mb-2">
                                    <button type="submit" class="btn btn-primary">Đặt hàng</button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
