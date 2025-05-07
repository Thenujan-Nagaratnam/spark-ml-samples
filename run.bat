@echo off
echo Starting Lyrics Classification System...

REM Kill any process using port 9090
FOR /F "tokens=5" %%A IN ('netstat -aon ^| findstr :9090') DO (
    taskkill /PID %%A /F >nul 2>&1
    echo Killed process %%A on port 9090
    goto :continue
)
echo No process running on port 9090

:continue

cd mllib

REM Build the Java backend
call gradlew clean build shadowJar -x test

REM Start the Java server
start /B java -jar api\build\libs\api-1.0-SNAPSHOT.jar --spring.config.location=file:%cd%\application.properties

REM Wait a bit for the build to complete
timeout /t 5 /nobreak >nul

REM Open the default web browser to the server URL
start http://localhost:9090/

echo System started. Opening browser...
