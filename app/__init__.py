from flask import Flask, render_template

app = Flask(__name__, template_folder='templates', static_folder='static')

@app.after_request
def set_security_headers(response):
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
    return response

@app.route('/')
def home():
    return render_template('index.html')
