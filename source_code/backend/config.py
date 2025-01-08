import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    # MySQL Configuration
    SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://ecommerce_user:ecommerce_password@ecommerce-mysql/ecommerce'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # MongoDB Configuration
    MONGO_URI = 'mongodb://ecommerce-mongodb-internal:27017/ecommerce'
    
    # JWT Configuration
    JWT_SECRET_KEY = os.getenv('JWT_SECRET_KEY', 'your-secret-key')

class TestConfig(Config):
    TESTING = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///:memory:'
    MONGO_URI = 'mongodb://localhost:27017/test_db' 