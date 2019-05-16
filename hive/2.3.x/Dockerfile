# Based on Hadoop image
FROM yuanxulei/hadoop:2.7.4

USER root

ENV MYSQL_DRIVER_VERSION=5.1.47

ENV HIVE_VERSION=2.3.5

# Download Apche Hive
RUN wget -O apache-hive.tar.gz http://ftp.kddilabs.jp/infosystems/apache/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
tar -xzf apache-hive.tar.gz -C /usr/local/ && rm apache-hive.tar.gz

# Create a soft link to make futher upgrade transparent
RUN ln -s /usr/local/apache-hive-$HIVE_VERSION-bin /usr/local/hive

# Set environment of hive
ENV HIVE_HOME /usr/local/apache-hive-$HIVE_VERSION-bin
ENV PATH $PATH:$HIVE_HOME/bin

# Add mysql driver and default config file
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"
RUN tar -xzf "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" --strip-components=1 --no-same-owner -C $HIVE_HOME/lib/ "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar"
ADD hive-site.xml $HIVE_HOME/conf

# Rename bootstrap script in origin image
RUN mv /etc/bootstrap.sh /etc/start_hadoop.sh

ADD bootstrap.sh /etc/bootstrap.sh
ADD init_hive.sh /etc/init_hive.sh

WORKDIR $HIVE_HOME

CMD ["/etc/bootstrap.sh"]
