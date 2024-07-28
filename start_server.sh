echo "Starting Flask server..."
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
export FLASK_APP=run.py
flask run
