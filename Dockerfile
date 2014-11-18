FROM ubuntu:14.04

RUN apt-get update && apt-get install -y postgresql libjpeg62 libpng3 build-essential
RUN apt-get update && apt-get install -y python python-dev python-virtualenv python3 python3-dev supervisor
RUN pip install -U tox flake8

RUN pip install -U frigg-worker
