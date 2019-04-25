# Based on Hadoop image
FROM newnius/hadoop:2.7.4

USER root

ENV MYSQL_DRIVER_VERSION=5.1.47

ENV SQOOP_VERSION=1.99.7

# Download Apche Hive
RUN wget -O sqoop.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/sqoop/$SQOOP_VERSION/sqoop-$SQOOP_VERSION-bin-hadoop200.tar.gz && \
tar -xzf sqoop.tar.gz -C /usr/local/ && rm sqoop.tar.gz

ENV SQOOP_HOME /usr/local/sqoop-$SQOOP_VERSION-bin-hadoop200

RUN sed -i 's#^org.apache.sqoop.submission.engine.mapreduce.configuration.directory=.*$#org.apache.sqoop.submission.engine.mapreduce.configuration.directory=/usr/local/hadoop/etc/hadoop/#' $SQOOP_HOME/conf/sqoop.properties

# Create a soft link to make futher upgrade transparent
RUN ln -s $SQOOP_HOME /usr/local/sqoop

# Add mysql driver and default config file
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"
RUN mkdir -p $SQOOP_HOME/lib/ && tar -xzf "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" --strip-components=1 --no-same-owner -C $SQOOP_HOME/lib/ "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar"

# Set environment
ENV PATH $PATH:$SQOOP_HOME/bin
ENV HADOOP_COMMON_HOME ${HADOOP_HOME}/share/hadoop/common
ENV HADOOP_HDFS_HOME ${HADOOP_HOME}/share/hadoop/hdfs
ENV HADOOP_MAPRED_HOME ${HADOOP_HOME}/share/hadoop/mapreduce
ENV HADOOP_YARN_HOME ${HADOOP_HOME}/share/hadoop/yarn
ENV SQOOP_SERVER_EXTRA_LIB $SQOOP_HOME/lib

ADD bootstrap.sh /etc/bootstrap.sh

WORKDIR $SQOOP_HOME

CMD ["/etc/bootstrap.sh", "-d"]
