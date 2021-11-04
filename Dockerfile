FROM ubuntu:latest
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily

RUN set -ex \
	&& mkdir /mnt/nfs \
	&& apt update \
    && apt install openjdk-17-jre-headless -y \
	&& chmod +x /etc/periodic/daily/startup.sh

ENTRYPOINT [ "crond", "-f" ]
