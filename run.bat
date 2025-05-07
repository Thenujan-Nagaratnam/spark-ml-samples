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

@REM REM Build the Java backend
@REM call gradlew clean build shadowJar -x test

@REM REM Wait a bit for the build to complete
@REM timeout /t 5 /nobreak >nul

REM Start the Java server
start /B java -jar api\build\libs\api-1.0-SNAPSHOT.jar --spring.config.location=file:%cd%\application.properties

@REM REM Wait for services to start
@REM timeout /t 5 /nobreak >nul

REM Exit if any command fails (simulate 'set -e')
setlocal EnableExtensions EnableDelayedExpansion
set "error=0"

REM Create virtual environment
python -m venv venv || set error=1

if !error! NEQ 0 (
    echo Failed to create virtual environment. Exiting...
    exit /b 1
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Upgrade pip
python -m pip install --upgrade pip

REM Install dependencies
pip install flask requests

REM Run the application
python app.py

echo System started. Opening browser...
