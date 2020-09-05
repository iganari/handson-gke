# https://github.com/JasonHaley/hello-python/tree/master/app

from flask import Flask
import socket
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Python!"

@app.route('/<mypath>')
def show_path(mypath):
    host_name = socket.gethostname()
    host_ip   = socket.gethostbyname(host_name)
    return 'Your Path is "/{}" .\nFrom Hands On GKE.\nHostName: {}\nIP: {}'.format(mypath, host_name, host_ip)

if __name__ == "__main__":
    app.run(host='0.0.0.0')
