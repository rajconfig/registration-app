# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml ./
COPY webapp/pom.xml ./webapp/
COPY server/pom.xml ./server/
COPY core/pom.xml ./core/
RUN mvn dependency:go-offline -B

COPY webapp/src ./webapp/src
COPY server/src ./server/src
COPY core/src ./core/src
RUN mvn clean package -pl webapp -am -DskipTests

# Runtime stage (Tomcat)
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf *
COPY --from=build /app/webapp/target/webapp.war ROOT.war
EXPOSE 80
CMD ["catalina.sh", "run"]
