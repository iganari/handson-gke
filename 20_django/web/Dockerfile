FROM python:3.9.1-alpine3.13

ENV PYTHONUNBUFFERED=1

RUN mkdir /code
COPY requirements.txt /code/

WORKDIR /code
RUN pip3 install -r requirements.txt
# COPY . /code/
