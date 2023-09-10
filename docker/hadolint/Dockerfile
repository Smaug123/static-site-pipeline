FROM hadolint/hadolint:v2.10.0-beta-alpine
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	addgroup -S hugo && adduser -S hugo -G hugo

USER hugo

ENTRYPOINT []
