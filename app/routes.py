from flask import Blueprint, render_template, jsonify, request
from .extensions import socketio
import subprocess
import os

main = Blueprint('main', __name__)

def run_script(script_name):
    script_path = os.path.join(os.getcwd(), 'scripts', script_name)
    if not os.path.exists(script_path):
        error_msg = f"Script not found: {script_path}"
        print(error_msg)
        return {"status": "error", "message": error_msg}
    
    try:
        print(f"Running script at path: {script_path}")  # Debug print
        result = subprocess.run(
            [script_path],
            capture_output=True, text=True, shell=True, check=True, cwd=os.path.dirname(script_path),
            env={**os.environ, 'PATH': os.path.join(os.getcwd(), 'scripts', 'adb') + os.pathsep + os.environ['PATH']}
        )
        output = f"Script executed.\nOutput: {result.stdout}\nError: {result.stderr}"
        print(output)
        return {"status": "success", "message": output}
    except subprocess.CalledProcessError as e:
        error_msg = f"Failed to execute script. Error: {e.stderr}"
        print(error_msg)
        return {"status": "error", "message": error_msg}
    except Exception as e:
        error_msg = f"Unexpected error: {str(e)}"
        print(error_msg)
        return {"status": "error", "message": error_msg}

@main.route('/')
def index():
    return render_template('index.html')

@main.route('/reset', methods=['POST'])
def reset_tablet():
    result = run_script('reset_tablet.bat')
    return jsonify(result)

@main.route('/optimize', methods=['POST'])
def optimize_tablet():
    result = run_script('optimize_tablet.bat')
    return jsonify(result)

@main.route('/disable_keyboard', methods=['POST'])
def disable_keyboard():
    result = run_script('disable_keyboard.bat')
    return jsonify(result)

@main.route('/clear_cache', methods=['POST'])
def clear_cache():
    result = run_script('clear_cache.bat')
    return jsonify(result)

@socketio.on('connect')
def handle_connect():
    print('Client connected')
    emit_connected_devices()

@socketio.on('disconnect')
def handle_disconnect():
    print('Client disconnected')

def emit_connected_devices():
    result = run_script('list_devices.bat')
    socketio.emit('device_list', {'output': result['message']})
