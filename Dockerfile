FROM teriyakigod/steamcmd:arm64

ENV SERVERNAME="servertest"
ENV CPU_MHZ=2000

USER root

RUN apt update && apt install -y --no-install-recommends \
  screen \
  && apt clean && rm -rf /var/lib/apt/lists/*

COPY ./scripts/* /home/steam/
RUN chown -R steam:steam /home/steam/*.sh \
  && chmod +x /home/steam/*.sh

USER steam

WORKDIR /home/steam

RUN mkdir -p ./pzserver \
  && mkdir -p ./Zomboid \
  && mkdir -p ./pzserver/steamapps/workshop \
  && chown -R steam:steam ./pzserver \
  && chown -R steam:steam ./Zomboid \
  && chown -R steam:steam ./pzserver/steamapps/workshop

EXPOSE 16261-16262/udp

ENTRYPOINT ["./init.sh"]
