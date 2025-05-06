@echo off
echo Starting Lyrics Classification System...

start cmd /c "cd /d %~dp0 && ./gradlew clean build shadowJar -x test && java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:%~dp0application.properties"

timeout /t 10
start http://localhost:3000
echo System started. Opening browser...