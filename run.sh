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
# ./gradlew clean build shadowJar -x test
sleep 5
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:$(pwd)/application.properties &

# Wait a moment for services to start
sleep 5

# Exit if any command fails
set -e

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
. venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install flask requests

# Run the application
python3 app.py

echo "System started. Opening browser..."