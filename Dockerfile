FROM alpine:latest
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily

RUN set -ex \
	&& mkdir /mnt/nfs \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache openjdk8

ENTRYPOINT [ "crond", "-f" ]
