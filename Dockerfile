# Stage 1: Build the Jenkins plugin using Maven and JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the Jenkins plugin (HPI)
RUN mvn clean install -DskipTests

# Stage 2: Create minimal runtime image (optional for Jenkins plugin, used when deploying plugin to Jenkins)
FROM jenkins/inbound-agent:latest

# Copy built HPI plugin from the builder stage
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# This container is intended to be used in Jenkins setup, so no CMD needed
