<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<body>
    <div class="container">
        <h2 class="text-center mt-4">Chat với AI (Gemini)</h2>
        <div id="chatbox" class="border p-3 rounded mt-3" style="height: 400px; overflow-y: auto;"></div>
        <div class="mt-3">
            <form id="chatForm">
                <input type="text" id="message" name="message" class="form-control" placeholder="Nhập câu hỏi..." required />
                <button type="submit" class="btn btn-primary mt-2">Gửi</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("chatForm").addEventListener("submit", function(event) {
            event.preventDefault();
            let message = document.getElementById("message").value;
            if (!message.trim()) return;
            document.getElementById("message").value = "";

            let chatbox = document.getElementById("chatbox");
            let userDiv = document.createElement('div');
            userDiv.className = 'text-right text-primary';
            userDiv.textContent = 'Bạn: '+message; // Sử dụng textContent
            console.log(message);
            chatbox.appendChild(userDiv);

            let loadingDiv = document.createElement('div');
            loadingDiv.className = 'text-left text-muted';
            loadingDiv.textContent = 'AI: Đang xử lý...';
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
                aiDiv.textContent = 'AI: ' + reply; // Sử dụng textContent
                console.log(reply);
                chatbox.appendChild(aiDiv);

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

    <%@ include file="includes/footer.jsp" %>
</body>
</html>