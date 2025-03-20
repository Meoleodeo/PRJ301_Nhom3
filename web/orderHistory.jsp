<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>
<%@ page import="dao.OrderDAO, model.Order, model.User, java.util.List" %>

<head>
    <title>Đơn hàng của tôi - BlackShope</title>
    <link rel="stylesheet" href="assets/bootstrap.min.css">
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
        .table {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            background: #fff;
        }
        .table th {
            background: #1a1a1a;
            color: #fff;
        }
        .table th, .table td {
            padding: 15px;
            vertical-align: middle;
        }
        .table-bordered td, .table-bordered th {
            border: 1px solid #ddd;
        }
    </style>
</head>

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
