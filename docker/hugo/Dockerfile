FROM alpine:3.14.2
RUN apk add --no-cache hugo=0.83.1-r2 git=2.32.0-r0
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	mkdir /sentinels && \
	chmod a+rwx /sentinels && \
	addgroup -S hugo && adduser -S hugo -G hugo

USER hugo

ENTRYPOINT []
