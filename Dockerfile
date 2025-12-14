# -------- Build stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -------- Runtime stage --------
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY target/*.war app.war
EXPOSE 80
CMD ["java", "-jar", "app.war"]
