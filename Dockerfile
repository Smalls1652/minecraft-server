FROM docker.io/library/ubuntu:22.04

ARG MS_OPENJDK_VERSION="17.0.6"

# Install updates
RUN apt-get update; \
    apt-get upgrade -y

# Install needed packages
RUN apt-get install -y \
    ca-certificates \
    curl \
    iputils-ping

# Remove unneeded packages
RUN apt-get autoremove -y; \
    apt-get clean -y

# Create app directory
WORKDIR /app

# Download Microsoft OpenJDK
RUN mkdir ./jdk ; \
    curl -L "https://aka.ms/download-jdk/microsoft-jdk-${MS_OPENJDK_VERSION}-linux-x64.tar.gz" | tar -xz --directory "./jdk/" --strip-components=1

# Download Minecraft Server
RUN curl "https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar" --output "./minecraft_server.1.19.3.jar"

# Copy entrypoint script
COPY ./entrypoint.sh /app/entrypoint.sh

WORKDIR /app/data

ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]
EXPOSE 25565