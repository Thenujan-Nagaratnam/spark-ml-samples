# Sample Application for "Introduction to ML with Apache Spark MLlib" Presentation

### Lyrics Classifier
Recognize genre.

## Build, Configure and Run

### Build
Standard build:
```
./gradlew clean build shadowJar
```
Quick build without tests:
```
./gradlew clean build shadowJar -x test
```

### Run

```
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:application.properties
```


### Train and Infer the model

```
curl -X GET http://localhost:9090/lyrics/train

curl -X POST http://localhost:9090/lyrics/predict  -H "Content-Type: application/json"  -d '{"unknownLyrics": "Your lyrics go here"}'

```