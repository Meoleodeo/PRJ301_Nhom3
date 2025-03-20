<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.ProductDAO, model.Product, java.util.List" %>

<head>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: pink;
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
        .card {
            border: none;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
            width: 100%;
            border-bottom: 1px solid #ddd;
        }
        .card-body {
            padding: 20px;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1a1a1a;
        }
        .card-text {
            color: #666;
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
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center mt-5">Danh sách sản phẩm</h2>
        <div class="row">
            <%
                List<Product> products = ProductDAO.getAllProducts();
                for (Product product : products) {
                System.out.println(product.toString());
            %>
                <div class="col-md-4">
                    <div class="card mb-3">
                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "assets/img/" %>" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getName() %></h5>
                            <p class="card-text"><%= product.getDescription() %></p>
                            <p class="card-text"><strong>Số lượng: </strong>
                                <%= product.getQuantity() > 0 ? product.getQuantity() : "<span class='text-danger'>Hết hàng</span>" %>
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
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
