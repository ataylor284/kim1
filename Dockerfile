FROM ubuntu:20.04

RUN apt-get update
RUN apt-get -y install cc65
RUN apt-get -y install srecord
RUN apt-get -y install make

CMD "make"
