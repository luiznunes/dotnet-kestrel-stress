FROM node:10.24.1-alpine3.11 AS node
RUN npm install -g yarn --force

FROM mcr.microsoft.com/dotnet/sdk:2.1.818-alpine3.13 AS base
RUN apk add curl
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# RUN apk add nodejs yarn

# # Ferramenta NODE
# RUN curl -sL https://deb.nodesource.com/setup_10.x |  bash -
# RUN apt-get install -y nodejs

# # Ferramenta YARN
# RUN apt-get update \
#   && apt-get install -y apt-transport-https \
#   && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#   && apt-get update \
#   && apt-get install -y yarn

# FROM mcr.microsoft.com/dotnet/sdk:2.1.818 AS base
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