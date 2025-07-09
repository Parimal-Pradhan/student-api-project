FROM openjdk:17-jdk-slim
COPY target/student-api-0.0.1-SNAPSHOT.jar student-api.jar
ENTRYPOINT ["java", "-jar", "student-api.jar"]