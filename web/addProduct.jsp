<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4">
    <h2>Thêm s?n ph?m m?i</h2>
    <form action="AddProductServlet" method="post">
        <input type="text" name="name" placeholder="Tên s?n ph?m" required class="form-control">
        <textarea name="description" placeholder="Mô t?" class="form-control mt-2"></textarea>
        <input type="number" name="quantity" placeholder="S? l??ng" required class="form-control mt-2">
        <input type="text" name="imageUrl" placeholder="URL ?nh" class="form-control mt-2">
        <input type="number" step="0.01" name="price" placeholder="Giá s?n ph?m" required class="form-control mt-2">
        <button type="submit" class="btn btn-primary mt-3">Thêm</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>
