# Stage 1: Build the application
FROM gradle:jdk21 AS build

# Set the working directory
WORKDIR /

# Copy the Gradle wrapper and configuration files
COPY gradle.properties gradle.properties
COPY eureka/build.gradle eureka/build.gradle
COPY settings.gradle settings.gradle

# Copy the application source code
COPY eureka/src /eureka/src

# Build the application
RUN gradle eureka:build

# Stage 2: Run the application
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /

# Copy the built jar from the previous stage
COPY --from=build /eureka/build/libs/*.jar /app/app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", "/app/app.jar"]
