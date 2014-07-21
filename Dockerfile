FROM ubuntu:14.04
MAINTAINER Dirk Franssen "dirk.franssen@gmail.com"

RUN apt-get update && apt-get clean

# Installs JDK 8
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/8u11-b12/jre-8u11-linux-x64.rpm" -O /opt/jre-8u11-linux-x64.rpm
RUN rpm -Uvh /opt/jre-8u11-linux-x64.rpm && rm /opt/jre-8u11-linux-x64.rpm
