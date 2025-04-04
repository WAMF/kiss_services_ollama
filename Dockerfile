
FROM ollama/ollama:latest

ARG MODELS="gemma3:1b gemma3:4b gemma3:12b"
ENV OLLAMA_MODELS=/data/ollama-models

ENV OLLAMA_KEEP_ALIVE=-1
ENV OLLAMA_HOST=0.0.0.0:8080

RUN sh -c 'ollama serve & sleep 5 && for model in $MODELS; do ollama pull $model; done && pkill ollama'

# Start server.
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "ollama serve"]
