#!/bin/bash

# sed -i 's/UseZGC/UseG1GC/g' /home/steam/pzserver/ProjectZomboid64.json
screen -R zomboid FEXBash "/home/steam/pzserver/start-server.sh -servername ${SERVERNAME}"
