<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4 product-add-wrapper">
    <h2 class="product-add-title">Thêm sản phẩm mới</h2>
    <form action="AddProductServlet" method="post" class="product-add-form">
        <input type="text" name="name" placeholder="Tên sản phẩm" required class="form-control product-input">
        <textarea name="description" placeholder="Mô tả" class="form-control mt-2 product-textarea"></textarea>
        <input type="number" name="quantity" placeholder="Số lượng" required class="form-control mt-2 product-input">
        <input type="text" name="imageUrl" placeholder="URL ảnh" class="form-control mt-2 product-input">
        <input type="number" step="0.01" name="price" placeholder="Giá sản phẩm" required class="form-control mt-2 product-input">
        <button type="submit" class="btn btn-primary mt-3 product-submit-btn">Thêm</button>
    </form>
</div>
<%@ include file="includes/chat.jsp" %>
<%@ include file="includes/footer.jsp" %>
