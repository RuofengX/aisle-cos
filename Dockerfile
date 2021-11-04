FROM openjdk:alpine
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily/

RUN set -ex \
	&& mv /etc/periodic/daily/startup.sh /etc/periodic/daily/startup \
	&& chmod +x /etc/periodic/daily/startup \
	# To fix bugs like "Error loading shared library ld-linux-x86-64.so.2: No such file or directory". See https://medium.com/devgorilla/node-gyp-support-in-alpine-linux-9374c6191140  \
	&& ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 \
	&& apk add nano \
	&& mkdir /mnt/nfs

ENTRYPOINT [ "crond", "-f" ]
