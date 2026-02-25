FROM debian:13-slim

RUN    apt update \
    && apt install -y --no-install-recommends wget gpg \
    && wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | gpg --dearmor > /usr/share/keyrings/kamailio.gpg \
    && echo "deb     [signed-by=/usr/share/keyrings/kamailio.gpg] http://deb.kamailio.org/kamailio60 trixie main" >  /etc/apt/sources.list.d/kamailio.list \
    && echo "deb-src [signed-by=/usr/share/keyrings/kamailio.gpg] http://deb.kamailio.org/kamailio60 trixie main" >> /etc/apt/sources.list.d/kamailio.list \
    && apt update \
    && apt install -y kamailio kamailio-python3-modules

COPY etc/kamailio /etc/kamailio

ENTRYPOINT ["kamailio", "-dDDE", "-u", "kamailio", "-g", "kamailio"]
