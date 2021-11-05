FROM openjdk:alpine
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

COPY startup.sh /etc/periodic/daily/

RUN set -ex \nux-x86-64.so.2 \
	## install dependence
	&& apk add -U \
	## add timezone support
	&& apk add  tzdata\
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& apk del tzdata \
	## create cron job
	&& mv /etc/periodic/daily/startup.sh /etc/periodic/daily/startup \
	&& chmod +x /etc/periodic/daily/startup \
	## to fix bugs like "Error loading shared library ld-linux-x86-64.so.2: No such file or directory". See https://medium.com/devgorilla/node-gyp-support-in-alpine-linux-9374c6191140  \
	&& apk add libc6-compat \
	## mount related jobs
	&& mkdir /mnt/nfs

ENTRYPOINT [ "crond", "-f" ]
