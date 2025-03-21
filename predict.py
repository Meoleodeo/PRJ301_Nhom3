import json
from transformers import BertTokenizer, TFBertForSequenceClassification
import tensorflow as tf

# 1. Tải mô hình và tokenizer đã huấn luyện
tokenizer = BertTokenizer.from_pretrained('chatbot_model')
model = TFBertForSequenceClassification.from_pretrained('chatbot_model')

# 2. Tải ánh xạ nhãn -> câu trả lời
with open('label_to_answer.json', 'r', encoding='utf-8') as f:
    label_to_answer = json.load(f)

# 3. Hàm dự đoán
def predict_answer(question):
    # Tokenize câu hỏi
    encoded_input = tokenizer(
        question,
        padding=True,
        truncation=True,
        max_length=128,
        return_tensors='tf'
    )
    
    # Dự đoán
    outputs = model(encoded_input)
    logits = outputs.logits
    predicted_label = tf.argmax(logits, axis=1).numpy()[0]
    
    # Trả về câu trả lời tương ứng
    return label_to_answer[str(predicted_label)]

# 4. Thử nghiệm
if __name__ == "__main__":
    question = "Giá sản phẩm X là bao nhiêu?"
    answer = predict_answer(question)
    print(f"Câu hỏi: {question}")
    print(f"Trả lời: {answer}")