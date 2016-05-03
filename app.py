import json

from flask import Flask,jsonify,abort,make_response,request
from flaskext.mysql import MySQL
app = Flask(__name__)

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'smart'
app.config['MYSQL_DATABASE_HOST'] = '127.0.0.1'
app.config['MYSQL_DATABASE_CHARSET'] = 'utf8'
mysql.init_app(app)

keysForLogin = ['email','password']
keysForRegister = ['name','email','password']

def check_auth_for_modules(email,password):
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM User WHERE USR_email ='%s'" % (email))
    r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]

    if r:
        cursor.execute("SELECT USR_name as name, USR_email as email \
         FROM User WHERE USR_email ='%s' and USR_password='%s' " % (email,password))
        r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
        cursor.connection.close()
        if r:
            return 1
        else:
            return 2 #password incorrect
    else:
        cursor.connection.close()
        return 3 #email incorrect


def check_auth(email,password):
    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM User WHERE USR_email ='%s'" % (email))
    r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]

    if r:
        cursor.execute("Select USR_name as name, USR_email as email, USR_password as password, \
            Institution.`INS_name` as institution from User,Institution\
            where User.`USR_institution` = Institution.`INS_id` and \
            USR_email ='%s' and USR_password='%s' " % (email,password))
        r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
        cursor.connection.close()
        if r:
            result = {'data' : r[0], 'serviceCode' : 0, 'exception': None}
            return jsonify(result)
        else:
            return jsonify({'serviceCode': 1, 'data': None , 'exception': {'exceptionCode':1, 'exceptionMessage':'The password is incorrect'}})
    else:
        cursor.connection.close()
        return jsonify({'serviceCode': 1, 'data': None , 'exception': {'exceptionCode':2, 'exceptionMessage':'There is no user with email '+email}})



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

    cursor.execute("SELECT * FROM User WHERE USR_email ='%s'" % (request.json['email']))
    r = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
    if r:
        return jsonify({'serviceCode':'1', 'data': None, 'exception':{'exceptionCode':'3', 'exceptionMessage':'This e-mail has already been registered'}})
    else:
        cursor.execute("INSERT INTO User (USR_email,USR_name,USR_password,USR_institution) \
            VALUES ('%s','%s','%s',0);" % (request.json['email'],request.json['name'], request.json['password']))
        
        conn.commit()
        result = check_auth(request.json['email'],request.json['password'])
        #id = cursor.lastrowid
        cursor.connection.close()
        return result

@app.route('/api/v1/getReportsOnMap/<int:categ_id>', methods=['GET'])
def getOnReportsOnMap(categ_id):
    conn = mysql.connect()
    cursor = conn.cursor()

    if categ_id == 0:
        cursor.execute("Select Problem.`PRB_id` as id, Category.`CAT_name` as reportType, Problem.`PRB_title` as title, Problem.`PRB_explanation` as description,\
            Location.`LOC_latitude` as latitude, Location.`LOC_longitude` as longtitude from Problem, Location, Category\
            where Problem.`PRB_location` = Location.`LOC_id` and Problem.`PRB_category` = Category.`CAT_id`")
        reports = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]
    else:
        cursor.execute("Select Problem.`PRB_id` as id, Category.`CAT_name` as reportType, Problem.`PRB_title` as title, Problem.`PRB_explanation` as description, \
            Location.`LOC_latitude` as latitude, Location.`LOC_longitude` as longtitude from Problem, Location, Category \
            where Problem.`PRB_location` = Location.`LOC_id` and Problem.`PRB_category` = Category.`CAT_id` and Problem.`PRB_category` = '%s'" % (categ_id))
        reports = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]

    cursor.connection.close()
    return jsonify({'serviceCode':0, 'data': reports, 'exception': None})


@app.route('/api/v1/getReportsOnMap1', methods=['POST'])
def getOnReportsOnMap1():
    if not request.json:
        abort(400)
    for key in keysForLogin:
        if not key in request.json:
            abort(400)

    conn = mysql.connect()
    cursor = conn.cursor()

    cursor.execute("SELECT User.USR_institution FROM User WHERE USR_email ='%s'" % (request.json['email']))
    a = [dict((cursor.description[i][0], value) \
               for i, value in enumerate(row)) for row in cursor.fetchall()]

    resultCheck = check_auth_for_modules(request.json['email'],request.json['password'])

    if resultCheck == 1:
        if a[0]['USR_institution']==0:
            cursor.execute("Select Problem.`PRB_id` as id, Category.`CAT_name` as reportType, Problem.`PRB_title` as title,\
             Problem.`PRB_explanation` as description, Location.`LOC_latitude` as latitude, Location.`LOC_longitude` as longtitude \
             from Problem, Location, Category \
             where Problem.`PRB_location` = Location.`LOC_id` and Problem.`PRB_category` = Category.`CAT_id`")
            r = [dict((cursor.description[i][0], value) \
                   for i, value in enumerate(row)) for row in cursor.fetchall()]
            cursor.connection.close()
            return jsonify({'serviceCode':0, 'data': r, 'exception': None})

        else:    
            cursor.execute("SELECT Problem.`PRB_id` as id, Category.`CAT_name` as reportType, Problem.`PRB_title` as title, Problem.`PRB_explanation` as description, \
                Location.`LOC_latitude` as latitude, Location.`LOC_longitude` as longtitude FROM User, INS_CAT_NBH, Problem, Location, Category\
                WHERE User.`USR_institution` = INS_CAT_NBH.`ICN_institution` and Problem.`PRB_category` = INS_CAT_NBH.`ICN_category` and \
                Problem.`PRB_location` = Location.`LOC_id` and Location.`LOC_neighborhood` = INS_CAT_NBH.`ICN_neighborhood` and \
                Problem.`PRB_category` = Category.`CAT_id` and \
                User.`USR_email` = '%s' and User.`USR_password` = '%s'" % (request.json['email'],request.json['password']))
            r = [dict((cursor.description[i][0], value) \
                   for i, value in enumerate(row)) for row in cursor.fetchall()]
            cursor.connection.close()
            return jsonify({'serviceCode':0, 'data': r, 'exception': None})
    elif resultCheck==2: 
        return jsonify({'serviceCode':1, 'data': None, 'exception': {'exceptionCode':1, 'exceptionMessage':'The password is incorrect'}})
    elif resultCheck==3: 
        return jsonify({'serviceCode':1, 'data': None, 'exception': {'exceptionCode':2, 'exceptionMessage':'There is no user with email '+request.json['email']}})

 


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify({'error': 'Not Found'}),404)

@app.errorhandler(400)
def bad_request(error):
    return make_response(jsonify({'ErrorCode':'400','ErrorMessage':'Bad_Request'}),400)

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)
    #host='0.0.0.0',

