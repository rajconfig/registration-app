FROM maven:3.9.6-eclipse-temurin-17
WORKDIR /app
COPY . .
RUN maven clean package
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
ENTRYPOINT 80
CMD app.jar 


