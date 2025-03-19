<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
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
                    <li class="nav-item"><a class="nav-link" href="order.jsp">??n hàng</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Qu?n lý s?n ph?m</a></li>
                    <li class="nav-item"><a class="nav-link" href="managerOrders.jsp">Qu?n lý ??n hàng</a></li>
                <% } %>
                <li class="nav-item"><a class="nav-link" href="LogoutServlet">??ng xu?t</a></li>
            <% } else { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">??ng nh?p</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">??ng ký</a></li>
            <% } %>
        </ul>
    </div>
</nav>
