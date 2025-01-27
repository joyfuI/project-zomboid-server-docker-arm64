FROM teriyakigod/steamcmd:arm64

ENV SERVERNAME="servertest"
ENV CPU_MHZ=2000

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
  screen \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./scripts/* /home/steam/
RUN chown -R steam:steam /home/steam/*.sh \
  && chmod +x /home/steam/*.sh

USER steam

WORKDIR /home/steam

RUN mkdir -p ./Zomboid \
  && mkdir -p ./pzserver \
  && chown -R steam:steam ./Zomboid \
  && chown -R steam:steam ./pzserver \
  && FEXBash "./Steam/steamcmd.sh +force_install_dir /home/steam/pzserver +login anonymous +app_update 380870 validate +quit"

EXPOSE 16261-16262/udp

# ENTRYPOINT ["FEXBash", "./pzserver/start-server.sh -servername ${SERVERNAME}"]
ENTRYPOINT ["FEXBash", "./Steam/steamcmd.sh +force_install_dir /home/steam/pzserver +login anonymous +app_update 380870 validate"]
