PROJECT_ID=$1
REPOSITORY=$2

if [ -z "$PROJECT_ID" ] || [ -z "$REPOSITORY" ]; then
    echo "Usage: $0 <PROJECT_ID> <REPOSITORY>"
    exit 1
fi

gcloud builds submit \
   --tag europe-west4-docker.pkg.dev/$PROJECT_ID/$REPOSITORY/ollama-server \
   --machine-type e2-highcpu-32
