FROM ubuntu:18.04

LABEL maintainer="袁徐磊 <hi@yxl.name>"

USER root

RUN apt-get update -y

# Prerequisites
RUN apt install --fix-missing -q -y openssh-server openssh-client procps

# Add MySQL client to import data from MySQL to HIVE
RUN apt install -y mysql-client

ADD jdk1.8.0_211 /usr/local/jdk1.8.0_211

ENV JAVA_HOME /usr/local/jdk1.8.0_211
ENV PATH $PATH:$JAVA_HOME/bin

# Set as default JVM
RUN update-alternatives --install /usr/bin/java java /usr/local/jdk1.8.0_211/bin/java 100
RUN update-alternatives --install /usr/bin/javac javac /usr/local/jdk1.8.0_211/bin/javac 100

# Passwordless SSH
RUN rm -f /etc/ssh/ssh_host_rsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN chown root:root /root/.ssh/config

RUN echo "Port 2122" >> /etc/ssh/sshd_config

RUN passwd -u root

# Install Hadoop
ENV HADOOP_VER 2.6.0-cdh5.15.0

RUN wget -O hadoop.tar.gz http://archive.cloudera.com/cdh5/cdh/5/hadoop-$HADOOP_VER.tar.gz && \
	tar -xzf hadoop.tar.gz -C /usr/local/ && rm hadoop.tar.gz

RUN ln -s /usr/local/hadoop-$HADOOP_VER /usr/local/hadoop

ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

ENV HADOOP_PREFIX $HADOOP_HOME

# Default Conf Files
ADD config/* $HADOOP_HOME/etc/hadoop/

RUN sed -i "/^export JAVA_HOME/ s:.*:export JAVA_HOME=${JAVA_HOME}\nexport HADOOP_HOME=${HADOOP_HOME}\nexport HADOOP_PREFIX=${HADOOP_PREFIX}:" ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

WORKDIR $HADOOP_HOME

ADD bootstrap.sh /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh"]
