FROM ubuntu:14.04

RUN apt-get update && apt-get install -y postgresql libjpeg62 libpng3 build-essential git
RUN apt-get update && apt-get install -y python python-dev python-virtualenv python3 python3-dev supervisor
RUN pip install -U tox flake8

ADD worker.yaml /etc/frigg/worker.yaml

RUN pip install -e git+https://github.com/frigg/frigg-worker.git#egg=frigg-worker
CMD ["frigg-worker", "start"]
