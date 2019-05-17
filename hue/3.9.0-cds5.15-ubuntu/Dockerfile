# Based on Hadoop image
FROM yuanxulei/sqoop:1.4.6-cdh5.15.0-ubuntu

USER root

ENV MYSQL_DRIVER_VERSION=5.1.47

ENV HUE_VERSION=3.9.0-cdh5.15.0

RUN apt-get update -y
RUN apt-get install --fix-missing -q -y \
  git \
  ant \
  gcc \
  g++ \
  libkrb5-dev \
  libmysqlclient-dev \
  libssl1.0-dev \
  libsasl2-dev \
  libsasl2-modules-gssapi-mit \
  libsqlite3-dev \
  libtidy-dev \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  make \
  maven \
  libldap2-dev \
  python-dev \
  python-setuptools \
  libgmp3-dev \
  libz-dev

# Download hue
RUN wget -O hue.tar.gz http://archive.cloudera.com/cdh5/cdh/5/hue-$HUE_VERSION.tar.gz && \
  tar -xzf hue.tar.gz -C /usr/local/ && rm -f hue.tar.gz

WORKDIR /usr/local/hue-$HUE_VERSION

RUN PREFIX=/usr/local make install
RUN useradd -ms /bin/bash hue && chown -R hue /usr/local/hue

ENV HUE_HOME /usr/local/hue

# Set environment
ENV PATH $PATH:$HUE_HOME/build/env/bin/

WORKDIR $HUE_HOME
RUN rm -rf /usr/local/hue-$HUE_VERSION
ADD startup.sh .
ADD hue.ini $HUE_HOME/desktop/conf/

EXPOSE 8888
VOLUME $HUE_HOME/desktop/
CMD ["./startup.sh"]
