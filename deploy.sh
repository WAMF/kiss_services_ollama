#!/bin/bash

PROJECT_ID=$1
REPOSITORY=$2

if [ -z "$PROJECT_ID" ] || [ -z "$REPOSITORY" ]; then
    echo "Usage: $0 <PROJECT_ID> <REPOSITORY>"
    exit 1
fi

gcloud beta run deploy ollama-server \
  --image europe-west4-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/ollama-server \
  --concurrency 4 \
  --cpu 8 \
  --set-env-vars OLLAMA_NUM_PARALLEL=4 \
  --gpu 1 \
  --gpu-type nvidia-l4 \
  --max-instances 1 \
  --memory 32Gi \
  --no-cpu-throttling \
  --allow-unauthenticated \
  --region europe-west4 \
  --timeout=600
