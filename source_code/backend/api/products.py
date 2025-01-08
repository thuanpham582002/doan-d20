from flask import request
from flask_restx import Namespace, Resource, fields
from werkzeug.security import generate_password_hash

from extensions import store

ns_products = Namespace('api/products', description='Product operations')

product_model = ns_products.model('Product', {
    'id': fields.Integer(readonly=True, description='Product ID'),
    'name': fields.String(required=True, description='Product name'),
    'description': fields.String(description='Product description'),
    'price': fields.Float(required=True, description='Product price'),
    'stock': fields.Integer(required=True, description='Product stock'),
    'image_url': fields.String(description='URL to product image')
})

@ns_products.route('/')
class ProductList(Resource):
    @ns_products.doc('list_products')
    @ns_products.marshal_list_with(product_model)
    def get(self):
        """List all products"""
        return store.get_all_products()

@ns_products.route('/<int:id>')
class ProductItem(Resource):
    @ns_products.doc('get_product')
    @ns_products.marshal_with(product_model)
    def get(self, id):
        """Get a product by ID"""
        product = store.get_product(id)
        if not product:
            ns_products.abort(404, f"Product {id} not found")
        return product

@ns_products.route('/initialize-data')
class InitializeData(Resource):
    @ns_products.doc('initialize_data', 
                    description='Initialize with sample data')
    def post(self):
        """Initialize with sample data"""
        try:
            data = request.get_json()
            
            # Create users
            created_users = []
            if 'users' in data:
                for user_data in data['users']:
                    hashed_password = generate_password_hash(user_data['password'])
                    store.add_user(
                        username=user_data['username'],
                        email=user_data['email'],
                        password=hashed_password
                    )
                    created_users.append(user_data['username'])

            # Create products
            created_products = []
            if 'products' in data:
                for product_data in data['products']:
                    store.add_product(
                        name=product_data['name'],
                        description=product_data.get('description', ''),
                        price=product_data['price'],
                        stock=product_data['stock'],
                        image_url=product_data.get('image_url', '')
                    )
                    created_products.append(product_data['name'])

            return {
                'message': 'Data initialized successfully',
                'created_users': created_users,
                'created_products': created_products
            }, 201

        except Exception as e:
            return {'error': str(e)}, 400

@ns_products.route('/delete-all-data')
class DeleteAllData(Resource):
    @ns_products.doc('delete_all_data',
                    description='Delete all data')
    def delete(self):
        """Delete all data"""
        try:
            store.clear()
            return {
                'message': 'All data deleted successfully'
            }, 200
        except Exception as e:
            return {'error': str(e)}, 400 