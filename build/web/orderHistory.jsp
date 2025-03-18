<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>

<body>
    <div class="container">
        <h2 class="text-center mt-5">Quản lý đơn hàng</h2>

        <% if (request.getAttribute("success") != null) {%>
        <div class="alert alert-success">
            <%= request.getAttribute("success")%>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) {%>
        <div class="alert alert-danger">
            <%= request.getAttribute("error")%>
        </div>
        <% }
        %>

    </div>
    <%@ include file="includes/footer.jsp" %>
</body>
</html>
