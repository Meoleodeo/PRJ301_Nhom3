<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light nav-custom">
    <a class="navbar-brand" href="index.jsp">BlackShope</a>
    <a class="navbar-item" href="chat.jsp">Chat With AI</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
            <% if (user != null) { %>
                <li class="nav-item">
                    <span class="nav-link">
                        Xin chào <strong><%= user.getUsername() %></strong> | Số dư: <strong><%= user.getBalance() %>$</strong>
                    </span>
                </li>
                <% if ("buyer".equals(user.getRole())) { %>
                    <li class="nav-item"><a class="nav-link" href="order.jsp">Đơn hàng</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Quản lý sản phẩm </a></li>
                    <li class="nav-item"><a class="nav-link" href="managerOrders.jsp">Quản lý bán hàng</a></li>
                <% } %>
                    <li class="nav-item"><a class="nav-link" href="LogoutServlet">Đăng xuất</a></li>
            <% } else { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Đăng kí</a></li>
            <% } %>
        </ul>
    </div>
</nav>
