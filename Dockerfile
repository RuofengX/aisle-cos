FROM ubuntu:latest
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily

##Use Tsinghua source mirror site.
# RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN set -ex \
	&& mkdir /mnt/nfs \
	&& apk add --no-cache openjdk8\
	&& chmod +x /etc/periodic/daily

ENTRYPOINT [ "crond", "-f" ]
