
FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

# Define build argument for models to preload
ARG MODELS="gemma3:4b gemma3:27b"
ENV OLLAMA_MODELS=/data/ollama-models

# install ollama
RUN apt-get update && apt-get install -y curl procps && \
    curl -fsSL https://ollama.com/install.sh | sh && \
    rm -rf /var/lib/apt/lists/*

# Download and cache models during build using the build argument
RUN sh -c 'ollama serve & sleep 5 && for model in $MODELS; do ollama pull $model; done && pkill ollama'

# Set the working directory

# Keep Ollama models loaded
ENV OLLAMA_KEEP_ALIVE=-1

# Set Ollama host and port
ENV OLLAMA_HOST=0.0.0.0:8080
ENV OLLAMA_MODELS=/data/ollama-models

# Start server.
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "ollama serve"]
