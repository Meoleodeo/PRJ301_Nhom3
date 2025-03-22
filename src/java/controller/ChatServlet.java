package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import static controller.APIKey.GEMINI_API_KEY;
import static dao.ProductDAO.getAllProducts;
import java.util.List;
import model.Product;

public class ChatServlet extends HttpServlet {

    private static final String GEMINI_MODEL = "gemini-2.0-flash-thinking-exp-01-21"; // Model name đã cập nhật
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/" + GEMINI_MODEL + ":generateContent?key=" + GEMINI_API_KEY; // Endpoint đã cập nhật

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userMessage = request.getParameter("message");
        String configMessage = setPromtForAI(userMessage); 
        userMessage =  configMessage;
        
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("Lỗi: Tin nhắn không được để trống!");
            return;
        }

        String geminiResponse = callGeminiAPI(userMessage);
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(geminiResponse);
    }

    private String callGeminiAPI(String message) {
        if (GEMINI_API_KEY == null || GEMINI_API_KEY.isEmpty()) {
            return "Lỗi: API Key không hợp lệ!";
        }

        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            String requestBody = "{\"contents\": [{\"parts\": [{\"text\": \"" + message.replace("\"", "\\\"") + "\"}]}]}";

            try (OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes("UTF-8"));
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                return "Lỗi API: " + responseCode + " - " + conn.getResponseMessage();
            }

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }

                return parseGeminiResponse(response.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi khi gọi Google Gemini API: " + e.getMessage();
        }
    }

    private String parseGeminiResponse(String jsonResponse) {
        try {
            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            JsonArray candidates = jsonObject.getAsJsonArray("candidates");
            if (candidates != null && candidates.size() > 0) {
                JsonObject candidate = candidates.get(0).getAsJsonObject();
                JsonArray parts = candidate.getAsJsonObject("content").getAsJsonArray("parts");
                if (parts != null && parts.size() > 0) {
                    return parts.get(0).getAsJsonObject().get("text").getAsString();
                }
            }
            return "Không tìm thấy phản hồi từ Gemini.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi khi phân tích phản hồi từ Gemini.";
        }
    }
    
    private String setPromtForAI(String usermess){ 
        List<Product> products = getAllProducts();
        String promt ="hãy tưởng tượng bạn là nhân viên của BlackShope (sàn thương mại điện tử); bạn chỉ việc trả lời chứ không cần phải mô tả một cuộc hội thoại với khách hàng. bạn chỉ cần trả lời như 1 nhân viên ngầu lòi!, đây là danh sách sản phẩm của chúng tôi " ;
        for (Product product : products) {
            promt += product.toString();
        }
        promt +=  "và đây là câu thoại của khách: " + usermess ;
       return promt;
    }
}