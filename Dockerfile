FROM ubuntu AS build

WORKDIR /app

RUN apt-get update && apt-get install maven -y

COPY . .
RUN mvn clean package 

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]

