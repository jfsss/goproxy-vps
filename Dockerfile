FROM alpine:3.5

RUN \
    apk add --no-cache --virtual .build-deps ca-certificates curl xz tar && \
    mkdir -p /opt/goproxy && \
    cd /opt/goproxy && \
    goproxy_vps_loc=$(curl -Lks https://github.com/phuslu/goproxy-ci/releases/ | grep -oE '/phuslu/goproxy-ci/.*/goproxy-vps_linux_amd64-r[0-9]+.tar.xz' | head -1) && \
    curl -L https://github.com${goproxy_vps_loc} | xz -d | tar xvf -
    
ENV GOPROXY_VPS_CONFIG_URL = https://pastebin.com/raw/2Les4t6J

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT  sh /entrypoint.sh 

EXPOSE 8443
