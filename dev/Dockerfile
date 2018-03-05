FROM openjdk:8-jre

MAINTAINER maintainer

# Install maven in /opt and add it to path
ARG MAVEN_VERSION=3.5.2
ENV MVN_VERSION=${MAVEN_VERSION}

ARG user=test
ARG group=test
ARG uid=1000
ARG gid=1000



ENV TEST_HOME /home/test
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$TEST_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

RUN mkdir ${TEST_HOME}/.m2

RUN chown -R ${user}:${group} ${TEST_HOME}/.m2

WORKDIR /opt

RUN wget http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && tar -xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && apt-get update \
    && apt-get install  -y software-properties-common \
    && apt-add-repository -y  ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./scripts/init.sh /opt/init.sh
COPY settings.xml /opt/apache-maven-${MAVEN_VERSION}/conf/settings.xml

RUN chmod +x /opt/init.sh \
    && ln -s /opt/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn

ENTRYPOINT ["/opt/init.sh"]

CMD ["mvn", "--version"]
