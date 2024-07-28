import subprocess
import os
import logging
from flask import Blueprint, render_template, jsonify, request
from flask_socketio import emit
from . import socketio

logging.basicConfig(level=logging.DEBUG)

main = Blueprint('main', __name__)

def run_script(script_name):
    script_path = os.path.join(os.getcwd(), 'scripts', script_name)
    if not os.path.exists(script_path):
        error_msg = f"Script not found: {script_path}"
        logging.error(error_msg)
        return {"status": "error", "message": error_msg}
    
    try:
        logging.debug(f"Running script at path: {script_path}")
        result = subprocess.run(
            [script_path],
            capture_output=True, text=True, shell=True, check=True, cwd=os.path.dirname(script_path),
            timeout=120,  # Increase the timeout to 2 minutes
            env={**os.environ, 'PATH': os.path.join(os.getcwd(), 'scripts', 'adb') + os.pathsep + os.environ['PATH']}
        )
        success_message = f"Script executed successfully. Output: {result.stdout}"
        error_message = f"Script executed with errors. Error: {result.stderr}"
        logging.debug(success_message if result.returncode == 0 else error_message)
        return {
            "status": "success" if result.returncode == 0 else "error",
            "message": success_message if result.returncode == 0 else error_message,
            "output": result.stdout if result.returncode == 0 else result.stderr
        }
    except subprocess.TimeoutExpired:
        error_msg = f"Script execution timed out."
        logging.error(error_msg)
        return {"status": "error", "message": error_msg}
    except subprocess.CalledProcessError as e:
        error_msg = f"Failed to execute script. Error: {e.stderr}"
        logging.error(error_msg)
        return {"status": "error", "message": error_msg}
    except Exception as e:
        error_msg = f"Unexpected error: {str(e)}"
        logging.error(error_msg)
        return {"status": "error", "message": error_msg}

@main.route('/')
def index():
    logging.debug("Serving index page.")
    return render_template('index.html')

@main.route('/clear_cache', methods=['POST'])
def clear_cache():
    logging.debug("Received POST request for /clear_cache")
    result = run_script('clear_cache.bat')
    logging.debug(f"Response for /clear_cache: {result}")
    return jsonify(result)

@main.route('/disable_bixby', methods=['POST'])
def disable_bixby():
    logging.debug("Received POST request for /disable_bixby")
    result = run_script('disable_bixby.bat')
    logging.debug(f"Response for /disable_bixby: {result}")
    return jsonify(result)

@main.route('/disable_keyboard', methods=['POST'])
def disable_keyboard():
    logging.debug("Received POST request for /disable_keyboard")
    result = run_script('disable_keyboard.bat')
    logging.debug(f"Response for /disable_keyboard: {result}")
    return jsonify(result)

@main.route('/disable_notes', methods=['POST'])
def disable_notes():
    logging.debug("Received POST request for /disable_notes")
    result = run_script('disable_notes.bat')
    logging.debug(f"Response for /disable_notes: {result}")
    return jsonify(result)

@main.route('/limit_background_processes', methods=['POST'])
def limit_background_processes():
    logging.debug("Received POST request for /limit_background_processes")
    result = run_script('limit_background_processes.bat')
    logging.debug(f"Response for /limit_background_processes: {result}")
    return jsonify(result)

@main.route('/list_devices', methods=['POST'])
def list_devices():
    logging.debug("Received POST request for /list_devices")
    result = run_script('list_devices.bat')
    logging.debug(f"Response for /list_devices: {result}")
    return jsonify(result)

@main.route('/optimize_battery_usage', methods=['POST'])
def optimize_battery_usage():
    logging.debug("Received POST request for /optimize_battery_usage")
    result = run_script('optimize_battery_usage.bat')
    logging.debug(f"Response for /optimize_battery_usage: {result}")
    return jsonify(result)

@main.route('/set_performance_mode', methods=['POST'])
def set_performance_mode():
    logging.debug("Received POST request for /set_performance_mode")
    result = run_script('set_performance_mode.bat')
    logging.debug(f"Response for /set_performance_mode: {result}")
    return jsonify(result)

@main.route('/turn_off_animations', methods=['POST'])
def turn_off_animations():
    logging.debug("Received POST request for /turn_off_animations")
    result = run_script('turn_off_animations.bat')
    logging.debug(f"Response for /turn_off_animations: {result}")
    return jsonify(result)

@socketio.on('connect')
def handle_connect():
    logging.debug('Client connected')
    emit_connected_devices()

@socketio.on('disconnect')
def handle_disconnect():
    logging.debug('Client disconnected')

def emit_connected_devices():
    logging.debug("Emitting connected devices")
    result = run_script('list_devices.bat')
    socketio.emit('device_list', {'output': result['message']})
