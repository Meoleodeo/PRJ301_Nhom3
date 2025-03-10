<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Booking</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="CSS/main.css">
    </head>

    <body>
        <!-- Include Header -->
        <%@ include file="/includes/header.jsp" %>

        <!-- Include Banner -->
        <%@ include file="/includes/banner.jsp" %>

        <div class="container mt-4">
            <%
                model.User user = (model.User) session.getAttribute("user");
            %>

            <% if (user != null) { %>
            <!-- Show bookings if user is logged in -->
            <%@ include file="/includes/booking.jsp" %>
            <% } else {%>
            <!-- Show movie list if user is not logged in -->
            <%@ include file="/includes/movies.jsp" %>
            <% }%>
        </div>

        <!-- Include Footer -->
        <%@ include file="/includes/footer.jsp" %>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
