FROM koalaman/shellcheck-alpine:v0.7.2
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	addgroup -S shellcheck && adduser -S shellcheck -G shellcheck

USER shellcheck

ENTRYPOINT []