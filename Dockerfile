# -------- Build stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy parent POM first
COPY pom.xml .

# Copy module POMs
COPY webapp/pom.xml webapp/pom.xml

# Download dependencies (better caching)
RUN mvn dependency:go-offline -B

# Copy full source
COPY . .

# Build only the webapp module
RUN mvn clean package -pl webapp -am -DskipTests

# -------- Runtime stage --------
FROM tomcat:10.1-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR to Tomcat
COPY --from=build /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

