from app import create_app
from flask_socketio import SocketIO
import gevent.monkey

gevent.monkey.patch_all()

app = create_app()

socketio = SocketIO(app, async_mode='gevent')

if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5000)
