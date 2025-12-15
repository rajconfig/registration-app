# Build stage
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml ./
COPY server/pom.xml ./server/
COPY core/pom.xml ./core/
RUN mvn dependency:go-offline -B

COPY server/src ./server/src
COPY core/src ./core/src
RUN mvn clean package -pl server -am -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/server/target/server.jar server.jar
EXPOSE 8080
CMD ["java", "-jar", "server.jar"]
