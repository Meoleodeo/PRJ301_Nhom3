<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<body>

    <div class="chat-container">
        <!-- Nút mở chatbox -->
        <div class="chat-toggle-btn click" onclick="toggleChat()">💬 Chat</div>

        <!-- Hộp chat -->
        <div class="chat-box" id="chatBox">
            <div class="chat-box-header" onclick="toggleChat()">
                Chat với AI  
                <span class="close-chat">✖</span>
            </div>
            <div id="chatbox" class="chat-box-content"></div>
            <div class="chat-box-footer">
                <form id="chatForm">
                    <input type="text" id="message" name="message" class="form-control chat-input" placeholder="Nhập câu hỏi..." required />
                    <button type="submit" class="btn btn-send">Gửi</button>
                </form>
            </div>

        </div>
    </div>

    <script>
        function toggleChat() {
            document.getElementById("chatBox").classList.toggle("open");
        }

        document.getElementById("chatForm").addEventListener("submit", function(event) {
            event.preventDefault();
            let message = document.getElementById("message").value;
            if (!message.trim()) return;
            document.getElementById("message").value = "";

            let chatbox = document.getElementById("chatbox");
            let userDiv = document.createElement('div');
            userDiv.className = 'text-right text-primary';
            userDiv.textContent = message; // Sử dụng textContent
            console.log(message);
            chatbox.appendChild(userDiv);

            let loadingDiv = document.createElement('div');
            loadingDiv.className = 'text-left text-muted';
            loadingDiv.textContent = 'Đang xử lý...';
            chatbox.appendChild(loadingDiv);

            chatbox.scrollTop = chatbox.scrollHeight;

            fetch("ChatServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "message=" + encodeURIComponent(message)
            })
            .then(response => response.text())
            .then(reply => {
                chatbox.removeChild(loadingDiv); // Remove loading indicator

                let aiDiv = document.createElement('div');
                aiDiv.className = 'text-left text-success';
                aiDiv.textContent = reply; // Sử dụng textContent

                console.log(reply);
                chatbox.appendChild(aiDiv);

                chatbox.scrollTop = chatbox.scrollHeight;
            })
            .catch(error => {
                chatbox.removeChild(loadingDiv); // Remove loading indicator

                let errorDiv = document.createElement('div');
                errorDiv.className = 'text-left text-danger';
                errorDiv.textContent = `Lỗi AI: ${error.message || 'Có lỗi xảy ra.'}`; // Sử dụng textContent
                errorDiv.style.whiteSpace = 'pre-wrap'; // Ensure long messages wrap within the chatbox
                chatbox.appendChild(errorDiv);

                chatbox.scrollTop = chatbox.scrollHeight;
                console.error("Lỗi:", error);
            });
        });
    </script>
</body>
</html>