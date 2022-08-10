FROM maven:3.8.1-ibmjava-8 AS build 
RUN mkdir -p test/
WORKDIR test/
COPY pom.xml .
COPY src src
RUN mvn package 

FROM tomcat as stage
WORKDIR /usr/local/tomcat
COPY --from=build test/target/* ./webapps/
EXPOSE 8080
