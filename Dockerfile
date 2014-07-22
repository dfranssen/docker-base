FROM ubuntu:trusty
MAINTAINER Dirk Franssen "dirk.franssen@gmail.com"

RUN apt-get update
RUN apt-get -y install wget man java-common

# Installs JDK 8 (8u11-b12 to be exact :-))
# I personally prefer not to depend on a ppa package to install 'a version' of jdk1.8
RUN wget --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u11-b12/jdk-8u11-linux-x64.tar.gz -O /tmp/jdk-8u11-linux-x64.tar.gz
RUN if [ ! -d '/usr/lib/jvm' ]; then mkdir /usr/lib/jvm; fi
RUN tar -zxf /tmp/jdk-8u11-linux-x64.tar.gz -C /usr/lib/jvm && rm /tmp/jdk-8u11-linux-x64.tar.gz

ENV JAVA_ALIAS jdk1.8.0_11
ENV JVM_ROOT_PATH /usr/lib/jvm
ENV JAVA_HOME $JVM_ROOT_PATH/$JAVA_ALIAS

# In most of the cases having the $JAVA_HOME/bin in the PATH would have been sufficient though
# ENV PATH $JAVA_HOME/bin:$PATH

# But doing it the alternative way :-)
# STEP 1 - get the dependencies to configure this
ADD https://github.com/dfranssen/docker-base/blob/master/scripts/.$JAVA_ALIAS.jinfo $JVM_ROOT_PATH/.$JAVA_ALIAS.jinfo
ADD https://github.com/dfranssen/docker-base/blob/master/scripts/update-alternative-$JAVA_ALIAS.sh $JVM_ROOT_PATH/update-alternative-$JAVA_ALIAS.sh
# STEP 2 - update and set alternatives via script (and remove script afterxwards)
RUN chown -R root:root $JVM_ROOT_PATH && \
    chmod 655 $JVM_ROOT_PATH/update-alternative-$JAVA_ALIAS.sh && \
    .$JVM_ROOT_PATH/update-alternative-$JAVA_ALIAS.sh && \
    rm $JVM_ROOT_PATH/update-alternative-$JAVA_ALIAS.sh
