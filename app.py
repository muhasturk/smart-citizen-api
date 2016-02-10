import json
from flask import Flask
app = Flask(__name__)

@app.route('/')
def rootWelcome():
    return 'Smart Citizen Rocks!'

@app.route('/api/v1/memberLogin')
def memberLogin():
    memberDict = {
        "email": "mustafa.hasturk@yandex.com",
        "password": "cokgizli"
    }
    memberLoginJSON = json.dumps(memberDict)
    return memberLoginJSON


if __name__ == '__main__':
    app.run(debug=True)