from flask import Flask
from flask_socketio import SocketIO

socketio = SocketIO()

def create_app():
    app = Flask(__name__, template_folder='../templates')

    from .routes import main
    app.register_blueprint(main)

    socketio.init_app(app, cors_allowed_origins="*")
    return app
