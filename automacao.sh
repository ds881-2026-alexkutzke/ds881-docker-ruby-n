#!/bin/bash
docker build -t matheus-calc-api -f matheuskruger.Dockerfile .
docker run -d -p 8080:8080 --name calc-api-container matheus-calc-api