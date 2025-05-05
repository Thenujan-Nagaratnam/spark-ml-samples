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
java -jar api/build/libs/api-1.0-SNAPSHOT.jar --spring.config.location=file:/home/thenu/spark-ml-sample/application.properties
```
