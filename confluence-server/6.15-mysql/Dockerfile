FROM atlassian/confluence-server:6.15-alpine-adoptopenjdk8

ENV MYSQL_DRIVER_VERSION=5.1.47

# Add mysql driver
RUN wget "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" && \
    tar -xzf "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz" --strip-components=1 --no-same-owner -C "/opt/atlassian/confluence/confluence/WEB-INF/lib" "mysql-connector-java-${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar" && \
    rm -f "mysql-connector-java-${MYSQL_DRIVER_VERSION}.tar.gz"
