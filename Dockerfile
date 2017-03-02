FROM alpine:3.5

RUN \
    apk add --no-cache --virtual .build-deps ca-certificates curl xz tar && \
    mkdir -p /opt/goproxy && \
    cd /opt/goproxy && \
    goproxy_vps_loc=$(curl -Lks https://github.com/phuslu/goproxy-ci/releases/ | grep -oE '/phuslu/goproxy-ci/.*/goproxy-vps_linux_amd64-r[0-9]+.tar.xz' | head -1) && \
    curl -L https://github.com${goproxy_vps_loc} | xz -d | tar xvf -
    
ENV GOPROXY_VPS_CONFIG_URL = https://gist.githubusercontent.com/jzp820927/886edc0988e6aba3a9b2b70671cf0d53/raw/f7f4ab742c9473f7b5070e99db9c8526e1146dfa/ecc

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT  sh /entrypoint.sh 

EXPOSE 8443
