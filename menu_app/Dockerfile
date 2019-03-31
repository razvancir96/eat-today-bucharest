FROM python:3.5-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk update
RUN apk add mariadb-dev
RUN apk add build-base
RUN pip install -r /requirements.txt

RUN mkdir /eat-today-bucharest
WORKDIR /eat-today-bucharest
COPY . /eat-today-bucharest/
