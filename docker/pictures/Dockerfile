FROM alpine:3.15.4
RUN apk add --no-cache imagemagick=7.1.0.16-r0

COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	mkdir /sentinels && \
	chmod a+rwx /sentinels && \
	addgroup -S pictures && adduser -S pictures -G pictures

USER pictures
WORKDIR /home/pictures

ENTRYPOINT []
