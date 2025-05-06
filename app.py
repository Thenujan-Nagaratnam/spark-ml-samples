from flask import Flask, request, jsonify, render_template, send_from_directory
import os
import requests
import webbrowser
import logging

app = Flask(__name__)
PREDICT_URL = 'http://172.18.113.33:9090/lyrics/predict'
TRAIN_URL = 'http://172.18.113.33:9090/lyrics/train'
MODEL_DIR_PATH = "../model"

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/static/<path:path>")
def serve_static(path):
    return send_from_directory("static", path)


@app.route('/predict', methods=['POST'])
def predict():

    lyrics = request.form.get("lyrics", "")

    print("lyrics", lyrics)

    response = requests.post(PREDICT_URL, headers={'Content-Type': 'text/plain'}, data=lyrics)
    raw = response.json()

    predicted_genre = raw.get("genre")
    probabilities = {}

    for key, value in raw.items():
        if key.endswith("Probability"):
            genre = key.replace("Probability", "")
            probabilities[genre] = value

    return jsonify({
        "predicted_genre": predicted_genre,
        "probabilities": probabilities
    })


@app.route('/train', methods=['GET'])
def train():
    if not (
        os.path.exists(MODEL_DIR_PATH)
        and os.path.isdir(MODEL_DIR_PATH)
        and len(os.listdir(MODEL_DIR_PATH)) > 0
    ):
        requests.get(TRAIN_URL)

    return True


# def load_model():
#     if not (
#         os.path.exists(MODEL_DIR_PATH)
#         and os.path.isdir(MODEL_DIR_PATH)
#         and len(os.listdir(MODEL_DIR_PATH)) > 0
#     ):
#         requests.get(TRAIN_URL)
#         return False
#     else:
#         return True


# @app.route("/predict", methods=["POST"])
# def predict():
#     if request.method == "POST":
#         try:
#             # Get lyrics from form
#             lyrics = request.form.get("lyrics", "")

#             if not lyrics:
#                 return jsonify({"error": "No lyrics provided"}), 400

#             # Make prediction
#             result = predict_genre(lyrics)

#             if "error" in result:
#                 return jsonify({"error": result["error"]}), 500

#             return jsonify(result)

#         except Exception as e:
#             logger.error(f"Error in prediction route: {str(e)}")
#             return jsonify({"error": str(e)}), 500

#     return jsonify({"error": "Method not allowed"}), 405


if __name__ == "__main__":

    # Create templates directory if it doesn't exist
    os.makedirs("templates", exist_ok=True)

    # Copy index.html to templates directory for Flask to find it
    if not os.path.exists("templates/index.html"):
        with open("index.html", "r") as f_src:
            with open("templates/index.html", "w") as f_dst:
                f_dst.write(f_src.read())

    # webbrowser.open("http://127.0.0.1:5000/")
    # Run the Flask app
    app.run(debug=True, host="0.0.0.0", port=5000)
