FROM maven:3.8.1-ibmjava-8 AS build 
RUN mkdir -p test/
WORKDIR test/
COPY pom.xml .
COPY src src
RUN mvn package 

FROM tomcat:alpine as stage
RUN sed -i 's/port="8080"/port="11130"/' $CATALINA_HOME/conf/server.xml
WORKDIR /usr/local/tomcat
COPY --from=build test/target/* ./webapps/
#EXPOSE 8080
EXPOSE 11130
CMD ["catalina.sh", "run"]
