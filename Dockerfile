FROM openjdk:8-jre

MAINTAINER Mustafa Abuelfadl <mustafa@zidan.me>

RUN echo 'deb http://ftp.de.debian.org/debian testing main' \
    | tee -a /etc/apt/sources.list

RUN echo 'APT::Default-Release "stable";'\
    | tee -a /etc/apt/apt.conf.d/00local

# Install dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install \
    -yq --no-install-recommends -t testing python3.7 \
  && DEBIAN_FRONTEND=noninteractive apt-get install \
    -yq --no-install-recommends python \
  && rm -f /usr/bin/python \
  && ln -s /usr/bin/python3.7 /usr/bin/python\
  && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Fix environment for other users
RUN echo "export SPARK_HOME=$SPARK_HOME" >> /etc/bash.bashrc \
  && echo 'export PATH=$PATH:$SPARK_HOME/bin'>> /etc/bash.bashrc
