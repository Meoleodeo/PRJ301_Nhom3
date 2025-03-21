<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<body class="login">
    <div class="container container-login">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mt-5 container-h2">Đăng nhập</h2>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>
                <form action="LoginServlet" method="post">
                    <div class="mb-3">
                        <label class="container-label">Tên đăng nhập:</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label class="container-label">Mật khẩu:</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                </form>
                <p class="text-center mt-3">
                    <a href="forgotPassword.jsp">Quên mật khẩu?</a> |
                    <a href="register.jsp">Đăng ký</a>
                </p>
            </div>
        </div>
    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
