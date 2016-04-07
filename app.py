import json

from flask import Flask,jsonify,abort,make_response,request
app = Flask(__name__)

users = [
	{
		'user_id' : 101,
		'username' : 'Engin',
		'surname' : 'Isik',
		'email' : 'iskengin@gmail.com',
		'password' : '12345'
	},
	{
		'user_id' : 102,
		'username' : 'Mustafa',
		'surname' : 'Hasturk',
		'email' : 'mustafa.hasturk@yandex.com',
		'password' : 'cokgizli'
	}
]

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

@app.route('/api/v1/memberLogin1')
def memberLogin1():
    memberDict = {
        "email": "mustafa.hasturk@yandex.com",
        "password": "cokgizli"
    }
    
    appJson = json.dumps(parameters)
    return appJson

@app.route('/api/v1/memberLogin', methods=['POST'])
def memberLogin():
    if not request.json or not 'email' in request.json or not 'password' in request.json:
        abort(400)
    user = [user for user in users if user['email'] == request.json['email'] and user['password'] == request.json['password']]
    if len(user) == 0:
        return jsonify({'ServiceCode':'1', 'ExceptionMessage':'Record not found'})
    return jsonify({'ServiceCode':'0','User': user[0]})

@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not Found'}),404)

@app.errorhandler(400)
def bad_request(error):
    return make_response(jsonify({'error': 'Bad_Request'}),400)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

