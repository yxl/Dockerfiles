# Based on Hadoop image
FROM yuanxulei/hive-cluster:2.3.4-hadoop-2.7.4

USER root

ENV MYSQL_DRIVER_VERSION=5.1.47

ENV SQOOP_VERSION=1.4.7

RUN apk --no-cache add openjdk8

# Download Apche Hive
RUN wget -O sqoop.tar.gz https://mirrors.tuna.tsinghua.edu.cn/apache/sqoop/$SQOOP_VERSION/sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0.tar.gz && \
tar -xzf sqoop.tar.gz -C /usr/local/ && rm sqoop.tar.gz

ENV SQOOP_HOME /usr/local/sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0

ADD conf/ $SQOOP_HOME

# Fix "Could not load org.apache.hadoop.hive.conf.HiveConf" error
RUN cp $HIVE_HOME/lib/hive-common-*.jar  $SQOOP_HOME/lib

# Fix "java.lang.NoClassDefFoundError: org/json/JSONObject" error when creating job
RUN wget -O $SQOOP_HOME/lib/json-20180813.jar http://central.maven.org/maven2/org/json/json/20180813/json-20180813.jar

# Create a soft link to make futher upgrade transparent
RUN ln -s $SQOOP_HOME /usr/local/sqoop

# Add mysql driver and default config file
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"
RUN mkdir -p $SQOOP_HOME/lib/ && tar -xzf "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" --strip-components=1 --no-same-owner -C $SQOOP_HOME/lib/ "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar"

# Set environment
ENV PATH $PATH:$SQOOP_HOME/bin

WORKDIR $SQOOP_HOME

CMD ["/etc/bootstrap.sh"]
