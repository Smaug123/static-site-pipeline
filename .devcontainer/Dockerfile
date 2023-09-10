FROM pandoc/latex:2.14.0.1

RUN apk add --no-cache git=2.26.3-r0 texlive=20190410-r13 && \
    tlmgr update --self && \
    tlmgr install tikz-cd && \
    tlmgr install mdframed && \
    # Dependencies of mdframed \
    tlmgr install zref && \
    tlmgr install needspace
