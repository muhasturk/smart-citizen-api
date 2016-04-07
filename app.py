import json

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return """
    <style> 
    p {
    color: red;
    }
    </style>
    <p> Çalıştı </p>"""

@app.route('/login')
def rootWelcome():
    name = "Mustafa"
    surname = "hasturk"

    parameters = {
    "name": name,
    "surname": surname
    }
    
    appJson = json.dumps(parameters)
    return appJson


if __name__ == '__main__':
    app.run(debug=True)