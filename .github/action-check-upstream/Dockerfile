FROM alpine:latest

RUN apk add --no-cache \
    curl \
    jq \
    rsync \
    tar \
    wget

COPY entrypoint.sh /usr/bin/entrypoint

RUN chmod +x /usr/bin/entrypoint

ENTRYPOINT ["sh", "-c", "/usr/bin/entrypoint"]