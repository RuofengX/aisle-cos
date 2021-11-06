FROM openjdk:17-alpine
LABEL maintainer="WeiRuofeng <weiruofeng@ruofengx.cn>"

ENV TZ=Asia/Shanghai

COPY startup.sh /etc/periodic/daily/

RUN set -ex \
	## install dependence
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk add -U \
	## add timezone support
	&& apk add tzdata \
	## create cron job
	&& mv /etc/periodic/daily/startup.sh /etc/periodic/daily/startup \
	&& chmod +x /etc/periodic/daily/startup \
	## to fix bugs like "Error loading shared library ld-linux-x86-64.so.2: No such file or directory". See https://medium.com/devgorilla/node-gyp-support-in-alpine-linux-9374c6191140  \
	&& apk add libc6-compat \
	## mount related jobs
	&& mkdir /mnt/nfs
	
ENTRYPOINT [ "crond", "-f" ]
