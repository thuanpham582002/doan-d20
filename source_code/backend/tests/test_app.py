import pytest
from unittest.mock import patch, MagicMock
import json

from app import create_app
from extensions import db, mongo
from config import TestConfig
from models import User, Product

@pytest.fixture(scope='session')
def app():
    app = create_app(TestConfig)
    return app

@pytest.fixture
def client(app):
    with app.test_client() as client:
        with app.app_context():
            db.create_all()
            yield client
            db.session.remove()
            db.drop_all()

@pytest.fixture
def auth_headers():
    return {
        'Authorization': 'Bearer mock_token',
        'Content-Type': 'application/json'
    }

# Test Authentication Endpoints
def test_register(client):
    data = {
        'username': 'newuser',
        'email': 'new@test.com',
        'password': 'password123'
    }
    response = client.post('/api/auth/register', json=data)
    assert response.status_code == 201
    assert User.query.filter_by(username='newuser').first() is not None

def test_login_success(client):
    # First register a user
    register_data = {
        'username': 'testuser',
        'email': 'test@test.com',
        'password': 'password123'
    }
    client.post('/api/auth/register', json=register_data)
    
    # Then try to login
    login_data = {
        'username': 'testuser',
        'password': 'password123'
    }
    response = client.post('/api/auth/login', json=login_data)
    assert response.status_code == 200
    assert 'token' in response.get_json()

# Test Product Endpoints
def test_get_products(client):
    response = client.get('/api/products/')
    assert response.status_code == 200
    assert response.get_json() == []

def test_get_product_not_found(client):
    response = client.get('/api/products/999')
    assert response.status_code == 404

#Error test
# Test Cart Endpoints
# def test_get_cart(client, auth_headers):
#     with patch('flask_jwt_extended.utils.get_jwt_identity', return_value=1):
#         with patch('flask_pymongo.PyMongo.db') as mock_db:
#             mock_db.carts.find_one.return_value = {'items': []}
#             response = client.get('/api/cart/', headers=auth_headers)
#             assert response.status_code == 200
#             assert response.get_json()['items'] == []

#Error test
# def test_add_to_cart(client, auth_headers):
#     # Create a product first
#     product = Product(name='Test Product', price=10.0, stock=5)
#     with client.application.app_context():
#         db.session.add(product)
#         db.session.commit()
#         product_id = product.id

#     with patch('flask_jwt_extended.utils.get_jwt_identity', return_value=1):
#         with patch('flask_pymongo.PyMongo.db') as mock_db:
#             mock_db.carts.find_one.return_value = None
#             mock_db.carts.update_one = MagicMock()
            
#             data = {
#                 'product_id': product_id,
#                 'quantity': 2
#             }
#             response = client.post('/api/cart/add', 
#                                 headers=auth_headers,
#                                 json=data)
#             assert response.status_code == 200 