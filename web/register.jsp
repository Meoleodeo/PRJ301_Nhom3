<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlackShope</title>
    <link rel="stylesheet" href="assets/css/stylelogin.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>

<body class="register">
    <div class="container title">
        <a href="index.jsp"><p>BlackShope</p></a>
    </div>
    <div class="container1 container-register">
        <div class="row justify-content-center">
            <div class="col-md-6 form-login">
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
</body>
</html>
