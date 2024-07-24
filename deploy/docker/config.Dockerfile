# Stage 1: Build the application
FROM gradle:jdk21 AS build

# Set the working directory
WORKDIR /

# Copy the Gradle wrapper and configuration files
COPY gradle.properties gradle.properties
COPY config/build.gradle config/build.gradle
COPY settings.gradle settings.gradle

# Copy the application source code
COPY config/src /config/src

# Build the application
RUN gradle config:build

# Stage 2: Run the application
FROM eclipse-temurin:21-jre

# Set the working directory
WORKDIR /

# Copy the built jar from the previous stage
COPY --from=build /config/build/libs/*.jar /app/app.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
