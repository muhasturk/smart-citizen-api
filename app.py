import json

from flask import Flask

app = Flask(__name__)

@app.route('/')
def rootWelcome():
    return 'Smart Citizen Rocks!'



@app.route('/api/v1/memberLogin')
def memberLogin():
    memberLoginJSON = Services.Login.getLoginJSON()
    return memberLoginJSON

if __name__ == '__main__':
    app.run(debug=True)