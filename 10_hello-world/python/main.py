# https://github.com/JasonHaley/hello-python/tree/master/app

from flask import Flask, request
import socket
import datetime

app = Flask(__name__)

@app.route("/")
def hello():
    msg ='Your URL is "{}" .\nFrom Hands On GKE.\nHostName: {}\nIP: {}\nCurrent time: {}\n'.format(request.url, host_name, host_ip, current_time) 

    return msg 


@app.route('/<mypath>')
def show_path(mypath):
    msg ='Your URL is "{}" .\nFrom Hands On GKE.\nHostName: {}\nIP: {}\nCurrent time: {}\n'.format(request.url, host_name, host_ip, current_time) 

    return msg 


if __name__ == "__main__":
    host_name    = socket.gethostname()
    host_ip      = socket.gethostbyname(host_name)
    current_time = datetime.datetime.now()

    app.run(host='0.0.0.0')

