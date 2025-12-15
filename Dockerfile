# -------- Build stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY ./webapp/pom.xml .
COPY ./webapp/src /app/src
RUN mvn clean package
RUN mvn clean package -DskipTests

# -------- Runtime stage --------
FROM tomcat:10.1-jdk17-temurin
WORKDIR /app
# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file to Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/app.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
