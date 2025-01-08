from flask_sqlalchemy import SQLAlchemy
from flask_pymongo import PyMongo
from flask_jwt_extended import JWTManager

# Database instances
db = SQLAlchemy()
mongo = PyMongo()
jwt = JWTManager()

# In-memory data store
class InMemoryStore:
    def __init__(self):
        self.users = {}  # username -> user_data
        self.products = {}  # id -> product_data
        self.carts = {}  # user_id -> cart_data
        self.next_product_id = 1
        self.next_user_id = 1

    def add_user(self, username, email, password):
        user_id = self.next_user_id
        self.users[username] = {
            'id': user_id,
            'username': username,
            'email': email,
            'password': password
        }
        self.next_user_id += 1
        return user_id

    def add_product(self, name, description, price, stock, image_url=''):
        product_id = self.next_product_id
        self.products[product_id] = {
            'id': product_id,
            'name': name,
            'description': description,
            'price': price,
            'stock': stock,
            'image_url': image_url
        }
        self.next_product_id += 1
        return product_id

    def get_user(self, username):
        return self.users.get(username)

    def get_product(self, product_id):
        return self.products.get(product_id)

    def get_all_products(self):
        return list(self.products.values())

    def get_cart(self, user_id):
        return self.carts.get(user_id, {'user_id': user_id, 'items': []})

    def update_cart(self, user_id, cart_data):
        self.carts[user_id] = cart_data

    def clear(self):
        self.__init__()

# Create global instance
store = InMemoryStore() 