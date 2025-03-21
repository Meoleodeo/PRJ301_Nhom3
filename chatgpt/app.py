from flask import Flask, request, jsonify
from gemini_predict import predict_answer

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def get_prediction():
    data = request.get_json()
    question = data.get('question', '')
    answer = predict_answer(question)
    return jsonify({'answer': answer})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)