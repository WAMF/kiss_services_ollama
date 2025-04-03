# KISS Services Ollama

A cloud run service that runs Ollama

## Building the Service

To build the Docker image for this service, run the following command in the project directory:

```shell
docker build -t ollama-server .
```

## Running Locally

Once the image is built, you can run the service locally using Docker:

```shell
docker run -p 8080:8080 ollama-server
```

The service will be accessible at `http://localhost:8080`. You can test it by sending a GET request:

```shell
curl http://localhost:8080
```

Currently, this will return the service version specified in `pubspec.yaml`.

## Deploy

For best results to have high Memory (32gb) high CPU settings with an L4 GPU attached.

Usage: deploy.sh <REGION> <PROJECT_ID>
