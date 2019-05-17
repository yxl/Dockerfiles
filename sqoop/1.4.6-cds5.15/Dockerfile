# Based on Hadoop image
FROM yuanxulei/hive:1.1.0-cdh5.15.0

USER root

ENV MYSQL_DRIVER_VERSION=5.1.47

ENV SQOOP_VERSION=1.4.6-cdh5.15.0

RUN apk --no-cache add openjdk8

# Add MySQL client to import data from MySQL to HIVE
# Fix 'cannot find mysqldump'
RUN apk add mysql-client

# Download sqoop
RUN wget -O sqoop.tar.gz http://archive.cloudera.com/cdh5/cdh/5/sqoop-$SQOOP_VERSION.tar.gz && \
  tar -xzf sqoop.tar.gz -C /usr/local/ && rm -f sqoop.tar.gz

ENV SQOOP_HOME /usr/local/sqoop-$SQOOP_VERSION

ADD conf/ $SQOOP_HOME/conf

# Fix "java.lang.NoClassDefFoundError: org/json/JSONObject" error when creating job
RUN wget -O $SQOOP_HOME/lib/json-20180813.jar http://central.maven.org/maven2/org/json/json/20180813/json-20180813.jar

# Add 'permission javax.management.MBeanTrustPermission "register";' to java.policy
# Fix "ERROR Could not register mbeans java.security.AccessControlException: access denied ("javax.management.MBeanTrustPermission" "register")"
ADD java.policy $JAVA_HOME/jre/lib/security/java.policy

# Create a soft link to make futher upgrade transparent
RUN ln -s $SQOOP_HOME /usr/local/sqoop

# Add mysql driver and default config file
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"
RUN tar -xzf "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" --strip-components=1 --no-same-owner -C $SQOOP_HOME/lib/ "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar" && rm -f "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"

# Set environment
ENV PATH $PATH:$SQOOP_HOME/bin

WORKDIR $SQOOP_HOME

CMD ["/etc/bootstrap.sh"]
