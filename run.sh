#!/bin/bash
echo "Starting Lyrics Classification System..."

# Start the Java backend
./gradlew clean build shadowJar -x test &
sleep 5
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:$(pwd)/application.properties &

# Start the frontend
npm run dev &

# Wait a moment for services to start
sleep 10

# Open the browser (works on most Linux and macOS)
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
fi

echo "System started. Opening browser..."