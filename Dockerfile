FROM openjdk:alpine
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily

RUN set -ex \
	&& mkdir /mnt/nfs

ENTRYPOINT [ "crond", "-f" ]
