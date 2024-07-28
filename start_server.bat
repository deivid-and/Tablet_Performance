@echo off
echo Starting Flask server...
python -m venv venv
call venv\Scripts\activate
pip install -r requirements.txt
set FLASK_APP=run.py
flask run
pause
