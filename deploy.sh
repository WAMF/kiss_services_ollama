#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <REGION> <PROJECT_ID>"
    exit 1
fi

REGION=$1
PROJECT_ID=$2

gcloud beta run deploy ollama-server \
  --source=. \
  --region="$REGION" \
  --platform managed \
  --allow-unauthenticated \
  --project="$PROJECT_ID" \
  --timeout=600
