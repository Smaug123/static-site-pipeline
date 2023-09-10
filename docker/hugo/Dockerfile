FROM alpine:3.15.4
RUN apk add --no-cache hugo=0.89.4-r2 git-2.34.8-r0
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	mkdir /sentinels && \
	chmod a+rwx /sentinels && \
	addgroup -S hugo && adduser -S hugo -G hugo

USER hugo

ENTRYPOINT []
