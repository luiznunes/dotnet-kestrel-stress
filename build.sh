#!/bin/bash

docker build --no-cache . -t dotnet-kestrel

echo "Execução: docker run --rm --memory=1gb --name=Dotnet-Kestrel --cpuset-cpus=0 dotnet-kestrel"