#!/usr/bin/env bash

set -euo pipefail

IMAGE_NAME="calculadora-api"
CONTAINER_NAME="calculadora-container"
PORT="8080"

echo "Removendo container antigo (caso exista)..."
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "Buildando a imagem Docker..."
docker build -t $IMAGE_NAME -f anna.dockerfile .

echo "Executando o container..."
docker run -d -p $PORT:8080 --name $CONTAINER_NAME $IMAGE_NAME

echo "Aplicação disponível em http://localhost:$PORT"