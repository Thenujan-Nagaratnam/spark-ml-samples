#!/bin/bash
echo "Starting Lyrics Classification System..."

PID=$(lsof -t -i:9090)
if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Killed process $PID on port 9090"
else
  echo "No process running on port 9090"
fi

cd mllib

# Start the Java backend
./gradlew clean build shadowJar -x test


java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:$(pwd)/application.properties &

sleep 5

# Open the default web browser to the specified URL
xdg-open http://localhost:9090/ 2>/dev/null || \
open http://localhost:9090/ 2>/dev/null || \
start http://localhost:9090/

echo "System started. Opening browser..."