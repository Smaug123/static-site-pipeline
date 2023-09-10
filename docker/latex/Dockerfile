FROM pandoc/latex:2.18.0.0 AS basic

RUN apk add --no-cache texlive=20210325-r4

# texlive is huuuge and we don't want to keep re-downloading it; don't warn on the repeated RUN command
# hadolint ignore=DL3059
RUN tlmgr update --self && \
    tlmgr install tikz-cd && \
    tlmgr install mdframed && \
    tlmgr install mathtools && \
    # Dependencies of mdframed \
    tlmgr install zref && \
    tlmgr install needspace

FROM basic AS build

COPY "build.sh" "/build.sh"

RUN mkdir /sentinels && \
    chmod a+rwx /sentinels && \
    chmod +x /build.sh && \
    addgroup -S pdftex && adduser -S pdftex -G pdftex

USER pdftex

WORKDIR /home/pdftex

ENTRYPOINT []
