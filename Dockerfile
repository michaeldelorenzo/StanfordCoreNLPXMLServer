FROM ubuntu:14.10
MAINTAINER Michael De Lorenzo "michael@delorenzodesign.com"

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y --no-install-recommends oracle-java8-installer

RUN apt-get install -y ant

RUN mkdir /src
WORKDIR /src

COPY ./ /src

RUN ant libs
RUN ant jar

CMD ant run -Dport=19350
