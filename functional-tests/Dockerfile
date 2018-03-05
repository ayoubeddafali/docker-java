FROM BASE_IMAGE

MAINTAINER maintainer

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN chown -R 1000:1000 /app

USER test


CMD ["mvn", "test"]
