<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlackShope</title>
    <link rel="stylesheet" href="assets/bootstrap.min.css">
    <link rel="stylesheet" href="assets/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            height: 100%; /* Đảm bảo chiều cao tối thiểu 100% */
            margin: 0;
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
            display: flex;
            flex-direction: column; 
            min-height: 100vh;
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            flex: 1;
        }
        h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #1a1a1a;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #ddd;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #ffd700;
            box-shadow: 0 0 5px rgba(255, 215, 0, 0.5);
            outline: none;
        }
        textarea.form-control {
            min-height: 100px;
        }
        .btn-primary {
            border-radius: 8px;
            padding: 10px 20px;
            background-color: #1a1a1a;
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn-primary:hover {
            background-color: #ffd700;
            color: #1a1a1a;
            transform: translateY(-2px);
        }
        .btn-success {
            border-radius: 8px;
            padding: 10px 20px;
            background-color: #28a745;
            border: none;
            transition: background-color 0.3s, transform 0.2s;
        }
        .btn-success:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            .container {
                padding: 10px;
            }
            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
