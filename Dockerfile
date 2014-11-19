FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git unzip vim wget && \
  rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y postgresql postgresql-server-dev-9.3 libjpeg62 libpng3
RUN apt-get update && apt-get install -y python python-dev python-virtualenv python3 python3-dev supervisor

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN \
  apt-get update && \
  apt-get install -y maven

RUN \
  apt-get update && \
  apt-get install -y ruby ruby-dev ruby-bundler

RUN pip install -U tox flake8

RUN apt-get update && apt-get install -y nodejs

RUN wget https://dl.bintray.com/sbt/debian/sbt-0.13.6.deb && dpkg -i sbt-0.13.6.deb

RUN gem install jekyll

ADD worker.yaml /etc/frigg/worker.yaml

RUN pip install -e git+https://github.com/frigg/frigg-worker.git#egg=frigg-worker
CMD ["frigg-worker", "start"]
