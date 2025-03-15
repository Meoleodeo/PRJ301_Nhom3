<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<div class="container mt-4">
    <h2>Ch?nh s?a s?n ph?m</h2>
    <form action="EditProductServlet" method="post">
        <input type="hidden" name="productId" value="<%= request.getParameter("id") %>">
        <input type="text" name="name" placeholder="Tên s?n ph?m" required class="form-control">
        <textarea name="description" placeholder="Mô t?" class="form-control mt-2"></textarea>
        <input type="number" name="quantity" placeholder="S? l??ng" required class="form-control mt-2">
        <input type="text" name="imageUrl" placeholder="URL ?nh" class="form-control mt-2">
        <button type="submit" class="btn btn-success mt-3">C?p nh?t</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>