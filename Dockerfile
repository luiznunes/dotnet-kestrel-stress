FROM mcr.microsoft.com/dotnet/core/aspnet:2.1.28-alpine3.12 AS base

# Ferramentas de monitoriamento
# RUN apt-get update && apt-get install -y nano iputils-ping tcpdump traceroute telnet
RUN apk add nano tcpdump

# Ferramentas de imagem -- Install System.Drawing native dependencies
# RUN apt-get install -y --allow-unauthenticated \
#         libc6-dev \
#         libgdiplus \
#         libx11-dev
RUN apk add libc6-compat libx11-dev

# FROM grupovoalle/erp-container-base:2.1.30 AS base
WORKDIR /app
EXPOSE 45701/tcp

#SDK donet core 2.1
FROM mcr.microsoft.com/dotnet/sdk:2.1.818-alpine3.13 AS build

#Cria a pasta que irá conter os fontes a serem compilados
WORKDIR /source

COPY Kestrel/*.csproj ./src/Kestrel/
RUN dotnet restore ./src/Kestrel/Kestrel.csproj
COPY Kestrel/. ./src/Kestrel/

#Executa o publish da aplicação
FROM build AS publish
RUN dotnet publish ./src/Kestrel/Kestrel.csproj -c Release -o /app

#Expoe os resultados
FROM base AS final
WORKDIR /app

COPY --from=publish /app .
CMD [ "dotnet", "Kestrel.dll" ]