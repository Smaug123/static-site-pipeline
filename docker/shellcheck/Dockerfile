FROM koalaman/shellcheck-alpine:v0.8.0
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	addgroup -S shellcheck && adduser -S shellcheck -G shellcheck

USER shellcheck

ENTRYPOINT []
