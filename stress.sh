#!/bin/bash

docker exec -it Dotnet-Kestrel curl http://localhost/api/stress & docker exec -it Dotnet-Kestrel curl http://localhost/api/stress & docker exec -it Dotnet-Kestrel curl http://localhost/api/stress