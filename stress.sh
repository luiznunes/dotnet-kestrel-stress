#!/bin/bash

docker exec -t Dotnet-Kestrel curl http://localhost/api/stress & docker exec -t Dotnet-Kestrel curl http://localhost/api/stress & docker exec -t Dotnet-Kestrel curl http://localhost/api/stress