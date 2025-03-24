<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.ProductDAO, model.Product" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4 product-edit-wrapper">
    <h2 class="product-edit-title">Chỉnh sửa sản phẩm</h2>
    <form action="EditProductServlet" method="post" class="product-edit-form">
        <%
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = ProductDAO.getProductById(productId);
        %>
        <input type="hidden" name="productId" value="<%= request.getParameter("id")%>">
        <input type="text" name="name" value="<%= product.getName() %>" placeholder="Tên sản phẩm" required class="form-control product-edit-input">
        <textarea name="description" placeholder="Mô tả" class="form-control mt-2 product-edit-textarea"><%= product.getDescription() %></textarea>
        <input type="number" name="quantity" value="<%= product.getQuantity() %>" placeholder="Số lượng" required class="form-control mt-2 product-edit-input">
        <input type="text" name="imageUrl" value="<%= product.getImageUrl() %>" placeholder="URL ảnh" class="form-control mt-2 product-edit-input">
        <input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" placeholder="Giá sản phẩm" required class="form-control mt-2 product-edit-input">
        <button type="submit" class="btn btn-success mt-3 product-edit-submit-btn">Cập nhật</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>
