# -------- Build stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy entire repository
COPY . .

# Build only server module + its dependencies
RUN mvn clean package -pl server -am -DskipTests

# -------- Runtime stage --------
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/server/target/*.jar server.jar

EXPOSE 8080
CMD ["java", "-jar", "server.jar"]
