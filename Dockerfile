FROM maven:3.3.9-jdk-8-alpine as build
WORKDIR /
COPY . /
RUN mvn clean package

FROM tomcat as base
WORKDIR /
COPY --from=build /target/hello-world.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
EXPOSE 8080

