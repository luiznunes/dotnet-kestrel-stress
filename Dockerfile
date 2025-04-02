FROM grupovoalle/erp-container-base:2.1.30 AS base
WORKDIR /app
EXPOSE 45701/tcp

#SDK donet core 2.1
FROM mcr.microsoft.com/dotnet/sdk:2.1.818 AS build

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