<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<body class="register">
    <div class="container container-register">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mt-5 container-h2">Đăng ký tài khoản</h2>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>
                <form action="RegisterServlet" method="post">
                    <div class="mb-3">
                        <label class="container-label">Tên đăng nhập:</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="container-label">Email:</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="container-label">Mật khẩu:</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="container-label">Chọn vai trò:</label>
                        <select class="form-control" name="role">
                            <option value="buyer">Người mua</option>
                            <option value="seller">Người bán</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
                </form>
                <p class="text-center mt-3">Đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
            </div>
        </div>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
