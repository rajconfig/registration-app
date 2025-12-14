FROM maven:latest
WORKDIR /app
COPY . .
RUN maven clean package
FROM openjdk:latest
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
ENTRYPOINT 80
CMD app.jar 


