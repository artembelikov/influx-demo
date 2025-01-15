# Этап сборки
FROM gradle:7.6-jdk17 AS build
WORKDIR /home/app
COPY . .
# Собираем проект и пропускаем тесты, чтобы ускорить сборку (при необходимости можно запустить тесты)
RUN gradle clean build -x test

# Этап исполнения
FROM openjdk:17-jdk-slim
WORKDIR /app

# Копируем скомпилированный JAR из предыдущего этапа
COPY --from=build /home/app/build/libs/*.jar app.jar

# Указываем порт, который будет использовано приложением
EXPOSE 9090

# Запуск приложения
ENTRYPOINT ["java","-jar","app.jar"]