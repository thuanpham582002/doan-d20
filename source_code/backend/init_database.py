from app import create_app
from extensions import db
from init_db import init_users, init_products

def init_database():
    app = create_app()
    with app.app_context():
        # Drop all existing tables
        db.drop_all()
        
        # Create all tables with updated schema
        db.create_all()
        
        # Initialize data
        init_users()
        init_products()
        db.session.commit()
        print("Database initialized successfully!")

if __name__ == '__main__':
    init_database() 