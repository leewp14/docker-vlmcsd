FROM alpine:latest as builder
WORKDIR /root
RUN apk add --no-cache git make build-base && \
    git clone --branch master --single-branch https://github.com/Wind4/vlmcsd.git && \
    cd vlmcsd && \
    make

FROM alpine:latest
COPY --from=builder /root/vlmcsd/bin/vlmcsd /vlmcsd
RUN apk add --no-cache tzdata

CMD ["/vlmcsd", "-D", "-d", "-t", "3", "-e", "-v", "-L", "0.0.0.0:${PORT}", "-P", "${PORT}"]
