# KISS Services Ollama

A simple Dart service designed to expose functionality from Ollama models.

## Building the Service

To build the Docker image for this service, run the following command in the project directory:

```shell
docker build -t kiss-services-ollama .
```

## Running Locally

Once the image is built, you can run the service locally using Docker:

```shell
docker run -p 8080:8080 kiss-services-ollama
```

The service will be accessible at `http://localhost:8080`. You can test it by sending a GET request:

```shell
curl http://localhost:8080
```

Currently, this will return the service version specified in `pubspec.yaml`.

## Deploy

For best results to have high Memory (32gb) high CPU settings with an L4 GPU attached.

Usage: deploy.sh <REGION> <PROJECT_ID>
