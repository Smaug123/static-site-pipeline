FROM debian:stable-20211011-slim AS builder

ADD https://github.com/validator/validator/releases/download/20.6.30/vnu.linux.zip .
ADD https://github.com/validator/validator/releases/download/20.6.30/vnu.linux.zip.sha1 .
COPY "build.sh" "/build.sh"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install --no-install-recommends -y \
       unzip=6.0-26 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "$(cat vnu.linux.zip.sha1) vnu.linux.zip" | sha1sum -c - \
    && unzip ./vnu.linux.zip \
    && rm ./vnu.linux.zip* \
    && apt-get purge -y --auto-remove unzip \
    && chmod +x /build.sh \
	&& addgroup --gid 1000 hugo && adduser --gid 1000 hugo

USER hugo
