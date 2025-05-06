#!/bin/bash

# Start backend
./gradlew clean build shadowJar -x test
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:application.properties &

# Wait for backend to start
sleep 10

# Start web server to serve frontend
cd web
xdg-open http://localhost:9090/index.html

