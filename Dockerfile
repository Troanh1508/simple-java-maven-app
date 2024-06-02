FROM openjdk:23-slim
EXPOSE 8081
ADD target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/my-app-1.0-SNAPSHOT.jar"]
