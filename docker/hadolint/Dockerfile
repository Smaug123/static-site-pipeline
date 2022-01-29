FROM hadolint/hadolint:v2.7.0-alpine@sha256:35cb1dea3061b9ad99562ef74088436b8f739e6389455b15e38be11fd8d6dc65
COPY "build.sh" "/build.sh"

RUN chmod +x /build.sh && \
	addgroup -S hugo && adduser -S hugo -G hugo

USER hugo

ENTRYPOINT []