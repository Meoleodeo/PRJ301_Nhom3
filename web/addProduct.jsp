<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4">
    <h2>Thêm sản phẩm mới</h2>
    <form action="AddProductServlet" method="post" class="needs-validation" novalidate>
        <div class="form-group">
            <label for="name">Tên sản phẩm</label>
            <input type="text" id="name" name="name" placeholder="Tên sản phẩm" required class="form-control">
        </div>
        <div class="form-group mt-2">
            <label for="description">Mô tả</label>
            <textarea id="description" name="description" placeholder="Mô tả" class="form-control"></textarea>
        </div>
        <div class="form-group mt-2">
            <label for="quantity">Số lượng</label>
            <input type="number" id="quantity" name="quantity" placeholder="Số lượng" required class="form-control">
        </div>
        <div class="form-group mt-2">
            <label for="imageUrl">URL ảnh</label>
            <input type="text" id="imageUrl" name="imageUrl" placeholder="URL ảnh" class="form-control">
        </div>
        <div class="form-group mt-2">
            <label for="price">Giá sản phẩm</label>
            <input type="number" step="0.01" id="price" name="price" placeholder="Giá sản phẩm" required class="form-control">
        </div>
        <button type="submit" class="btn btn-primary mt-3">Thêm</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>
