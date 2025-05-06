#!/bin/bash
echo "Starting Lyrics Classification System..."

PID=$(lsof -t -i:9090)
if [ -n "$PID" ]; then
  kill -9 $PID
  echo "Killed process $PID on port 9090"
else
  echo "No process running on port 9090"
fi

# Start the Java backend
./gradlew clean build shadowJar -x test
sleep 5
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:$(pwd)/application.properties &

# Wait a moment for services to start
sleep 10

sh web/start.sh

echo "System started. Opening browser..."