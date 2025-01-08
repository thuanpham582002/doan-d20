from werkzeug.security import generate_password_hash
from extensions import store

def init_users():
    users = [
        {
            'username': 'admin',
            'email': 'admin@example.com',
            'password': generate_password_hash('admin123')
        },
        {
            'username': 'user1',
            'email': 'user1@example.com',
            'password': generate_password_hash('user123')
        }
    ]
    
    for user_data in users:
        store.add_user(
            username=user_data['username'],
            email=user_data['email'],
            password=user_data['password']
        )

def init_products():
    products = [
        {
            'name': 'Laptop',
            'description': 'High-performance laptop with latest specifications',
            'price': 999.99,
            'stock': 10,
            'image_url': 'https://picsum.photos/id/0/800/600'
        },
        {
            'name': 'Smartphone',
            'description': 'Latest model smartphone with advanced features',
            'price': 699.99,
            'stock': 15,
            'image_url': 'https://picsum.photos/id/1/800/600'
        },
        {
            'name': 'Headphones',
            'description': 'Wireless noise-canceling headphones',
            'price': 199.99,
            'stock': 20,
            'image_url': 'https://picsum.photos/id/3/800/600'
        },
        {
            'name': 'Smartwatch',
            'description': 'Fitness tracking smartwatch with heart rate monitor',
            'price': 299.99,
            'stock': 12,
            'image_url': 'https://picsum.photos/id/2/800/600'
        }
    ]
    
    for product_data in products:
        store.add_product(**product_data) 