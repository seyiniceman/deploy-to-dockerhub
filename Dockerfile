FROM maven:3.8.4-openjdk-14 AS Build
WORKDIR /
COPY . /
RUN mvn clean package

FROM tomcat AS Base
WORKDIR /
COPY --from=Build /target/hello-world.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
EXPOSE 8080

