#!/bin/bash

if [[ ! -f /app/data/eula.txt ||  "$EULA" = "true" ]]; then
    echo "Accepting EULA..."
    echo "eula=true" > /app/data/eula.txt
fi

/app/jdk/bin/java -Xmx1024M -Xms1024M -jar /app/minecraft_server.1.19.3.jar nogui