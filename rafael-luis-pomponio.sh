#!/bin/bash

CONTAINER_NAME="rafael-luis-pomponio-calculator"
IMAGE_NAME="rafael-luis-pomponio:latest"
DOCKERFILE="rafael-luis-pomponio.Dockerfile"
PORT=8080

echo "Building Docker image..."
docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

echo "Stopping existing container (if any)..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "Starting new container..."
docker run -d --name "$CONTAINER_NAME" -p "$PORT:$PORT" "$IMAGE_NAME"

if [ $? -eq 0 ]; then
    echo "Container started successfully on port $PORT"
    echo "Test with: curl -X POST http://localhost:$PORT/calcular -H \"Content-Type: application/json\" -d '{\"operador\": \"multiplicacao\", \"op1\": 7, \"op2\": 6}'"
else
    echo "Failed to start container"
    exit 1
fi
