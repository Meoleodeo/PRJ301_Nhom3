import json
import google.generativeai as genai

# 1. Cấu hình API Key
genai.configure(api_key="AIzaSyCXe31E4cLs0tZVEtauMU3G6v9lxM3PCW4")  # Thay bằng API Key của bạn

# 2. Đọc dữ liệu từ file JSON
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# Tạo context từ dữ liệu
context = "Dưới đây là thông tin sản phẩm và dịch vụ của chúng tôi:\n"
for item in data:
    context += f"- Hỏi: {item['question']} | Đáp: {item['answer']}\n"
context += "\nDựa trên thông tin trên, hãy trả lời câu hỏi của khách hàng một cách chính xác và tự nhiên."

# 3. Hàm dự đoán với Gemini
def predict_answer(question):
    model = genai.GenerativeModel('gemini-1.5-flash')  # Model Gemini miễn phí
    prompt = f"{context}\n\nCâu hỏi từ khách hàng: {question}\nTrả lời:"
    
    response = model.generate_content(prompt)
    answer = response.text.strip()
    return answer

# 4. Thử nghiệm
if __name__ == "__main__":
    question = "Giá sản phẩm A là bao nhiêu?"
    answer = predict_answer(question)
    print(f"Câu hỏi: {question}")
    print(f"Trả lời: {answer}")