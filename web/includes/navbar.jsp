<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<nav class="navbar-custom">
    <div class="container-custom">
        <a class="brand-custom" href="index.jsp">BLACKSHOPE</a>
        <div class="collapse-custom" id="navbarCustom">
            <ul class="nav-custom">
                <% if (user != null) { %>
                    <li class="nav-item-custom dropdown-custom">
                        <a class="nav-link-custom dropdown-toggle-custom" href="#" id="userDropdown" data-toggle="dropdown">
                            <img src="assets/image/avatar.jpg" alt="User Avatar" class="avatar-custom">
                            <span class="username-custom"><strong><%= user.getUsername() %></strong></span>
                        </a>
                        <ul class="dropdown-menu-custom">
                            <li><span class="dropdown-item-custom">Số dư: <strong><%= user.getBalance() %>$</strong></span></li>
                            <li class="divider-custom"></li>
                            <% if ("buyer".equals(user.getRole())) { %>
                                <li><a class="dropdown-item-custom" href="order.jsp">Đơn hàng</a></li>
                            <% } else { %>
                                <li><a class="dropdown-item-custom" href="dashboard.jsp">Quản lý sản phẩm</a></li>
                                <li><a class="dropdown-item-custom" href="managerOrders.jsp">Quản lý bán hàng</a></li>
                            <% } %>
                            <li><a class="dropdown-item-custom logout-custom" href="LogoutServlet">Đăng xuất</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item-custom"><a class="login-btn-custom" href="login.jsp">Đăng nhập</a></li>
                    <li class="nav-item-custom"><a class="register-btn-custom" href="register.jsp">Đăng ký</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
