# Build stage
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

# Copy Maven files
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Give execute permission to mvnw
RUN chmod +x mvnw

# Download dependencies
RUN ./mvnw dependency:go-offline

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the JAR from build stage
# Note: Ensure the filename matches your actual pom.xml artifactId/version
COPY --from=build /app/target/salary-api-0.0.1-SNAPSHOT.jar app.jar

# Expose port (Matches your existing EXPOSE)
EXPOSE 8081

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]
