FROM alpine:3.13.5

COPY "build.sh" "/build.sh"
RUN chmod +x /build.sh && \
    mkdir /sentinels && \
    chmod a+rwx /sentinels && \
    addgroup -S load && adduser -S load -G load && \
    mkdir /output && \
    chown load /output

USER load

ENTRYPOINT []
