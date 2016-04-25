import json

from flask import Flask,jsonify,abort,make_response,request
from flaskext.mysql import MySQL
app = Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'smart_citizen'
app.config['MYSQL_DATABASE_HOST'] = '127.0.0.1'
app.config['MYSQL_DATABASE_CHARSET'] = 'utf8'
mysql.init_app(app)

keysForLogin = ['email','password']
keysForRegister = ['name','surname','email','password','phone','city','district']


def check_auth(email,password):
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM Users WHERE USR_email ='%s'" % (email))
    r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]

    if r:
        cursor.execute("SELECT USR_name as name, USR_surname as surname, USR_email as email, USR_password as password,\
         USR_phone as phone, USR_city as city, USR_district as district \
         FROM Users WHERE USR_email ='%s' and USR_password='%s' " % (email,password))
        r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
        cursor.connection.close()
        if r:
            result = {'data' : r[0], 'serviceCode' : 0, 'exception': None}
            return jsonify(result)
        else:
            return jsonify({'serviceCode': '1', 'data': None , 'exception': {'exceptionCode':'1', 'exceptionMessage':'The password is incorrect'}})
    else:
        cursor.connection.close()
        return jsonify({'serviceCode': '1', 'data': None , 'exception': {'exceptionCode':'2', 'exceptionMessage':'There is no user with email '+email}})



@app.route('/api/v1/memberLogin', methods=['POST'])
def memberLogin():
    if not request.json:
        abort(400)
    for key in keysForLogin:
        if not key in request.json:
            abort(400)

    result = check_auth(request.json['email'],request.json['password'])
    return result


@app.route('/api/v1/memberSignUp', methods=['POST'])
def register():
    if not request.json:
        abort(400)
    for key in keysForRegister:
        if not key in request.json:
            abort(400)

    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM Users WHERE USR_email ='%s'" % (request.json['email']))
    r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
    if r:
        return jsonify({'serviceCode':'1', 'data': None, 'exception':{'exceptionCode':'3', 'exceptionMessage':'This e-mail has already been registered'}})
    else:
        cursor.execute("INSERT INTO Users (USR_email,USR_name,USR_surname,USR_password,USR_phone,USR_city,USR_district) \
            VALUES ('%s','%s','%s','%s','%s','%s','%s');" % (request.json['email'],request.json['name'],request.json['surname'],\
                request.json['password'],request.json['phone'],request.json['city'],request.json['district']))
        
        conn.commit()
        result = check_auth(request.json['email'],request.json['password'])
        #id = cursor.lastrowid
        cursor.connection.close()
        return result


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not Found'}),404)

@app.errorhandler(400)
def bad_request(error):
    return make_response(jsonify({'ErrorCode':'400','ErrorMessage':'Bad_Request'}),400)

if __name__ == '__main__':
    #app.run(debug=True)
    host='0.0.0.0', 

