FROM BASE_IMAGE

MAINTAINER name

RUN mkdir /app
WORKDIR /app

# Copy your artifacts to /app 
# Example : 
# ADD ../../myapp/target/*.jar a()jar

EXPOSE SOME_PORT

COPY scripts/start.sh /app/start.sh
RUN chmod +x start.sh


