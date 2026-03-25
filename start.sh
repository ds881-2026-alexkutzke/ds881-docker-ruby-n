#!/bin/bash

docker build -t calculadora-api -f luizbussolo.dockerfile .
docker run -d -p 8080:8080 --name calculadora-container calculadora-api
