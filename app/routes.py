import subprocess
import os
import logging
from flask import Blueprint, render_template, jsonify
from flask_socketio import emit
import psutil
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
            timeout=120,
            env={**os.environ, 'PATH': os.path.join(os.getcwd(), 'scripts', 'adb') + os.pathsep + os.environ['PATH']}
        )
        if result.returncode == 0:
            success_message = f"Script executed successfully. Output: {result.stdout}"
            logging.debug(success_message)
            return {"status": "success", "message": success_message, "output": result.stdout}
        else:
            error_message = f"Script executed with errors. Error: {result.stderr}"
            logging.debug(error_message)
            return {"status": "error", "message": error_message, "output": result.stderr}
    except subprocess.TimeoutExpired:
        error_msg = "Script execution timed out."
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

# Route to serve the main page
@main.route('/')
def index():
    logging.debug("Serving index page.")
    return render_template('index.html')

# Group: Disable Unnecessary Processes
@main.route('/disable_google_bloatware', methods=['POST'])
def disable_google_bloatware():
    result = run_script('disable_google_bloatware.bat')
    return jsonify(result)

@main.route('/disable_samsung_bloatware', methods=['POST'])
def disable_samsung_bloatware():
    result = run_script('disable_samsung_bloatware.bat')
    return jsonify(result)

@main.route('/disable_misc_bloatware', methods=['POST'])
def disable_misc_bloatware():
    result = run_script('disable_misc_bloatware.bat')
    return jsonify(result)

@main.route('/disable_keyboard', methods=['POST'])
def disable_keyboard():
    result = run_script('disable_keyboard.bat')
    return jsonify(result)

# Group: Performance Optimization
@main.route('/disable_power_saving', methods=['POST'])
def disable_power_saving():
    result = run_script('disable_power_saving.bat')
    return jsonify(result)

@main.route('/disable_battery_optimization', methods=['POST'])
def disable_battery_optimization():
    logging.debug("Received POST request for /disable_battery_optimization")
    result = run_script('disable_battery_optimization.bat')
    logging.debug(f"Response for /disable_battery_optimization: {result}")
    return jsonify(result)

@main.route('/set_cpu_governor_performance', methods=['POST'])
def set_cpu_governor_performance():
    result = run_script('set_cpu_governor_performance.bat')
    return jsonify(result)

@main.route('/turn_off_animations', methods=['POST'])
def turn_off_animations():
    result = run_script('turn_off_animations.bat')
    return jsonify(result)

@main.route('/limit_background_processes', methods=['POST'])
def limit_background_processes():
    result = run_script('limit_background_processes.bat')
    return jsonify(result)

@main.route('/disable_background_data', methods=['POST'])
def disable_background_data():
    result = run_script('disable_background_data.bat')
    return jsonify(result)

@main.route('/boost_wifi_network', methods=['POST'])
def boost_wifi_network():
    result = run_script('boost_wifi_network.bat')
    return jsonify(result)

# Group: System Management
@main.route('/clear_cache', methods=['POST'])
def clear_cache():
    result = run_script('clear_cache.bat')
    return jsonify(result)

@main.route('/restore_default_settings', methods=['POST'])
def restore_default_settings():
    result = run_script('restore_default_settings.bat')
    return jsonify(result)

@main.route('/enter_recovery_mode', methods=['POST'])
def enter_recovery_mode():
    result = run_script('enter_recovery_mode.bat')
    return jsonify(result)

@main.route('/list_devices', methods=['POST'])
def list_devices():
    logging.debug("Received POST request for /list_devices")
    result = run_script('list_devices.bat')
    logging.debug(f"Response for /list_devices: {result}")
    return jsonify(result)

# Metrics route for dashboard data
@main.route('/metrics')
def get_metrics():
    battery = psutil.sensors_battery()
    metrics = {
        'cpu': {
            'usage': psutil.cpu_percent(interval=1),
            'top_process': get_top_process('cpu_percent')
        },
        'memory': {
            'total': psutil.virtual_memory().total,
            'used': psutil.virtual_memory().used,
            'free': psutil.virtual_memory().free,
            'top_process': get_top_process('memory_percent')
        },
        'disk': {
            'read': psutil.disk_io_counters().read_bytes,
            'write': psutil.disk_io_counters().write_bytes,
            'top_process': get_top_process('io_counters')
        },
        'network': {
            'sent': psutil.net_io_counters().bytes_sent,
            'recv': psutil.net_io_counters().bytes_recv,
            'top_process': get_top_process('io_counters')
        },
        'battery': {
            'percentage': battery.percent if battery else "N/A",
            'top_process': {'name': 'N/A', 'pid': 'N/A'}
        }
    }
    return jsonify(metrics)

def get_top_process(metric):
    processes = [p.info for p in psutil.process_iter(['pid', 'name', metric])]
    top_process = max(processes, key=lambda p: p.get(metric, 0), default={'name': 'N/A', 'pid': 'N/A'})
    return top_process

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
