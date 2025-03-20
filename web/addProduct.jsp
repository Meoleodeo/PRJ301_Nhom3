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
        textarea.form-control {
            min-height: 100px;
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
    </style>
</head>

<body>
<div class="container mt-4">
    <h2>Thêm sản phẩm mới</h2>
    <form action="AddProductServlet" method="post">
        <input type="text" name="name" placeholder="Tên sản phẩm" required class="form-control">
        <textarea name="description" placeholder="Mô tả" class="form-control mt-2"></textarea>
        <input type="number" name="quantity" placeholder="Số lượng" required class="form-control mt-2">
        <input type="text" name="imageUrl" placeholder="URL ảnh" class="form-control mt-2">
        <button type="submit" class="btn btn-primary mt-3">Thêm</button>
    </form>
</div>
<%@ include file="includes/footer.jsp" %>
</body>
</html>