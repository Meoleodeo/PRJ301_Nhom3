<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<head>
    <style>
        .navbar {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            background: linear-gradient(90deg, #1a1a1a, #333);
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff !important;
            transition: color 0.3s;
        }
        .navbar-brand:hover {
            color: #ffd700 !important;
        }
        .nav-link {
            color: #fff !important;
            font-weight: 500;
            margin: 0 10px;
            transition: color 0.3s;
        }
        .nav-link:hover {
            color: #ffd700 !important;
        }
        /* Nút hamburger */
        .navbar-toggler {
            border: none;
            color: #fff;
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }
        /* Menu trên màn hình lớn */
        .navbar-nav {
            padding: 10px 0;
        }
        .navbar-nav .nav-link {
            padding: 10px 20px;
        }
        /* Menu thu gọn trên màn hình nhỏ */
        @media (max-width: 991px) {
            .navbar-collapse {
                position: absolute;
                top: 100%;
                right: 0; /* Đặt menu ở góc phải */
                width: 250px; /* Chiều rộng cố định */
                background-color: #333;
                border-top: 1px solid #444;
                z-index: 1000;
                box-shadow: -2px 2px 10px rgba(0, 0, 0, 0.2);
            }
            .navbar-nav {
                text-align: left; /* Căn trái nội dung trong menu */
                padding: 10px;
            }
            .navbar-nav .nav-item {
                border-bottom: 1px solid #444; /* Đường viền giữa các mục */
            }
            .navbar-nav .nav-link {
                padding: 12px 20px;
                color: #fff !important;
            }
            .navbar-nav .nav-link:hover {
                background-color: #444; /* Hiệu ứng hover */
            }
        }
    </style>
</head>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="index.jsp">BlackShope</a>
    <a class="navbar-item" href="chat.jsp">Chat With AI </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
            <% if (user != null) { %>
                <% if ("buyer".equals(user.getRole())) { %>
                    <li class="nav-item"><a class="nav-link" href="order.jsp">Đơn hàng</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Quản lý sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="managerOrders.jsp">Quản lý bán hàng</a></li>
                <% } %>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">Đăng xuất</a></li>
            <% } else { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Đăng ký</a></li>
            <% } %>
        </ul>
    </div>
</nav>
