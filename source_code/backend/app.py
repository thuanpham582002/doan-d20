from flask import Flask
from flask_cors import CORS
from flask_restx import Api
from dotenv import load_dotenv
import os

from extensions import jwt, store
from config import Config
from api.auth import ns_auth
from api.products import ns_products
from api.cart import ns_cart
from init_db import init_users, init_products

def create_app(config_class=Config):
    # Load environment variables
    load_dotenv()
    
    # Initialize Flask app
    app = Flask(__name__)
    app.config.from_object(config_class)
    
    # Initialize extensions
    CORS(app)
    jwt.init_app(app)
    
    # Initialize sample data
    store.clear()  # Clear any existing data
    init_users()
    init_products()
    
    # Configure Swagger
    authorizations = {
        'Bearer Auth': {
            'type': 'apiKey',
            'in': 'header',
            'name': 'Authorization',
            'description': "Type in the *'Value'* input box below: **'Bearer &lt;JWT&gt;'**, where JWT is the token"
        },
    }
    
    api = Api(app, version='1.0', title='E-commerce API',
              description='A simple e-commerce API',
              authorizations=authorizations,
              security='Bearer Auth',
              doc='/swagger'
            )
    
    # Register namespaces
    api.add_namespace(ns_auth)
    api.add_namespace(ns_products)
    api.add_namespace(ns_cart)

    @app.route('/init-data')
    def init_data():
        try:
            # Clear existing data
            store.clear()
            # Initialize sample data
            init_users()
            init_products()
            return {"message": "Data initialized successfully"}, 200
        except Exception as e:
            return {"error": f"Data initialization failed: {str(e)}"}, 500
    
    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True, host='0.0.0.0') 