# https://github.com/JasonHaley/hello-python/tree/master/app

from flask import Flask, request
import socket
import datetime

app = Flask(__name__)

@app.route("/")
def root():

    msg1 = 'From Hands On GKE (https://github.com/iganari/handson-gke)'
    msg2 = 'Your URL is '     + request.url
    msg3 = 'HostName is '     + host_name
    msg4 = 'Internal IP is '  + host_ip
    msg5 = 'Current time is ' + str(current_time)

    return msg1 + ',\n' + msg2 + ',\n' + msg3 + ',\n' + msg4 + ',\n' + msg5


@app.route('/<mypath>')
def path(mypath):

    msg1 = 'From Hands On GKE (https://github.com/iganari/handson-gke)'
    msg2 = 'Your URL is '     + request.url
    msg3 = 'HostName is '     + host_name
    msg4 = 'Internal IP is '  + host_ip
    msg5 = 'Current time is ' + str(current_time)

    return msg1 + ',\n' + msg2 + ',\n' + msg3 + ',\n' + msg4 + ',\n' + msg5


if __name__ == "__main__":

    host_name    = socket.gethostname()
    host_ip      = socket.gethostbyname(host_name)
    current_time = datetime.datetime.now()

    app.run(host='0.0.0.0')
