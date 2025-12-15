# -------- Build stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy everything (parent + all modules)
COPY . .

# Build only webapp, but include required modules
RUN mvn clean package -pl webapp -am -DskipTests

# -------- Runtime stage --------
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR
COPY --from=build /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 80
CMD ["catalina.sh", "run"]
