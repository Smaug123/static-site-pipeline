FROM alpine:3.14.2
RUN apk add --no-cache imagemagick=7.0.11.13-r0

COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	mkdir /sentinels && \
	chmod a+rwx /sentinels && \
	addgroup -S pictures && adduser -S pictures -G pictures

USER pictures
WORKDIR /home/pictures

ENTRYPOINT []
