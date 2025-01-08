from flask import jsonify, request
from flask_restx import Namespace, Resource, fields
from flask_jwt_extended import jwt_required, get_jwt_identity

from extensions import mongo
from models import Product

ns_cart = Namespace('api/cart', description='Cart operations')

cart_item_model = ns_cart.model('CartItem', {
    'product_id': fields.Integer(required=True, description='Product ID'),
    'quantity': fields.Integer(required=True, description='Quantity')
})

@ns_cart.route('/')
class Cart(Resource):
    @ns_cart.doc('get_cart')
    @jwt_required()
    def get(self):
        """Get user's cart"""
        user_id = get_jwt_identity()
        cart = mongo.db.carts.find_one({'user_id': user_id})
        return jsonify(cart if cart else {'items': []})

@ns_cart.route('/add')
class AddToCart(Resource):
    @ns_cart.expect(cart_item_model)
    @ns_cart.doc('add_to_cart')
    @jwt_required()
    def post(self):
        """Add item to cart"""
        user_id = get_jwt_identity()
        data = request.get_json()
        product_id = data['product_id']
        quantity = data.get('quantity', 1)
        
        product = Product.query.get_or_404(product_id)
        if product.stock < quantity:
            return {"error": "Not enough stock available"}, 400
        
        cart = mongo.db.carts.find_one({'user_id': user_id})
        if cart:
            existing_item = next((item for item in cart.get('items', []) 
                                if item['product_id'] == product_id), None)
            if existing_item:
                new_quantity = existing_item['quantity'] + quantity
                if new_quantity > product.stock:
                    return {"error": "Not enough stock available"}, 400
                
                mongo.db.carts.update_one(
                    {'user_id': user_id, 'items.product_id': product_id},
                    {'$set': {'items.$.quantity': new_quantity}}
                )
                return {"message": "Cart updated successfully"}
        
        mongo.db.carts.update_one(
            {'user_id': user_id},
            {'$push': {'items': {'product_id': product_id, 'quantity': quantity}}},
            upsert=True
        )
        return {"message": "Item added to cart"}

@ns_cart.route('/remove/<int:product_id>')
class RemoveFromCart(Resource):
    @ns_cart.doc('remove_from_cart')
    @jwt_required()
    def delete(self, product_id):
        """Remove item from cart"""
        user_id = get_jwt_identity()
        
        result = mongo.db.carts.update_one(
            {'user_id': user_id},
            {'$pull': {'items': {'product_id': product_id}}}
        )
        
        if result.modified_count > 0:
            return {"message": "Item removed from cart"}
        return {"error": "Item not found in cart"}, 404

@ns_cart.route('/update/<int:product_id>')
class UpdateCartQuantity(Resource):
    @ns_cart.expect(cart_item_model)
    @ns_cart.doc('update_cart_quantity')
    @jwt_required()
    def put(self, product_id):
        """Update item quantity in cart"""
        user_id = get_jwt_identity()
        data = request.get_json()
        quantity = data.get('quantity', 1)
        
        product = Product.query.get_or_404(product_id)
        if product.stock < quantity:
            return {"error": "Not enough stock available"}, 400
        
        result = mongo.db.carts.update_one(
            {'user_id': user_id, 'items.product_id': product_id},
            {'$set': {'items.$.quantity': quantity}}
        )
        
        if result.modified_count > 0:
            return {"message": "Cart updated successfully"}
        return {"error": "Item not found in cart"}, 404 