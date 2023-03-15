#!/bin/bash

if [[ ! -f /app/data/eula.txt ||  "$EULA" = "true" ]]; then
    echo "Accepting EULA..."
    echo "eula=true" > /app/data/eula.txt
fi

/app/jdk/bin/java -Xmx$MC_SERVER_MAX_HEAP_SIZE -Xms$MC_SERVER_INITIAL_HEAP_SIZE -jar "/app/minecraft_server.jar" nogui