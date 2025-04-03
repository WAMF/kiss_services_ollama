.PHONY: clean docker-build docker-run test-curl

FUNCTION_TARGET = function
PORT = 8080
IMAGE_NAME ?= kiss_services_ollama
IMAGE_TAG ?= latest
CONTAINER_NAME = kiss-ollama-service
OLLAMA_MODELS_ARG ?= "gemma3:1b" # Default model to build with

# Target to stop and remove the ollama container and image
clean:
	@docker stop $(CONTAINER_NAME) || true
	@docker rm $(CONTAINER_NAME) || true
	@docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true


# Add a target to test the endpoint with curl
# Run 'make run' in one terminal, then 'make test-curl' in another.
test-curl:
	curl http://localhost:$(PORT)/

# Docker targets
docker-build:
	docker build --no-cache --build-arg OLLAMA_MODELS=$(OLLAMA_MODELS_ARG) -t $(IMAGE_NAME):$(IMAGE_TAG) .

docker-run:
	docker run -p $(PORT):$(PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_TAG)
