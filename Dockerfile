FROM alpine:3

# Install
RUN apk --no-cache add bash curl minidlna tini shadow su-exec alpine-conf inotify-tools

# Entrypoint
COPY ./entrypoint.sh /
RUN ["ls"]
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1
