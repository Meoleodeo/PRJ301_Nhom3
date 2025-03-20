<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<head>
    <style>
        /* Nền tổng thể */
        body {
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* Container chính */
        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            flex: 1;
        }

        /* Tiêu đề */
        h2 {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1a1a1a;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 30px;
            text-align: center;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
        }

        /* Khung chat với glassmorphism */
        #chatbox {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.5), rgba(200, 220, 255, 0.5));
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.4);
            min-height: 400px;
            overflow-y: auto;
            padding: 25px;
            position: relative;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        /* Gradient viền cho khung chat */
        #chatbox::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #ffd700, #007bff, #28a745);
            z-index: -1;
            border-radius: 22px;
            opacity: 0.5;
            height: 100%;
            width: 100%;
        }

        /* Thanh cuộn tùy chỉnh */
        #chatbox::-webkit-scrollbar {
            width: 10px;
        }
        #chatbox::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        #chatbox::-webkit-scrollbar-thumb {
            background: linear-gradient(45deg, #007bff, #ffd700);
            border-radius: 10px;
        }
        #chatbox::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(45deg, #0056b3, #e0c200);
        }

        /* Tin nhắn */
        .message {
            margin-bottom: 20px;
            display: flex;
            align-items: flex-start;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 0.5s ease forwards;
        }
        .message.user {
            justify-content: flex-end;
        }
        .message.ai {
            justify-content: flex-start;
        }
        .message.loading {
            justify-content: flex-start;
            color: #888;
            font-style: italic;
        }
        .message.error {
            justify-content: flex-start;
            color: #dc3545;
            font-style: italic;
        }

        /* Bong bóng tin nhắn */
        .message-content {
            max-width: 70%;
            padding: 12px 18px;
            border-radius: 20px;
            line-height: 1.5;
            position: relative;
            transition: background-color 0.3s, transform 0.2s;
            display: inline-block;
        }
        .message.user .message-content {
            background: linear-gradient(45deg, #007bff, #00c4ff);
            color: #fff;
            border-top-right-radius: 5px;
        }
        .message.ai .message-content {
            background: linear-gradient(45deg, #28a745, #34c759);
            color: #fff;
            border-top-left-radius: 5px;
        }
        .message.loading .message-content {
            background: none;
            padding: 5px 0;
        }
        .message.error .message-content {
            background: none;
            padding: 5px 0;
        }

        /* Thời gian gửi */
        .message-time {
            font-size: 0.75rem;
            opacity: 0.7;
            margin-top: 5px;
            display: block;
            text-align: right;
        }
        .message.ai .message-time {
            text-align: left;
        }

        /* Hiệu ứng hover trên tin nhắn */
        .message-content:hover {
            transform: scale(1.02);
            filter: brightness(1.1);
        }

        /* Form nhập tin nhắn */
        .chat-form {
            display: flex;
            margin-top: 25px;
            gap: 15px;
            position: relative;
        }
        .chat-form .input-wrapper {
            flex: 1;
            position: relative;
        }
        .chat-form input {
            width: 100%;
            border-radius: 30px;
            padding: 12px 20px 12px 50px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.2);
            color: #333;
            transition: all 0.3s ease;
        }
        .chat-form input:focus {
            border-color: #ffd700;
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
            background: rgba(255, 255, 255, 0.4);
        }
        .chat-form .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 1.2rem;
        }
        .chat-form button {
            border-radius: 30px;
            padding: 12px 30px;
            background: linear-gradient(45deg, #1a1a1a, #333);
            border: none;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }
        .chat-form button:hover {
            background: linear-gradient(45deg, #ffd700, #e0c200);
            color: #1a1a1a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Hiệu ứng xuất hiện tin nhắn */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            h2 {
                font-size: 1.8rem;
            }
            #chatbox {
                height: 350px;
            }
            .message-content {
                max-width: 80%;
            }
            .chat-form {
                flex-direction: column;
                gap: 15px;
            }
            .chat-form input {
                border-radius: 20px;
                padding: 10px 15px 10px 45px;
            }
            .chat-form button {
                border-radius: 20px;
                padding: 10px 20px;
                width: 100%;
            }
            .chat-form .input-icon {
                left: 12px;
                font-size: 1rem;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center mt-4">Chat với AI (Gemini)</h2>
        <div id="chatbox" class="border p-3 rounded mt-3"></div>
        <div class="mt-3">
            <form id="chatForm" class="chat-form">
                <div class="input-wrapper">
                    <span class="input-icon">💬</span>
                    <input type="text" id="message" name="message" class="form-control" placeholder="Nhập câu hỏi..." required />
                </div>
                <button type="submit" class="btn btn-primary">Gửi</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("chatForm").addEventListener("submit", function (event) {
            event.preventDefault();
            let message = document.getElementById("message").value;
            if (!message.trim())
                return;
            document.getElementById("message").value = "";

            let chatbox = document.getElementById("chatbox");

            // Tin nhắn người dùng
            let userDiv = document.createElement('div');
            userDiv.className = 'message user';
            let userContent = document.createElement('span');
            userContent.className = 'message-content';
            userContent.textContent = 'Bạn: ' + message;
            userDiv.appendChild(userContent);
            let userTime = document.createElement('div');
            userTime.className = 'message-time';
            userTime.textContent = new Date().toLocaleTimeString([], {hour: '2-digit', minute: '2-digit'});
            userContent.appendChild(userTime);
            console.log(message);
            chatbox.appendChild(userDiv);

            // Tin nhắn "Đang xử lý..."
            let loadingDiv = document.createElement('div');
            loadingDiv.className = 'message loading';
            let loadingContent = document.createElement('span');
            loadingContent.className = 'message-content';
            loadingContent.textContent = 'AI: Đang xử lý...';
            loadingDiv.appendChild(loadingContent);
            chatbox.appendChild(loadingDiv);

            chatbox.scrollTop = chatbox.scrollHeight;

            fetch("ChatServlet", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "message=" + encodeURIComponent(message)
            })
                    .then(response => response.text())
                    .then(reply => {
                        chatbox.removeChild(loadingDiv);

                        // Tin nhắn AI
                        let aiDiv = document.createElement('div');
                        aiDiv.className = 'message ai';
                        let aiContent = document.createElement('span');
                        aiContent.className = 'message-content';
                        aiContent.textContent = 'AI: ' + reply;
                        aiDiv.appendChild(aiContent);
                        let aiTime = document.createElement('div');
                        aiTime.className = 'message-time';
                        aiTime.textContent = new Date().toLocaleTimeString([], {hour: '2-digit', minute: '2-digit'});
                        aiContent.appendChild(aiTime);
                        console.log(reply);
                        chatbox.appendChild(aiDiv);

                        chatbox.scrollTop = chatbox.scrollHeight;
                    })
                    .catch(error => {
                        chatbox.removeChild(loadingDiv);

                        // Tin nhắn lỗi
                        let errorDiv = document.createElement('div');
                        errorDiv.className = 'message error';
                        let errorContent = document.createElement('span');
                        errorContent.className = 'message-content';
                        errorContent.textContent = 'Lỗi AI: ' + (error.message || 'Có lỗi xảy ra.');
                        errorDiv.appendChild(errorContent);
                        chatbox.appendChild(errorDiv);

                        chatbox.scrollTop = chatbox.scrollHeight;
                        console.error("Lỗi:", error);
                    });
        });
    </script>

    <%@ include file="includes/footer.jsp" %>
</body>
</html>