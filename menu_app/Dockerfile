FROM python:3.5

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /eat-today-bucharest
WORKDIR /eat-today-bucharest

RUN pip install pip -U
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY . /eat-today-bucharest/
EXPOSE 8000