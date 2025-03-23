<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlackShope</title>
    <link rel="stylesheet" href="assets/css/style-addProduct.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>
<div class="container mt-4">
    <div class="container title">
        <a href="index.jsp"><p>BlackShope</p></a>
    </div>
    <h2>Thêm sản phẩm mới</h2>
    <form action="AddProductServlet" method="post">
        <input type="text" name="name" placeholder="Tên sản phẩm" required class="form-control">
        <textarea name="description" placeholder="Mô tả" class="form-control mt-2"></textarea>
        <input type="number" name="quantity" placeholder="Số lượng" required class="form-control mt-2">
        <input type="text" name="imageUrl" placeholder="URL ảnh" class="form-control mt-2">
        <input type="number" step="0.01" name="price" placeholder="Giá sản phẩm" required class="form-control mt-2">
        <button type="submit" class="btn btn-primary mt-3">Thêm</button>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>
