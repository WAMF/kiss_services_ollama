PROJECT_ID=$1
REPOSITORY=$2

if [ -z "$PROJECT_ID" ] || [ -z "$REPOSITORY" ]; then
    echo "Usage: $0 <PROJECT_ID> <REPOSITORY>"
    exit 1
fi

gcloud artifacts repositories create $REPOSITORY \
  --repository-format=docker \
  --location=europe-west4 \
  --project=$PROJECT_ID
