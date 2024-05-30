FROM openjdk:17
COPY src /app/
WORKDIR /app
EXPOSE 8081
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
