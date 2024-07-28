from flask import Flask
from .routes import main
from .extensions import socketio 

def create_app():
    app = Flask(__name__)
    app.register_blueprint(main)

    socketio.init_app(app, cors_allowed_origins="*")
    return app
