import json
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from transformers import BertTokenizer, TFBertForSequenceClassification
import tensorflow as tf

# 1. Đọc dữ liệu từ file JSON
with open('data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

questions = [item['question'] for item in data]
answers = [item['answer'] for item in data]

# 2. Gán nhãn cho các câu hỏi (mỗi câu hỏi là một intent duy nhất)
labels = list(range(len(questions)))  # Mỗi câu hỏi có một nhãn riêng (0, 1, 2, ...)

# 3. Tải tokenizer và mô hình BERT
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
model = TFBertForSequenceClassification.from_pretrained('bert-base-uncased', num_labels=len(labels))

# 4. Tokenize dữ liệu
def tokenize_data(questions):
    return tokenizer(
        questions,
        padding=True,
        truncation=True,
        max_length=128,
        return_tensors='tf'
    )

encoded_data = tokenize_data(questions)

# 5. Chuẩn bị dữ liệu huấn luyện
input_ids = encoded_data['input_ids']
attention_mask = encoded_data['attention_mask']
token_type_ids = encoded_data['token_type_ids']
y = tf.keras.utils.to_categorical(labels, num_classes=len(labels))

# Chia dữ liệu thành tập train và test
# Truyền từng mảng riêng lẻ và nhận kết quả tương ứng
train_test_split_data = train_test_split(
    input_ids.numpy(),  # Chuyển tensor về numpy
    attention_mask.numpy(),
    token_type_ids.numpy(),
    y,
    test_size=0.2,
    random_state=42
)

# Gán kết quả từ train_test_split
train_input_ids = tf.convert_to_tensor(train_test_split_data[0])
test_input_ids = tf.convert_to_tensor(train_test_split_data[1])
train_attention_mask = tf.convert_to_tensor(train_test_split_data[2])
test_attention_mask = tf.convert_to_tensor(train_test_split_data[3])
train_token_type_ids = tf.convert_to_tensor(train_test_split_data[4])
test_token_type_ids = tf.convert_to_tensor(train_test_split_data[5])
train_labels = train_test_split_data[6]
test_labels = train_test_split_data[7]

# Đóng gói thành danh sách để truyền vào mô hình
train_inputs = [train_input_ids, train_attention_mask, train_token_type_ids]
test_inputs = [test_input_ids, test_attention_mask, test_token_type_ids]

# 6. Biên dịch mô hình
optimizer = tf.keras.optimizers.Adam(learning_rate=2e-5)
loss = tf.keras.losses.CategoricalCrossentropy(from_logits=True)
model.compile(optimizer=optimizer, loss=loss, metrics=['accuracy'])

# 7. Huấn luyện mô hình
history = model.fit(
    train_inputs,  # [input_ids, attention_mask, token_type_ids]
    train_labels,
    validation_data=(test_inputs, test_labels),
    epochs=3,
    batch_size=8
)

# 8. Lưu mô hình
model.save_pretrained('chatbot_model')
tokenizer.save_pretrained('chatbot_model')

# Lưu ánh xạ nhãn -> câu trả lời
with open('label_to_answer.json', 'w', encoding='utf-8') as f:
    json.dump(dict(enumerate(answers)), f)