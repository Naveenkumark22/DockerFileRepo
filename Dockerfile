# Stage 1: Build the Spring Boot application
FROM maven:3.8.3-openjdk-11-slim AS build
WORKDIR /app
COPY ./pom.xml ./pom.xml
RUN mvn dependency:go-offline
COPY ./src ./src
RUN mvn package

# Stage 2: Create a lightweight image to run the Spring Boot application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/Docker-IntegrationJar.jar /app/Docker-IntegrationJar.jar
EXPOSE 8080
CMD ["java", "-jar", "Docker-IntegrationJar.jar"]

