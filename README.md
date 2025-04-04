# KISS Services Ollama

A Google Cloud Run service that runs Ollama.

This setup allows you to provision the necessary Artifact Registry, build the Ollama server Docker image using Google Cloud Build, and deploy it to Cloud Run with GPU acceleration.

## Prerequisites

*   [Google Cloud SDK (gcloud)](https://cloud.google.com/sdk/docs/install) installed and authenticated.
*   A Google Cloud Project with billing enabled and the necessary APIs enabled (Cloud Build, Artifact Registry, Cloud Run).
*   Docker (optional, for local testing).

## 1. Provision Artifact Registry

First, create a Docker repository in Google Artifact Registry to store your built image. Run the provisioning script, replacing `<YOUR_PROJECT_ID>` and `<YOUR_REPOSITORY_NAME>` with your values:

```shell
./kiss_services_ollama/provision.sh <YOUR_PROJECT_ID> <YOUR_REPOSITORY_NAME>
```

## 2. Building the Service

The `Dockerfile` is configured to pull the following models by default during the build process: `gemma3:1b`, `gemma3:4b`, `gemma3:12b`.

To build the Docker image using Google Cloud Build and push it to the Artifact Registry repository you created, run the build script:

```shell
./kiss_services_ollama/build.sh <YOUR_PROJECT_ID> <YOUR_REPOSITORY_NAME>
```

This uses a high-CPU machine type (`e2-highcpu-32`) for potentially faster builds, especially during the model download phase.

## 3. Running Locally (Optional)

If you wish to build and run the service locally (e.g., for quick testing without involving Cloud Build), you can use standard Docker commands. Note that this local build will also pull the default models specified in the `Dockerfile`.

Build the image:
```shell
docker build -t ollama-server ./kiss_services_ollama
```

Run the container:
```shell
docker run -p 8080:8080 --rm ollama-server
```

The service will be accessible at `http://localhost:8080`.

## 4. Deploy to Cloud Run

Deploy the built image from Artifact Registry to Google Cloud Run. The `deploy.sh` script configures the service with recommended settings for Ollama, including 32Gi RAM, 8 vCPUs, and an NVIDIA L4 GPU.

Run the deployment script:

```shell
./kiss_services_ollama/deploy.sh <YOUR_PROJECT_ID> <YOUR_REPOSITORY_NAME>
```

The script sets the region to `europe-west4` and allows unauthenticated access. Adjust the script if you need different settings.

## Testing the Deployed Service

Once deployed, find the service URL provided by Cloud Run (or using `gcloud run services describe ollama-server --platform managed --region europe-west4 --format='value(status.url)'`).

You can test it by sending a request, for example:

```shell
curl YOUR_CLOUD_RUN_SERVICE_URL/api/generate -d '{
  "model": "gemma3:4b", 
  "prompt":"Why is the sky blue?"                               
}'
```

(Replace `YOUR_CLOUD_RUN_SERVICE_URL` with the actual URL).

## Ollama API

Refer to the official Ollama API documentation for more details on available endpoints and parameters:
`https://github.com/ollama/ollama/blob/main/docs/api.md`
