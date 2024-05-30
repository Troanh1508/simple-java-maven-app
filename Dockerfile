FROM openjdk:23-slim
COPY src /app/
WORKDIR /app
EXPOSE 8081
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
