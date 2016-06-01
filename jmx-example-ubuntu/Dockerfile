FROM ubuntu:trusty
RUN apt-get update && apt-get install openjdk-7-jre-headless && rm -rf /var/lib/apt/lists/*
ADD docker-entrypoint.sh TestJMX.jar /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
