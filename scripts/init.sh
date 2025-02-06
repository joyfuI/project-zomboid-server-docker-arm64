#!/bin/bash

FEXBash "/home/steam/Steam/steamcmd.sh +force_install_dir /home/steam/pzserver +login anonymous +app_update 380870 validate +quit"
screen -d -m -S zomboid /bin/bash -c ' \
  while true; do \
    # sed -i "s/UseZGC/UseG1GC/g" /home/steam/pzserver/ProjectZomboid64.json; \
    FEXBash "/home/steam/pzserver/start-server.sh -servername ${SERVERNAME}"; \
    echo "The server will restart in 10 seconds. If you want to stop the server, press Ctrl+C."; \
    for i in 10 9 8 7 6 5 4 3 2 1; do echo "$i..."; sleep 1; done \
  done \
'
sleep infinity
