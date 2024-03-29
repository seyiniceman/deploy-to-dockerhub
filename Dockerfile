FROM tomcat
WORKDIR /
COPY . /
RUN mvn clean package
COPY ./target/hello-world.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
EXPOSE 8080

