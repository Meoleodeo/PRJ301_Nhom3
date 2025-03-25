<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>

<body class="wrapper">
    <div class="main-content">
        <div class="container order-page-wrapper">
        <h2 class="text-center mt-5 o-title">Quản lý đơn hàng</h2>

        <% if (request.getAttribute("success") != null) {%>
        <div class="alert alert-success success-message">
            <%= request.getAttribute("success")%>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) {%>
        <div class="alert alert-danger error-message">
            <%= request.getAttribute("error")%>
        </div>
        <% }
        %>

    </div>
        <div class="container order-page-wrapper">
            <a class="btn btn-outline-info order-btn" href="OrderServlet" role="button">View your order</a>
        </div>
    </div>   
    <%@ include file="includes/chat.jsp" %>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
