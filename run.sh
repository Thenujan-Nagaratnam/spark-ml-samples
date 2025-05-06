#!/bin/bash
echo "Starting Lyrics Classification System..."

# Start the Java backend
./gradlew clean build shadowJar -x test &
sleep 5
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:$(pwd)/application.properties &

# Wait a moment for services to start
sleep 10

# Open the browser with the HTML file directly
if command -v xdg-open &> /dev/null; then
    xdg-open "$(pwd)/index.html"
elif command -v open &> /dev/null; then
    open "$(pwd)/index.html"
fi

echo "System started. Opening browser..."