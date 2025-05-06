@echo off

:: Start backend
call gradlew clean build shadowJar -x test
start java -jar api\build\libs\api-1.0-SNAPSHOT.jar --spring.config.location=file:/home/thenu/spark-ml-sample/application.properties

:: Wait for backend to start
timeout /t 10

:: Start web server
cd frontend
start http://localhost:9090/index.html
