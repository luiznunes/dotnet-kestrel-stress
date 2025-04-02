#!/bin/bash

docker build . -t dotnet-kestrel

echo "Execução: docker run --rm --memory=1gb --name=Dotnet-Kestrel --cpuset-cpus=0 dotnet-kestrel"