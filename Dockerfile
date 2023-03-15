FROM docker.io/library/ubuntu:22.04

ARG MS_OPENJDK_VERSION="17.0.6"

# Currently v1.19.4
ARG MC_SERVER_JAR_URL="https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar"

ENV MC_SERVER_INITIAL_HEAP_SIZE="1G"
ENV MC_SERVER_MAX_HEAP_SIZE="1G"

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

# Create minecraft user and group
RUN groupadd -g 1000 minecraft && useradd -u 1000 -g minecraft minecraft

# Set user
USER minecraft

# Create app directory
WORKDIR /app

# Download Microsoft OpenJDK
RUN mkdir ./jdk ; \
    curl -L "https://aka.ms/download-jdk/microsoft-jdk-${MS_OPENJDK_VERSION}-linux-x64.tar.gz" | tar -xz --directory "./jdk/" --strip-components=1

# Download Minecraft Server
RUN curl "${MC_SERVER_JAR_URL}" --output "./minecraft_server.jar"

# Copy entrypoint script
COPY ./entrypoint.sh /app/entrypoint.sh

WORKDIR /app/data

ENTRYPOINT [ "/bin/bash", "/app/entrypoint.sh" ]
EXPOSE 25565