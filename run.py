from flask import Flask
from flask_socketio import SocketIO
from app.routes import main

app = Flask(__name__)
socketio = SocketIO(app)

app.register_blueprint(main)

if __name__ == '__main__':
    socketio.run(app, debug=True)
