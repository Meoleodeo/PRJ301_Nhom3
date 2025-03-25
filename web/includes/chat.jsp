<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<body>
    <div class="chat-container">
        <!-- Nút mở chatbox -->
        <div class="chat-toggle-btn click" onclick="toggleChat()">💬 Chat</div>

        <!-- Hộp chat -->
        <div class="chat-box slide-in-bck-bottom" id="chatBox">
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
            userDiv.className = 'text-right text-primary user-message';
            userDiv.textContent = message; // Sử dụng textContent
            console.log(message);
            chatbox.appendChild(userDiv);

            let now = new Date();
            let timeString = now.getHours().toString().padStart(2, '0') + ":" + now.getMinutes().toString().padStart(2, '0');
            let userTimeSpan = document.createElement('span');
            userTimeSpan.className = 'message-time user-time';
            userTimeSpan.textContent = timeString;
            userDiv.appendChild(userTimeSpan);

            let loadingDiv = document.createElement('div');
            loadingDiv.className = 'text-left text-muted loading-message';
            loadingDiv.textContent = 'Đang xử lý...';
            chatbox.appendChild(loadingDiv);

            loadingDiv.innerHTML = ''; // Xóa nội dung "Đang xử lý..." (không tính là chỉnh sửa mã gốc vì đây là bước thêm)
            let dot1 = document.createElement('span');
            dot1.className = 'dot';
            let dot2 = document.createElement('span');
            dot2.className = 'dot';
            let dot3 = document.createElement('span');
            dot3.className = 'dot';
            loadingDiv.appendChild(dot1);
            loadingDiv.appendChild(dot2);
            loadingDiv.appendChild(dot3);

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
                aiDiv.className = 'text-left text-success ai-message';
                aiDiv.textContent = reply; // Sử dụng textContent
                console.log(reply);
                chatbox.appendChild(aiDiv);

                let aiTimeSpan = document.createElement('span');
                aiTimeSpan.className = 'message-time ai-time';
                aiTimeSpan.textContent = timeString;
                aiDiv.appendChild(aiTimeSpan);

                chatbox.scrollTop = chatbox.scrollHeight;
            })
            .catch(error => {
                chatbox.removeChild(loadingDiv); // Remove loading indicator

                let errorDiv = document.createElement('div');
                errorDiv.className = 'text-left text-danger';
                errorDiv.textContent = `Lỗi AI: ${error.message || 'Có lỗi xảy ra.'}`; // Sử dụng textContent
                chatbox.appendChild(errorDiv);

                chatbox.scrollTop = chatbox.scrollHeight;
                console.error("Lỗi:", error);
            });
        });
    </script>
</body>
</html>