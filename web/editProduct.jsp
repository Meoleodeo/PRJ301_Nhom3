<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4">
    <h2>Chỉnh sửa sản phẩm</h2>
    <form action="EditProductServlet" method="post">
        <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">
        <input type="text" name="name" placeholder="Tên sản phẩm" required class="form-control">
        <textarea name="description" placeholder="Mô tả" class="form-control mt-2"></textarea>
        <input type="number" name="quantity" placeholder="Số lượng" required class="form-control mt-2">
        <input type="text" name="imageUrl" placeholder="URL ảnh" class="form-control mt-2">
        <input type="number" step="0.01" name="price" placeholder="Giá sản phẩm" required class="form-control mt-2">
        <button type="submit" class="btn btn-success mt-3">Cập nhật</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>
