<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<head>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1a1a1a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #ddd;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #ffd700;
            box-shadow: 0 0 5px rgba(255, 215, 0, 0.5);
        }
        .btn-primary {
            border-radius: 8px;
            padding: 12px;
            background-color: #1a1a1a;
            border: none;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #ffd700;
            color: #1a1a1a;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mt-5">Đăng nhập</h2>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                <% } %>
                <form action="LoginServlet" method="post">
                    <div class="mb-3">
                        <label>Tên đăng nhập:</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label>Mật khẩu:</label>
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
