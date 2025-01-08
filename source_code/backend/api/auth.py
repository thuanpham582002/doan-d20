from flask import request
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import create_access_token
from werkzeug.security import generate_password_hash, check_password_hash

from extensions import db
from models import User

ns_auth = Namespace('api/auth', description='Authentication operations')

user_model = ns_auth.model('User', {
    'username': fields.String(required=True, description='Username'),
    'email': fields.String(required=True, description='Email address'),
    'password': fields.String(required=True, description='Password')
})

login_model = ns_auth.model('Login', {
    'username': fields.String(required=True, description='Username'),
    'password': fields.String(required=True, description='Password')
})

@ns_auth.route('/register')
class Register(Resource):
    @ns_auth.expect(user_model)
    @ns_auth.doc('register_user')
    def post(self):
        """Register a new user"""
        data = request.get_json()
        hashed_password = generate_password_hash(data['password'])
        new_user = User(
            username=data['username'],
            email=data['email'],
            password=hashed_password
        )
        try:
            db.session.add(new_user)
            db.session.commit()
            return {"message": "User created successfully"}, 201
        except Exception as e:
            db.session.rollback()
            return {"error": "Username or email already exists"}, 400

@ns_auth.route('/login')
class Login(Resource):
    @ns_auth.expect(login_model)
    @ns_auth.doc('login_user')
    def post(self):
        """Login and get access token"""
        data = request.get_json()
        user = User.query.filter_by(username=data['username']).first()
        if user and check_password_hash(user.password, data['password']):
            access_token = create_access_token(identity=user.id)
            return {"token": access_token}, 200
        return {"error": "Invalid credentials"}, 401 